/**
 ******************************************************************************
 * @file    lps22hh.c
 * @author  jschwert@microsoft.com
 * @brief   This file show how to read LPS22HH mag connected to
 *          LSM6DSO I2C master interface (with FIFO support).
 *
 ******************************************************************************
 * @attention
 * based on STMicroelectronics example code.
 ******************************************************************************
 */


/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <applibs/i2c.h>
#include <applibs/log.h>

#include "lsm6dso/lsm6dso_reg.h"
#include "lps22hh/lps22hh_reg.h"

#include "lps22hh_internal.h"
#include "lsm6dso_internal.h"
#include "sensors.h"


#define _MODULE_ "[LPS22HH] "

/* Private functions ---------------------------------------------------------*/



/* Private macro -------------------------------------------------------------*/
#define TX_BUF_DIM      1000
#define    BOOT_TIME      10
#define LPS22HH_OK  0

/* Private variables ---------------------------------------------------------*/
static stmdev_ctx_t lps22hh_ctx = 
{
  .read_reg = lsm6dso_read_lps22hh_cx,
  .write_reg = lsm6dso_write_lps22hh_cx,
  .handle = NULL // not needed as lps22hh is connected to lsm6dso
};


static bool isLps22hhReady = false;

/* Extern variables ----------------------------------------------------------*/

/* private functions ---------------------------------------------------------*/

/**
 * @brief Initialise lps22hh onnected to lsm6dso
 * 
 * @return true 
 * @return false 
 */
bool lps22hh_init( void )
{
  uint8_t whoamI, rst;
  isLps22hhReady = false;

  /* Check if LPS22HH connected to Sensor Hub. */
  lps22hh_device_id_get(&lps22hh_ctx, &whoamI);
  if ( whoamI != LPS22HH_ID ){
    Log_Debug( _MODULE_ "ERROR: lps22hh not found.\n");
    return false;
  }

  // Restore the default configuration
  lps22hh_reset_set(&lps22hh_ctx, PROPERTY_ENABLE);
  do {
    lps22hh_reset_get(&lps22hh_ctx, &rst);
  } while (rst);

  /* Configure LPS22HH. */
  lps22hh_block_data_update_set(&lps22hh_ctx, PROPERTY_ENABLE);
  lps22hh_data_rate_set(&lps22hh_ctx, LPS22HH_10_Hz_LOW_NOISE);

 
  Log_Debug(_MODULE_ "Initialized lps22hh behind lsm6dso sensor hub.\n");
  isLps22hhReady = true;
  return true;
}

/**
 * @brief Read temperature and pressure from lps22hh connected to downstream lsm6dso i2c interface.
 * @param pEnvData  address of envdata_t structure for environmental sensor data
 * @return void 
 */
bool lps22hh_read_dataset( envdata_t *pEnvData )
{ uint16_t data_raw_temperature = 0;
  uint32_t data_raw_pressure = 0;

  if( !isLps22hhReady )
  {
      if( !lps22hh_init() )
      {
        return false;
      }
  }

  // Read the lps22hh sensor on the lsm6dso device
  lps22hh_reg_t lps22hhReg;
  lps22hh_read_reg(&lps22hh_ctx, LPS22HH_STATUS, (uint8_t *)&lps22hhReg, 1);

  //Read output only if new pressure value is available
  if ( lps22hhReg.status.p_da ){
    if( lps22hh_pressure_raw_get(&lps22hh_ctx, &data_raw_pressure) == LPS22HH_OK ){
      pEnvData->fPressure_hPa = lps22hh_from_lsb_to_hpa(data_raw_pressure);
      Log_Debug( _MODULE_ "Pressure     [hPa] : %.2f\n", pEnvData->fPressure_hPa);
    } 
  }
  //Read output only if new temperature value is available
  if( lps22hhReg.status.t_da ) {
    if( lps22hh_temperature_raw_get(&lps22hh_ctx, &data_raw_temperature) == LPS22HH_OK){
      pEnvData->fTemperature = lps22hh_from_lsb_to_celsius(data_raw_temperature);
      Log_Debug( _MODULE_ "Temperature  [degC]: %.2f\n", pEnvData->fTemperature);
    } 
  }
  return true;
}

