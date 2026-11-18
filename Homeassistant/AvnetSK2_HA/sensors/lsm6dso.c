/**
 ******************************************************************************
* @file    lsm6dso.c
* @author  jschwert@microsoft.com
* @brief   This file show the simplest way to detect orientation 6D/4D event
*      from sensor.
*
*/

//#define VERBOSE 1


/* Includes ------------------------------------------------------------------*/
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <memory.h>

#include "lsm6dso/lsm6dso_reg.h"
#include "lps22hh/lps22hh_reg.h"
#include "lsm6dso_internal.h"
#include "lps22hh_internal.h"
#include "sensors.h"

#include <applibs/log.h>
#include <applibs/i2c.h>

#define    BOOT_TIME      10

/* Self test limits. */
#define    MIN_ST_LIMIT_mg        50.0f
#define    MAX_ST_LIMIT_mg      1700.0f
#define    MIN_ST_LIMIT_mdps   150000.0f
#define    MAX_ST_LIMIT_mdps   700000.0f

/* Self test results. */
#define    ST_PASS     1U
#define    ST_FAIL     0U

/* Private macro -------------------------------------------------------------*/
typedef struct _vector3d_uint16 {
  int16_t x;
  int16_t y;
  int16_t z;
} vector3d_uint16_t;

/* Private variables ---------------------------------------------------------*/
bool  isLsm6dsoReady = false;
//static uint8_t whoamI, rst;
//static uint8_t tx_buffer[1000];

// float angular_rate_mdps[3];
// float acceleration_mg[3];
// float fTemperatureLSM6DSO_degC;

stmdev_ctx_t lsm6dso_ctx = { 
    .write_reg = platform_write,
    .read_reg = platform_read 
};

static const float fCos30Deg = 0.850f * 1000.0f; // normally 0.866; a bit less to allow measurement errors
static const float fCos60Deg = 0.5 * 1000.0f;
static const float fZero = 0.0f;


/* Extern variables ----------------------------------------------------------*/

/* Private functions ---------------------------------------------------------*/

/**
 * @brief Converts a 3D acceleration vector into textual orientation (e.g. "face up"). 
 * 
 * @param pVector pointer to 3D vector 
 * @return const char* 
 */
const char *lsm6dso_get_orientation( vector3d_t * pVector )
{ register float x = pVector->x;
  register float y = pVector->y;
  register float z = pVector->z;

  // the length of the acceleration vector should be around 1.0 for a steady device 
  float l = sqrtf( x*x + y*y + z*z);
  if( l > 1200.0f){
    return "accelerating";
  }
  if( l < 800.0f ){
    return "falling";
  }

  // filter out the edges (less than 30° tilted in each direction)
  if( z > fCos30Deg ) { 
    return "face up"; 
  } else if ( z < -fCos30Deg ){
    return "face down";
  } else if ( x > fCos30Deg ) {
    return "left edge";
  } else if ( x < -fCos30Deg ) {
    return "right edge";
  } else if ( y > fCos30Deg ) {
    return "back edge";
  } else if ( y < -fCos30Deg ) {
    return "front edge";
  } else if( z > fCos60Deg ) { 

    // face up tilted z in 30° - 60°
    if(  y < -fCos60Deg){
      return "tilted forward";
    } else if ( y > fCos60Deg ){
      return "tilted backward";
    } else if( x > fCos60Deg ){
      return "tilted left";
    } else if( x < -fCos60Deg ){
      return "tilted right";
    } else if( x > fZero ){
        if( y < fZero ){
          return "tilted left forward";
        } else {
          return "tilted left backward";
        }
    } else {
      if( y < fZero ){
        return "tilted right forward";
      } else {
        return "tilted right backward";
      }
    }

  } else if (z > -fCos60Deg) { // z in face up 60°..90° or face down 90°..120°; x & y are less than 60°
      if( x > fZero ){
        if ( y < fZero ) {
          return "front left corner";
        } else {
          return "back left corner";
        }
      } else {
        if ( y < fZero ) {
          return "front right corner";
        } else {
          return "back right corner";
        }
      }
  } else if ( z > -fCos30Deg ) { 
    
    // z is facedown tilted 30°..60°
   // face up tilted z in 30° - 60°
    if(  y < -fCos60Deg){
      return "face down tilted forward";
    } else if ( y > fCos60Deg ){
      return "face down tilted backward";
    } else if( x > fCos60Deg ){
      return "face down tilted right";
    } else if( x < -fCos60Deg ){
      return "face down tilted left";
    } else if( x > fZero ){
        if( y < fZero ){
          return "face down tilted right forward";
        } else {
          return "face down tilted right backward";
        }
    } else {
      if( y < fZero ){
        return "face down tilted left forward";
      } else {
        return "face down tilted left backward";
      }
    }
  }
  
  return "Oops, feeling dizzy";
}



/**
 * @brief take a few accelerometer readings to stabilize the sensor
 * 
 * @return true 
 * @return false 
 */
bool lsm6dso_calibrate_accelerometer( void )
{ uint8_t drdy;
  int16_t data_raw[3];

  /* Read 10 samples to stabilize */
  for (int i = 0; i < 10; i++) {
    /* Check if new value available */
    do {
      lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
    } while (!drdy);

    lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw);

#ifdef VERBOSE
    float x,y,z,l;
    /* Convert to mg and normalize to 1.0 and get vector length (should be ~1.0) at some point  */
    x = lsm6dso_from_fs4_to_mg(data_raw[0]) / 1000.0f;
    y = lsm6dso_from_fs4_to_mg(data_raw[1]) / 1000.0f;
    z = lsm6dso_from_fs4_to_mg(data_raw[2]) / 1000.0f;
    l = sqrt( x*x + y*y + z*z);
    Log_Debug( "XL startup: %5.3f  %5.3f  %5.3f Length: %5.3f\n", x,y,z,l );
#endif
  }
  return true;
}


/**
 * @brief initialize accelerometer for 26Hz, 5G with filters 
 * 
 */
void lsm6dso_start_accelerometer( void )
{
  	 // Set Output Data Rate
	lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_26Hz);

	 // Set full scale
	lsm6dso_xl_full_scale_set(&lsm6dso_ctx, LSM6DSO_4g);

	 // Configure filtering chain(No aux interface)
	// Accelerometer - LPF1 + LPF2 path	
	lsm6dso_xl_hp_path_on_out_set(&lsm6dso_ctx, LSM6DSO_LP_ODR_DIV_10);
	lsm6dso_xl_filter_lp2_set(&lsm6dso_ctx, PROPERTY_ENABLE);

  lsm6dso_calibrate_accelerometer();
}

/**
 * @brief initialize gyro for 12.5 Hz bis 2000dps
 * 
 */
void lsm6dso_start_gyro( void )
{
  	 // Set Output Data Rate
	lsm6dso_gy_data_rate_set(&lsm6dso_ctx, LSM6DSO_GY_ODR_12Hz5);
	 // Set full scale
	lsm6dso_gy_full_scale_set(&lsm6dso_ctx, LSM6DSO_2000dps);
}


void lsm6dso_selftest( void )
{
  //uint8_t tx_buffer[1000];
  int16_t data_raw[3];
  float val_st_off[3];
  float val_st_on[3];
  float test_val[3];
  uint8_t st_result;
  uint8_t drdy;
  uint8_t i;
  uint8_t j;
  /*
   * Accelerometer Self Test
   */
  /* Set Output Data Rate */
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_52Hz);
  /* Set full scale */
  lsm6dso_xl_full_scale_set(&lsm6dso_ctx, LSM6DSO_4g);
  /* Wait stable output */
  platform_delay(100);

  /* Check if new value available */
  do {
    lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
  } while (!drdy);

  /* Read dummy data and discard it */
  lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw);
  /* Read 5 sample and get the average vale for each axis */
  memset(val_st_off, 0x00, 3 * sizeof(float));

  for (i = 0; i < 5; i++) {
    /* Check if new value available */
    do {
      lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
    } while (!drdy);

    /* Read data and accumulate the mg value */
    lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw);

#ifdef VERBOSE
    Log_Debug( "XL test: %d %d %d\n", data_raw[0], data_raw[1], data_raw[2] );
#endif

    for (j = 0; j < 3; j++) {
      val_st_off[j] += lsm6dso_from_fs4_to_mg(data_raw[j]);
    }
  }

  /* Calculate the mg average values */
  for (i = 0; i < 3; i++) {
    val_st_off[i] /= 5.0f;
  }

  /* Enable Self Test positive (or negative) */
  lsm6dso_xl_self_test_set(&lsm6dso_ctx, LSM6DSO_XL_ST_NEGATIVE);
  //lsm6dso_xl_self_test_set(&lsm6dso_ctx, LSM6DSO_XL_ST_POSITIVE);
  /* Wait stable output */
  platform_delay(100);

  /* Check if new value available */
  do {
    lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
  } while (!drdy);

  /* Read dummy data and discard it */
  lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw);
  /* Read 5 sample and get the average vale for each axis */
  memset(val_st_on, 0x00, 3 * sizeof(float));

  for (i = 0; i < 5; i++) {
    /* Check if new value available */
    do {
      lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
    } while (!drdy);

    /* Read data and accumulate the mg value */
    lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw);

#ifdef VERBOSE
    Log_Debug( "XL test: %d %d %d\n", data_raw[0], data_raw[1], data_raw[2] );
#endif

    for (j = 0; j < 3; j++) {
      val_st_on[j] += lsm6dso_from_fs4_to_mg(data_raw[j]);
    }
  }

  /* Calculate the mg average values */
  for (i = 0; i < 3; i++) {
    val_st_on[i] /= 5.0f;
  }

  /* Calculate the mg values for self test */
  for (i = 0; i < 3; i++) {
    test_val[i] = fabsf((val_st_on[i] - val_st_off[i]));
  }

  /* Check self test limit */
  st_result = ST_PASS;

  for (i = 0; i < 3; i++) {
    if (( MIN_ST_LIMIT_mg > test_val[i] ) ||
        ( test_val[i] > MAX_ST_LIMIT_mg)) {
      st_result = ST_FAIL;
    }
  }

  /* Disable Self Test */
  lsm6dso_xl_self_test_set(&lsm6dso_ctx, LSM6DSO_XL_ST_DISABLE);
  /* Disable sensor. */
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_OFF);
  /*
   * Gyroscope Self Test
   */
  /* Set Output Data Rate */
  lsm6dso_gy_data_rate_set(&lsm6dso_ctx, LSM6DSO_GY_ODR_208Hz);
  /* Set full scale */
  lsm6dso_gy_full_scale_set(&lsm6dso_ctx, LSM6DSO_2000dps);
  /* Wait stable output */
  platform_delay(100);

  /* Check if new value available */
  do {
    lsm6dso_gy_flag_data_ready_get(&lsm6dso_ctx, &drdy);
  } while (!drdy);

  /* Read dummy data and discard it */
  lsm6dso_angular_rate_raw_get(&lsm6dso_ctx, data_raw);
  /* Read 5 sample and get the average vale for each axis */
  memset(val_st_off, 0x00, 3 * sizeof(float));

  for (i = 0; i < 5; i++) {
    /* Check if new value available */
    do {
      lsm6dso_gy_flag_data_ready_get(&lsm6dso_ctx, &drdy);
    } while (!drdy);

    /* Read data and accumulate the mg value */
    lsm6dso_angular_rate_raw_get(&lsm6dso_ctx, data_raw);

#ifdef VERBOSE
    Log_Debug( "GY test: %d %d %d\n", data_raw[0], data_raw[1], data_raw[2] );
#endif

    for (j = 0; j < 3; j++) {
      val_st_off[j] += lsm6dso_from_fs2000_to_mdps(data_raw[j]);
    }
  }

  /* Calculate the mg average values */
  for (i = 0; i < 3; i++) {
    val_st_off[i] /= 5.0f;
  }

  /* Enable Self Test positive (or negative) */
  lsm6dso_gy_self_test_set(&lsm6dso_ctx, LSM6DSO_GY_ST_POSITIVE);
  //lsm6dso_gy_self_test_set(&lsm6dso_ctx, LIS2DH12_GY_ST_NEGATIVE);
  /* Wait stable output */
  platform_delay(100);
  /* Read 5 sample and get the average vale for each axis */
  memset(val_st_on, 0x00, 3 * sizeof(float));

  for (i = 0; i < 5; i++) {
    /* Check if new value available */
    do {
      lsm6dso_gy_flag_data_ready_get(&lsm6dso_ctx, &drdy);
    } while (!drdy);

    /* Read data and accumulate the mg value */
    lsm6dso_angular_rate_raw_get(&lsm6dso_ctx, data_raw);

#ifdef VERBOSE
    Log_Debug( "GY test: %d %d %d\n", data_raw[0], data_raw[1], data_raw[2] );
#endif

    for (j = 0; j < 3; j++) {
      val_st_on[j] += lsm6dso_from_fs2000_to_mdps(data_raw[j]);
    }
  }

  /* Calculate the mg average values */
  for (i = 0; i < 3; i++) {
    val_st_on[i] /= 5.0f;
  }

  /* Calculate the mg values for self test */
  for (i = 0; i < 3; i++) {
    test_val[i] = fabsf((val_st_on[i] - val_st_off[i]));
  }

  /* Check self test limit */
  for (i = 0; i < 3; i++) {
    if (( MIN_ST_LIMIT_mdps > test_val[i] ) ||
        ( test_val[i] > MAX_ST_LIMIT_mdps)) {
      st_result = ST_FAIL;
    }
  }

  /* Disable Self Test */
  lsm6dso_gy_self_test_set(&lsm6dso_ctx, LSM6DSO_GY_ST_DISABLE);
  /* Disable sensor. */
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_GY_ODR_OFF);

  if (st_result == ST_PASS) {
    Log_Debug(  "[lsm6dso] Self Test - PASS\n" );
  }

  else {
    Log_Debug(  "[lsm6dso] Self Test - FAIL\n" );
  }

}

/**
 * @brief check if lsm6dso is connected and operable. Accelerometer and gyro are off!
 * 
 * @param fd file descriptor for i2C bus
 * @return true 
 * @return false 
 */
bool lsm6dso_init(int fd)
{
  int nTimeout=100;
  uint8_t whoamI, rst;
  isLsm6dsoReady = false;
  lsm6dso_ctx.handle = (void *) fd;

  /* Check device ID. */
  lsm6dso_device_id_get(&lsm6dso_ctx, &whoamI);
  if (whoamI != LSM6DSO_ID){
    Log_Debug("[LSM6DSO] ERROR: Sensor not found.");
    return false;
  }

  /* Restore default configuration. */
  lsm6dso_reset_set(&lsm6dso_ctx, PROPERTY_ENABLE);
  do {
    lsm6dso_reset_get(&lsm6dso_ctx, &rst);
    platform_delay(1);
  } while ( (rst != 0) && (nTimeout-->0));

  if( nTimeout <= 0)
  { // LSM6DSO did not reset in time.
    Log_Debug("[LSM6DSO] ERROR: Timeout on sensor reset.");
    return false;
  }
 	 // Disable I3C interface
	lsm6dso_i3c_disable_set(&lsm6dso_ctx, LSM6DSO_I3C_DISABLE);

	// Enable Block Data Update
	lsm6dso_block_data_update_set(&lsm6dso_ctx, PROPERTY_ENABLE);

	 // Set Output Data Rate
	lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_OFF);
	lsm6dso_gy_data_rate_set(&lsm6dso_ctx, LSM6DSO_GY_ODR_OFF);

  // Enable pull up on master I2C interface.
  lsm6dso_sh_pin_mode_set(&lsm6dso_ctx, LSM6DSO_INTERNAL_PULL_UP);
  isLsm6dsoReady = true;
  return true;
}


bool lsm6dso_read_acceleration( vector3d_t * pAcceleration )
{ 
  if( pAcceleration != NULL)
  {
    uint8_t drdy;
    int16_t nTimeout = 500;
    int16_t data_raw_acceleration[3];
    memset( &data_raw_acceleration, 0x00, sizeof(data_raw_acceleration));
    
    /* Read dummy data and discard it */
//    lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw_acceleration);

    do {
      lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
    } while ( !drdy && (nTimeout-->0));

    // sensor didn't react in time
    if( nTimeout<=0 ){
      Log_Debug("[LSM6DSO]: ERROR, reading acceleration timed out.\n" );
      return false;
    }

    if( lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw_acceleration) == LSM6DSO_OK ){

      pAcceleration->x = lsm6dso_from_fs4_to_mg( data_raw_acceleration[0]);
      pAcceleration->y = lsm6dso_from_fs4_to_mg( data_raw_acceleration[1]);
      pAcceleration->z = lsm6dso_from_fs4_to_mg( data_raw_acceleration[2]);

      Log_Debug("[LSM6DSO]: Acceleration [mg]  :%4.1f  %4.1f  %4.1f\r\n",
                pAcceleration->x, pAcceleration->y, pAcceleration->z);
      return true;
    }
  }
  return false;
}

bool lsm6dso_read_gyro( vector3d_t * pGyro )
{ 
  if( pGyro != NULL)
  {   int16_t data_raw_angular_rate[3];

    memset( &data_raw_angular_rate, 0x00, sizeof(data_raw_angular_rate));
    if ( lsm6dso_angular_rate_raw_get(&lsm6dso_ctx, data_raw_angular_rate) == LSM6DSO_OK)
    {
      pGyro->x = lsm6dso_from_fs2000_to_mdps( data_raw_angular_rate[0]);
      pGyro->x = lsm6dso_from_fs2000_to_mdps( data_raw_angular_rate[1]);
      pGyro->x = lsm6dso_from_fs2000_to_mdps( data_raw_angular_rate[2]);

      Log_Debug("[LSM6DSO]: Angular rate [mdps]:%4.2f  %4.2f  %4.2f\r\n",
                pGyro->x, pGyro->y, pGyro->z);

      return true;
    }
  }
  return false;
}

bool lsm6dso_read_chiptemp( float * pTemp )
{ 
  if( pTemp != NULL)
  { int16_t data_raw_temperature;

	  if( lsm6dso_temperature_raw_get(&lsm6dso_ctx, &data_raw_temperature) == LSM6DSO_OK)
    {
		  *pTemp = lsm6dso_from_lsb_to_celsius(data_raw_temperature);

      Log_Debug("[LSM6DSO] Temperature  [degC]: %.2f\r\n", *pTemp);
      return true;
    }
  }
  return false;
}

/**
 * @brief  Write generic device register (platform dependent)
 *
 * @param  handle    customizable argument. In this examples is used in
 *                   order to select the correct sensor bus handler.
 * @param  reg       register to write
 * @param  bufp      pointer to data to write in register reg
 * @param  len       number of consecutive register to write
 *
 */
int32_t platform_write(void *handle, uint8_t reg,
                              const uint8_t *bufp,
                              uint16_t len)
{
  ssize_t rslt = -1;
  if (handle != NULL) {

    size_t len2 = (size_t)len + 1;
    uint8_t *buf = malloc(len2);

    if (buf != NULL)
    {
      buf[0] = reg;
      memcpy(buf + 1, bufp, (size_t)len);

#ifdef VERBOSE
      Log_Debug("[LSM6DSO] Write reg 0x%0.2x :", (unsigned int)buf[0]);
      for (ssize_t i = 1; i < len2; i++)
      {
        Log_Debug(" %0.2x", (unsigned int)buf[i]);
      }
      Log_Debug("\n");
#endif

      rslt = I2CMaster_Write((int) handle, (I2C_DeviceAddress) 0x6A, buf, len2);
      
      free(buf);
    }
  }
  return (rslt != -1) ? 0 : -1;
}

/**
 * @brief  Read generic device register (platform dependent)
 *
 * @param  handle    customizable argument. In this examples is used in
 *                   order to select the correct sensor bus handler.
 * @param  reg       register to read
 * @param  bufp      pointer to buffer that store the data read
 * @param  len       number of consecutive register to read
 *
 */
int32_t platform_read(void *handle, uint8_t reg, uint8_t *bufp,
                             uint16_t len)
{
  ssize_t nRead = -1;

  if (handle != NULL) {
      //ssize_t nRead = I2CMaster_WriteThenRead( (int) handle, (I2C_DeviceAddress) LSM6DSO_I2C_ADD_L, &reg, sizeof(uint8_t), bufp, len);
      nRead = I2CMaster_WriteThenRead( (int) handle, (I2C_DeviceAddress) 0x6A, &reg, sizeof(uint8_t), bufp, len);

#ifdef VERBOSE
    Log_Debug("[LSM6DSO] Read reg 0x%0.2x :", (unsigned int)reg);
    for (ssize_t i = 0; i < len; i++)
    {
      Log_Debug(" %0.2x", (unsigned int) bufp[i]);
    }
    Log_Debug("\n");
#endif

  }

  return (nRead != -1) ? 0 : -1;
}



/**
 * @brief  platform specific delay (platform dependent)
 *
 * @param  ms        delay in ms
 *
 */
void platform_delay(uint32_t ms)
{
  struct timespec t = { 0, (long)ms * 1000l };
  nanosleep(&t, NULL);
}

/**
 * @brief  Write lps22hh device register (used by configuration functions)
 *
 * @param  handle    customizable argument. In this examples is used in
 *                   order to select the correct sensor bus handler.
 * @param  reg       register to write
 * @param  bufp      pointer to data to write in register reg
 * @param  len       number of consecutive register to write
 *
 */
int32_t lsm6dso_write_lps22hh_cx(void *ctx, uint8_t reg,
                                 const uint8_t *data, uint16_t len)
{
  int16_t data_raw_acceleration[3];
  int32_t ret;
  uint8_t drdy;
  lsm6dso_status_master_t master_status;
  lsm6dso_sh_cfg_write_t sh_cfg_write;
  /* Configure Sensor Hub to read LPS22HH. */
  sh_cfg_write.slv0_add = (LPS22HH_I2C_ADD_L & 0xFEU) >>
                          1; /* 7bit I2C address */
  sh_cfg_write.slv0_subadd = reg,
  sh_cfg_write.slv0_data = *data,

#ifdef VERBOSE
      Log_Debug("[LPS22HH] Write reg 0x%0.2x :", reg);
      for (ssize_t i = 1; i < len; i++)
      {
        Log_Debug(" %0.2x", (unsigned int)data[i]);
      }
      Log_Debug("\n");
#endif

  ret = lsm6dso_sh_cfg_write(&lsm6dso_ctx, &sh_cfg_write);
  /* Disable accelerometer. */
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_OFF);
  /* Enable I2C Master. */
  lsm6dso_sh_master_set(&lsm6dso_ctx, PROPERTY_ENABLE);
  /* Enable accelerometer to trigger Sensor Hub operation. */
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_104Hz);
  /* Wait Sensor Hub operation flag set. */
  lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw_acceleration);

  do {
    platform_delay(20);
    lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
  } while (!drdy);

  do {
    platform_delay(20);
    lsm6dso_sh_status_get(&lsm6dso_ctx, &master_status);
  } while (!master_status.sens_hub_endop);

  /* Disable I2C master and re-enable XL. */
  lsm6dso_sh_master_set(&lsm6dso_ctx, PROPERTY_DISABLE);
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_26Hz);
  return ret;
}

/**
 * @brief  Read lps22hh device register (used by configuration functions)
 *
 * @param  handle    customizable argument. In this examples is used in
 *                   order to select the correct sensor bus handler.
 * @param  reg       register to read
 * @param  bufp      pointer to buffer that store the data read
 * @param  len       number of consecutive register to read
 *
 */
int32_t lsm6dso_read_lps22hh_cx(void *ctx, uint8_t reg,
                                uint8_t *data,
                                uint16_t len)
{
  lsm6dso_sh_cfg_read_t sh_cfg_read;
  int16_t data_raw_acceleration[3];
  int32_t ret;
  uint8_t drdy;
  lsm6dso_status_master_t master_status;
  /* Disable accelerometer. */
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_OFF);
  /* Configure Sensor Hub to read LPS22HH. */
  sh_cfg_read.slv_add = (LPS22HH_I2C_ADD_L & 0xFEU) >>
                        1; /* 7bit I2C address */
  sh_cfg_read.slv_subadd = reg;
  sh_cfg_read.slv_len = (uint8_t)len;
  ret = lsm6dso_sh_slv0_cfg_read(&lsm6dso_ctx, &sh_cfg_read);
  lsm6dso_sh_slave_connected_set(&lsm6dso_ctx, LSM6DSO_SLV_0);
  /* Enable I2C Master and I2C master. */
  lsm6dso_sh_master_set(&lsm6dso_ctx, PROPERTY_ENABLE);
  /* Enable accelerometer to trigger Sensor Hub operation. */
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_104Hz);
  /* Wait Sensor Hub operation flag set. */
  lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw_acceleration);

  do {
    platform_delay(20);
    lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
  } while (!drdy);

  do {
    //HAL_Delay(20);
    lsm6dso_sh_status_get(&lsm6dso_ctx, &master_status);
  } while (!master_status.sens_hub_endop);

  /* Disable I2C master and XL(trigger). */
  lsm6dso_sh_master_set(&lsm6dso_ctx, PROPERTY_DISABLE);
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_OFF);
  /* Read SensorHub registers. */
  lsm6dso_sh_read_data_raw_get(&lsm6dso_ctx, data, (uint8_t)len);

#ifdef VERBOSE
    Log_Debug("[LPS22HH] Read reg 0x%0.2x :", (unsigned int)reg);
    for (ssize_t i = 0; i < len; i++)
    {
      Log_Debug(" %0.2x", (unsigned int) data[i]);
    }
    Log_Debug("\n");
#endif

  // re-enable XL
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_26Hz);
  return ret;
}
