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
#include "lsm6dso/lsm6dso_reg.h"
#include "lps22hh/lps22hh_reg.h"
#include "lps22hh_internal.h"
#include "lsm6dso_internal.h"

#include <applibs/i2c.h>
#include <applibs/log.h>

#define _MODULE_ "[LPS2HH] "

/* Private functions ---------------------------------------------------------*/



/* Private macro -------------------------------------------------------------*/
#define TX_BUF_DIM      1000
#define    BOOT_TIME      10

/* Private variables ---------------------------------------------------------*/
static stmdev_ctx_t lps22hh_ctx = 
{
  .read_reg = lsm6dso_read_lps22hh_cx,
  .write_reg = lsm6dso_write_lps22hh_cx,
  .handle = NULL // not needed as lps22hh is connected to lsm6dso
};


static bool isLps22hhReady = false;

float fTemperatureLPS22HH_degC;
float fPressure_hPa;


/* Extern variables ----------------------------------------------------------*/
/// defined in lsm6dso.c
extern stmdev_ctx_t lsm6dso_ctx;



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
    Log_Debug( _MODULE_ "ERROR: lps22hh not found");
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
 * 
 * @return void 
 */
void lps22hh_read_dataset( void )
{ axis1bit16_t data_raw_temperature;
  axis1bit32_t data_raw_pressure;

  if( !isLps22hhReady )
  {
      if( !lps22hh_init() )
      {
        return;
      }
  }

  // Read the lps22hh sensor on the lsm6dso device

	// Initialize the data structures to 0s.
	memset(&data_raw_pressure, 0x00, sizeof(data_raw_pressure));
	memset(&data_raw_temperature, 0x00, sizeof(data_raw_temperature));

  lps22hh_reg_t lps22hhReg;
  lps22hh_read_reg(&lps22hh_ctx, LPS22HH_STATUS, (uint8_t *)&lps22hhReg, 1);

  //Read output only if new value is available

  if ((lps22hhReg.status.p_da == 1) && (lps22hhReg.status.t_da == 1))
  {
    lps22hh_pressure_raw_get(&lps22hh_ctx, &data_raw_pressure.u32bit);

    fPressure_hPa = lps22hh_from_lsb_to_hpa(data_raw_pressure.u32bit);

    lps22hh_temperature_raw_get(&lps22hh_ctx, &data_raw_temperature.i16bit);
    fTemperatureLPS22HH_degC = lps22hh_from_lsb_to_celsius(data_raw_temperature.i16bit);

    Log_Debug( _MODULE_ "Pressure     [hPa] : %.2f\r\n", fPressure_hPa);
    Log_Debug( _MODULE_ "Temperature  [degC]: %.2f\r\n", fTemperatureLPS22HH_degC);
  }
}




// /*
//  * Main Example
//  *
//  * Configure low level function to access to external device
//  * Check if LPS22HH connected to Sensor Hub
//  * Configure lps22hh for data acquisition
//  * Configure Sensor Hub to read one slave with XL trigger
//  * Set FIFO watermark
//  * Set FIFO mode to Stream mode
//  * Enable FIFO batching of Slave0 + ACC + Gyro samples
//  * Poll for FIFO watermark interrupt and read samples
//  */
// void lsm6dso_hub_fifo_lps22hh(void)
// {
//   uint8_t whoamI, rst, wtm_flag;
//   lsm6dso_pin_int1_route_t int1_route;
//   lsm6dso_sh_cfg_read_t sh_cfg_read;
//   p_and_t_byte_t data_raw_press_temp;
//   axis3bit16_t data_raw_acceleration;
//   axis3bit16_t data_raw_angular_rate;
//   axis3bit16_t dummy;
//   // /* Initialize lsm6dso driver interface */
//   // lsm6dso_ctx.write_reg = platform_write;
//   // lsm6dso_ctx.read_reg = platform_read;
//   // lsm6dso_ctx.handle = &fdI2CBus;
//   // /* Initialize lps22hh driver interface */
//   // lps22hh_ctx.read_reg = lsm6dso_read_lps22hh_cx;
//   // lps22hh_ctx.write_reg = lsm6dso_write_lps22hh_cx;
//   // lps22hh_ctx.handle = &fdI2CBus;

//   /* Wait sensor boot time */
//   platform_delay(BOOT_TIME);
//   /* Check Connected devices. */
//   /* Check lsm6dso ID. */
//   lsm6dso_device_id_get(&lsm6dso_ctx, &whoamI);

//   if (whoamI != LSM6DSO_ID)
//     while (1);

//   /* Restore default configuration. */
//   lsm6dso_reset_set(&lsm6dso_ctx, PROPERTY_ENABLE);

//   do {
//     lsm6dso_reset_get(&lsm6dso_ctx, &rst);
//   } while (rst);

//   /* Disable I3C interface.*/
//   lsm6dso_i3c_disable_set(&lsm6dso_ctx, LSM6DSO_I3C_DISABLE);
//   /* Some hardware require to enable pull up on master I2C interface. */
//   //lsm6dso_sh_pin_mode_set(&lsm6dso_ctx, LSM6DSO_INTERNAL_PULL_UP);
//   /* Check if LPS22HH connected to Sensor Hub. */
//   lps22hh_device_id_get(&lps22hh_ctx, &whoamI);

//   if ( whoamI != LPS22HH_ID )
//     while (1); /*manage here device not found */

//   /* Configure LPS22HH. */
//   lps22hh_block_data_update_set(&lps22hh_ctx, PROPERTY_ENABLE);
//   lps22hh_data_rate_set(&lps22hh_ctx, LPS22HH_10_Hz_LOW_NOISE);
//   /* Configure LSM6DSO FIFO.
//    *
//    * Set FIFO watermark (number of unread sensor data TAG + 6 bytes
//    * stored in FIFO) to 15 samples. 5 * (Acc + Gyro + Pressure)
//    */
//   lsm6dso_fifo_watermark_set(&lsm6dso_ctx, 15);
//   /* Set FIFO mode to Stream mode (aka Continuous Mode). */
//   lsm6dso_fifo_mode_set(&lsm6dso_ctx, LSM6DSO_STREAM_MODE);
//   /* Enable latched interrupt notification. */
//   lsm6dso_int_notification_set(&lsm6dso_ctx, LSM6DSO_ALL_INT_LATCHED);
//   /* Enable drdy 75 us pulse: uncomment if interrupt must be pulsed. */
//   //lsm6dso_data_ready_mode_set(&lsm6dso_ctx, LSM6DSO_DRDY_PULSED);
//   /* FIFO watermark interrupt routed on INT1 pin.
//    * Remember that INT1 pin is used by sensor to switch in I3C mode.
//    */
//   lsm6dso_pin_int1_route_get(&lsm6dso_ctx, &int1_route);
//   int1_route.fifo_th = PROPERTY_ENABLE;
//   lsm6dso_pin_int1_route_set(&lsm6dso_ctx, int1_route);
//   /* Enable FIFO batching of Slave0.
//    * ODR batching is 13 Hz.
//    */
//   lsm6dso_sh_batch_slave_0_set(&lsm6dso_ctx, PROPERTY_ENABLE);
//   lsm6dso_sh_data_rate_set(&lsm6dso_ctx, LSM6DSO_SH_ODR_13Hz);
//   /* Set FIFO batch XL/Gyro ODR to 12.5Hz. */
//   lsm6dso_fifo_xl_batch_set(&lsm6dso_ctx, LSM6DSO_XL_BATCHED_AT_12Hz5);
//   lsm6dso_fifo_gy_batch_set(&lsm6dso_ctx, LSM6DSO_GY_BATCHED_AT_12Hz5);
//   /* Prepare sensor hub to read data from external Slave0 continuously
//    * in order to store data in FIFO.
//    */
//   sh_cfg_read.slv_add = (LPS22HH_I2C_ADD_H & 0xFEU) >>
//                         1; /* 7bit I2C address */
//   sh_cfg_read.slv_subadd = LPS22HH_STATUS;
//   sh_cfg_read.slv_len = 6;
//   lsm6dso_sh_slv0_cfg_read(&lsm6dso_ctx, &sh_cfg_read);
//   /* Configure Sensor Hub to read one slave. */
//   lsm6dso_sh_slave_connected_set(&lsm6dso_ctx, LSM6DSO_SLV_0);
//   /* Enable I2C Master. */
//   lsm6dso_sh_master_set(&lsm6dso_ctx, PROPERTY_ENABLE);


//   /* Configure LSM6DSO. */
//   lsm6dso_xl_full_scale_set(&lsm6dso_ctx, LSM6DSO_2g);
//   lsm6dso_gy_full_scale_set(&lsm6dso_ctx, LSM6DSO_2000dps);
//   lsm6dso_block_data_update_set(&lsm6dso_ctx, PROPERTY_ENABLE);
//   lsm6dso_xl_data_rate_set(&lsm6dso_ctx, LSM6DSO_XL_ODR_12Hz5);
//   lsm6dso_gy_data_rate_set(&lsm6dso_ctx, LSM6DSO_GY_ODR_12Hz5);

//   while (1) {
//     uint16_t num = 0;
//     lsm6dso_fifo_tag_t reg_tag;
//     /* Read watermark flag. */
//     lsm6dso_fifo_wtm_flag_get(&lsm6dso_ctx, &wtm_flag);

//     if ( wtm_flag ) {
//       /* Read number of samples in FIFO. */
//       lsm6dso_fifo_data_level_get(&lsm6dso_ctx, &num);

//       while (num--) {
//         /* Read FIFO tag. */
//         lsm6dso_fifo_sensor_tag_get(&lsm6dso_ctx, &reg_tag);

//         switch (reg_tag) {
//           case LSM6DSO_XL_NC_TAG:
//             memset(data_raw_acceleration.u8bit, 0x00, 3 * sizeof(int16_t));
//             lsm6dso_fifo_out_raw_get(&lsm6dso_ctx, data_raw_acceleration.u8bit);
//             acceleration_mg[0] = lsm6dso_from_fs2_to_mg(
//                                    data_raw_acceleration.i16bit[0]);
//             acceleration_mg[1] = lsm6dso_from_fs2_to_mg(
//                                    data_raw_acceleration.i16bit[1]);
//             acceleration_mg[2] = lsm6dso_from_fs2_to_mg(
//                                    data_raw_acceleration.i16bit[2]);
//             Log_Debug("[LPS22HH]: Acceleration [mg]:%4.2f\t%4.2f\t%4.2f\r\n",
//                      acceleration_mg[0],
//                      acceleration_mg[1],
//                      acceleration_mg[2] );
//             break;

//           case LSM6DSO_GYRO_NC_TAG:
//             memset(data_raw_angular_rate.u8bit, 0x00, 3 * sizeof(int16_t));
//             lsm6dso_fifo_out_raw_get(&lsm6dso_ctx, data_raw_angular_rate.u8bit);
//             angular_rate_mdps[0] = lsm6dso_from_fs2000_to_mdps(
//                                      data_raw_angular_rate.i16bit[0]);
//             angular_rate_mdps[1] = lsm6dso_from_fs2000_to_mdps(
//                                      data_raw_angular_rate.i16bit[1]);
//             angular_rate_mdps[2] = lsm6dso_from_fs2000_to_mdps(
//                                      data_raw_angular_rate.i16bit[2]);
//             Log_Debug("[LPS22HH]:Angular rate [mdps]:%4.2f\t%4.2f\t%4.2f\r\n",
//                      angular_rate_mdps[0],
//                      angular_rate_mdps[1],
//                      angular_rate_mdps[2]);
//             break;

//           case LSM6DSO_SENSORHUB_SLAVE0_TAG:
//             memset(data_raw_press_temp.u8bit, 0x00, sizeof(p_and_t_byte_t));
//             lsm6dso_fifo_out_raw_get(&lsm6dso_ctx, data_raw_press_temp.u8bit);
//             /* Please note: the conversion function lps22hh_from_lsb_to_hpa
//              * work on uint32_t format left-aligned (not 24 bit), so an
//              * additional 8-bit shift is required (4096.0f * 256 = 1048576.0f
//              * sensitivity apply by the function).
//              * In this case status register is in the lower position and
//              * is used to perform the 8 bit shift.
//              * */
//             data_raw_press_temp.u8bit[0] = 0x00; /* remove status register */
//             pressure_hPa = lps22hh_from_lsb_to_hpa(
//                              data_raw_press_temp.p_and_t.u32bit);
//             temperature_degC = lps22hh_from_lsb_to_celsius(
//                                  data_raw_press_temp.p_and_t.i16bit );
//             Log_Debug("[LPS22HH] Press [hPa]:%4.2f\r\nTemp [degC]:%4.2f\r\n",
//                      pressure_hPa, temperature_degC);
//             break;

//           default:
//             /* Flush unused samples. */
//             memset(dummy.u8bit, 0x00, 3 * sizeof(int16_t));
//             lsm6dso_fifo_out_raw_get(&lsm6dso_ctx, dummy.u8bit);
//             break;
//         }
//       }
//     }
//   }
// }


