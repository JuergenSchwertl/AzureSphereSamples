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

#include <applibs/log.h>
#include <applibs/i2c.h>


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

float angular_rate_mdps[3];
float acceleration_mg[3];
float fTemperatureLSM6DSO_degC;

stmdev_ctx_t lsm6dso_ctx = { 
    .write_reg = platform_write,
    .read_reg = platform_read 
};

/* Extern variables ----------------------------------------------------------*/

/* Private functions ---------------------------------------------------------*/




/**
 * @brief check if lsm6dso is connected and operable
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
	lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_12Hz5);
	lsm6dso_gy_data_rate_set(&lsm6dso_ctx, LSM6DSO_GY_ODR_12Hz5);

	 // Set full scale
	lsm6dso_xl_full_scale_set(&lsm6dso_ctx, LSM6DSO_2g);
	lsm6dso_gy_full_scale_set(&lsm6dso_ctx, LSM6DSO_2000dps);

	 // Configure filtering chain(No aux interface)
	// Accelerometer - LPF1 + LPF2 path	
	lsm6dso_xl_hp_path_on_out_set(&lsm6dso_ctx, LSM6DSO_LP_ODR_DIV_100);
	lsm6dso_xl_filter_lp2_set(&lsm6dso_ctx, PROPERTY_ENABLE);
  

  // Enable pull up on master I2C interface.
  lsm6dso_sh_pin_mode_set(&lsm6dso_ctx, LSM6DSO_INTERNAL_PULL_UP);
  isLsm6dsoReady = true;
  return true;
}

/**
 * @brief reads the complete lsm6dso dataset with accel, gyro & (chip) temp
 * 
 */
bool lsm6dso_read_dataset( void )
{
  uint8_t reg;
  //p_and_t_byte_t data_raw_press_temp;
  axis3bit16_t data_raw_acceleration;
  axis3bit16_t data_raw_angular_rate;
  axis1bit16_t data_raw_temperature;
  
  if( !isLsm6dsoReady )
  {
    if( !lsm6dso_init( (int) lsm6dso_ctx.handle ) )
    {
      return false;
    }
  }

  //Read output only if new xl value is available
  lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &reg);
  if( reg ){
    memset(data_raw_acceleration.u8bit, 0x00, 3 * sizeof(int16_t));
    lsm6dso_fifo_out_raw_get(&lsm6dso_ctx, data_raw_acceleration.u8bit);
    acceleration_mg[0] = lsm6dso_from_fs2_to_mg(
                            data_raw_acceleration.i16bit[0]);
    acceleration_mg[1] = lsm6dso_from_fs2_to_mg(
                            data_raw_acceleration.i16bit[1]);
    acceleration_mg[2] = lsm6dso_from_fs2_to_mg(
                            data_raw_acceleration.i16bit[2]);
    Log_Debug("[LSM6DSO]: Acceleration [mg]:%4.2f\t%4.2f\t%4.2f\r\n",
              acceleration_mg[0],
              acceleration_mg[1],
              acceleration_mg[2] );
  }

  lsm6dso_gy_flag_data_ready_get(&lsm6dso_ctx, &reg);
	if (reg)
	{
    memset(data_raw_angular_rate.u8bit, 0x00, 3 * sizeof(int16_t));
    lsm6dso_fifo_out_raw_get(&lsm6dso_ctx, data_raw_angular_rate.u8bit);
    angular_rate_mdps[0] = lsm6dso_from_fs2000_to_mdps(
                              data_raw_angular_rate.i16bit[0]);
    angular_rate_mdps[1] = lsm6dso_from_fs2000_to_mdps(
                              data_raw_angular_rate.i16bit[1]);
    angular_rate_mdps[2] = lsm6dso_from_fs2000_to_mdps(
                              data_raw_angular_rate.i16bit[2]);
    Log_Debug("[LSM6DSO]:Angular rate [mdps]:%4.2f\t%4.2f\t%4.2f\r\n",
              angular_rate_mdps[0],
              angular_rate_mdps[1],
              angular_rate_mdps[2]);
  }

  lsm6dso_temp_flag_data_ready_get(&lsm6dso_ctx, &reg);
	if (reg)
	{
		// Read temperature data
		memset(data_raw_temperature.u8bit, 0x00, sizeof(int16_t));
		lsm6dso_temperature_raw_get(&lsm6dso_ctx, &data_raw_temperature.i16bit);
		fTemperatureLSM6DSO_degC = lsm6dso_from_lsb_to_celsius(data_raw_temperature.i16bit);

		Log_Debug("[LSM6DSO]: Temperature  [degC]: %.2f\r\n", fTemperatureLSM6DSO_degC);
	} 

  lps22hh_read_dataset();
	return true;
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
  axis3bit16_t data_raw_acceleration;
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
  lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw_acceleration.i16bit);

  do {
    platform_delay(20);
    lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &drdy);
  } while (!drdy);

  do {
    platform_delay(20);
    lsm6dso_sh_status_get(&lsm6dso_ctx, &master_status);
  } while (!master_status.sens_hub_endop);

  /* Disable I2C master and XL (trigger). */
  lsm6dso_sh_master_set(&lsm6dso_ctx, PROPERTY_DISABLE);
  lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_OFF);
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
  axis3bit16_t data_raw_acceleration;
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
  lsm6dso_acceleration_raw_get(&lsm6dso_ctx, data_raw_acceleration.i16bit);

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

  return ret;
}
