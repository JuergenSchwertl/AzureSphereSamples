/*
 ******************************************************************************
 * @file    orientation_6d_4d.c
 * @author  Sensors Software Solution Team
 * @brief   This file show the simplest way to detect orientation 6D/4D event
 *      from sensor.
 *
 ******************************************************************************
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under BSD 3-Clause license,
 * the "License"; You may not use this file except in compliance with the
 * License. You may obtain a copy of the License at:
 *                        opensource.org/licenses/BSD-3-Clause
 *
 ******************************************************************************
 */

#define VERBOSE 1

/* Includes ------------------------------------------------------------------*/
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <memory.h>

#include "lsm6dso_reg.h"
#include "Inc/lsm6dso.h" 

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
static uint8_t whoamI, rst;
//static uint8_t tx_buffer[1000];



/* Extern variables ----------------------------------------------------------*/

/* Private functions ---------------------------------------------------------*/

/*
 *   WARNING:
 *   Functions declare in this section are defined at the end of this file
 *   and are strictly related to the hardware platform used.
 *
 */
static int32_t platform_write(void *handle, uint8_t reg,
                              uint8_t *bufp,
                              uint16_t len);
static int32_t platform_read(void *handle, uint8_t reg, uint8_t *bufp,
                             uint16_t len);
static void platform_delay(uint32_t ms);

static stmdev_ctx_t dev_ctx = { 
    .write_reg = platform_write,
    .read_reg = platform_read 
};


/* Public Functions  ---------------------------------------------------------*/

/// <summary>
///     Checks if LSM6DSO is availabel and resets sensor
/// </summary>
/// <param name="temperature">pointer to temperature output</param>
/// <returns>true if temperature was read successfully</returns>
bool LSM6DSO_Init(int fd)
{
  int nTimeout=255;
  isLsm6dsoReady = false;
  dev_ctx.handle = (void *) fd;

  /* Check device ID. */
  lsm6dso_device_id_get(&dev_ctx, &whoamI);
  if (whoamI != LSM6DSO_ID){
    Log_Debug("[LSM6DSO] ERROR: Sensor not found.");
    return false;
  }

  /* Restore default configuration. */
  lsm6dso_reset_set(&dev_ctx, PROPERTY_ENABLE);
  do {
    lsm6dso_reset_get(&dev_ctx, &rst);
    platform_delay(1);
  } while ( (rst != 0) && (nTimeout-->0));

  if( nTimeout <= 0)
  { // LSM6DSO did not reset in time.
    Log_Debug("[LSM6DSO] ERROR: Timeout on sensor reset.");
    return false;
  }
 	 // Disable I3C interface
	lsm6dso_i3c_disable_set(&dev_ctx, LSM6DSO_I3C_DISABLE);

	// Enable Block Data Update
	lsm6dso_block_data_update_set(&dev_ctx, PROPERTY_ENABLE);

	 // Set Output Data Rate
	lsm6dso_xl_data_rate_set(&dev_ctx, LSM6DSO_XL_ODR_12Hz5);
	lsm6dso_gy_data_rate_set(&dev_ctx, LSM6DSO_GY_ODR_12Hz5);

	 // Set full scale
	lsm6dso_xl_full_scale_set(&dev_ctx, LSM6DSO_4g);
	lsm6dso_gy_full_scale_set(&dev_ctx, LSM6DSO_2000dps);

	 // Configure filtering chain(No aux interface)
	// Accelerometer - LPF1 + LPF2 path	
	lsm6dso_xl_hp_path_on_out_set(&dev_ctx, LSM6DSO_LP_ODR_DIV_100);
	lsm6dso_xl_filter_lp2_set(&dev_ctx, PROPERTY_ENABLE);

  isLsm6dsoReady = true;
  return true;
}


/// <summary>
///     Reads the temperature from the LSM6DSO
/// </summary>
/// <param name="pfTemperature">pointer to temperature output</param>
/// <returns>true if temperature was read successfully</returns>
bool LSM6DSO_GetTemperature(float *pfTemperature)
{
  uint8_t isDataAvailable;

  if( (!isLsm6dsoReady) && (pfTemperature == NULL) )
  {
    return false;
  }

  lsm6dso_temp_flag_data_ready_get(&dev_ctx, &isDataAvailable);
  if (isDataAvailable)
  {
    // Read temperature data
    int16_t data_raw_temperature;
    lsm6dso_temperature_raw_get(&dev_ctx, (uint8_t *) &data_raw_temperature);
    *pfTemperature = lsm6dso_from_lsb_to_celsius(data_raw_temperature);

    Log_Debug("LSM6DSO: Temperature1 [degC]: %.2f\r\n", *pfTemperature);
    return true;
  }

  return false;
}

/// <summary>
///     Reads the acceleration vector from the LSM6DSO
/// </summary>
/// <param name="pvecAcceleration">pointer to 3d acceleration vector</param>
/// <returns>true if acceleration was read successfully</returns>
bool LSM6DSO_GetAcceleration(vector3d_t *pvecAcceleration)
{
  uint8_t isDataAvailable;
  if( (!isLsm6dsoReady) && (pvecAcceleration == NULL) )
  {
    return false;
  }

 //Read output only if new xl value is available
	lsm6dso_xl_flag_data_ready_get(&dev_ctx, &isDataAvailable);
	if (isDataAvailable)
	{
    vector3d_uint16_t xl_raw;
		// Read acceleration field data
		lsm6dso_acceleration_raw_get(&dev_ctx, (uint8_t *) &xl_raw);

		pvecAcceleration->y = lsm6dso_from_fs4_to_mg(xl_raw.x);
		pvecAcceleration->y = lsm6dso_from_fs4_to_mg(xl_raw.y);
		pvecAcceleration->z = lsm6dso_from_fs4_to_mg(xl_raw.y);

		Log_Debug("LSM6DSO: Acceleration [mg]  : %.3lf, %.3lf, %.3lf\n",
			pvecAcceleration->x, pvecAcceleration->y, pvecAcceleration->z);

    return true;
	}
  
  Log_Debug("LSM6DSO: ERROR reading acceleration data.\n");
  return false;
}

/*
 * @brief  Write generic device register (platform dependent)
 *
 * @param  handle    customizable argument. In this examples is used in
 *                   order to select the correct sensor bus handler.
 * @param  reg       register to write
 * @param  bufp      pointer to data to write in register reg
 * @param  len       number of consecutive register to write
 *
 */
static int32_t platform_write(void *handle, uint8_t reg,
                              uint8_t *bufp,
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

/*
 * @brief  Read generic device register (platform dependent)
 *
 * @param  handle    customizable argument. In this examples is used in
 *                   order to select the correct sensor bus handler.
 * @param  reg       register to read
 * @param  bufp      pointer to buffer that store the data read
 * @param  len       number of consecutive register to read
 *
 */
static int32_t platform_read(void *handle, uint8_t reg, uint8_t *bufp,
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



/*
 * @brief  platform specific delay (platform dependent)
 *
 * @param  ms        delay in ms
 *
 */
static void platform_delay(uint32_t ms)
{
    struct timespec t = { 0, (long)ms * 1000l };
	nanosleep(&t, NULL);
}

