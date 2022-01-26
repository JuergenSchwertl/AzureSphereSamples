#pragma once

/**
 ******************************************************************************
 * @file    lps22hh.c
 * @author  Sensor Solutions Software Team
 * @brief   This file shows how to read LPS22HH mag connected to LSM6DSOX
 *          I2C master interface (with FIFO support).
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


/* ATTENTION: By default the driver is little endian. If you need switch
 *            to big endian please see "Endianness definitions" in the
 *            header file of the driver (_reg.h).
 */


/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include <stdio.h>
#include "lsm6dsox_reg.h"
#include "lps22hh_reg.h"
#include "lsm6dso_internal.h"

#include <applibs/log.h>


/* useful union to manage IMU data */
typedef union {
  int16_t i16bit[3];
  uint8_t u8bit[6];
} axis3bit16_t;

/* useful union to manage LPS22HH data */
typedef union {
  struct {
    uint32_t u32bit; /* pressure plus status register */
    int16_t  i16bit; /* temperature */
  } p_and_t;
  uint8_t u8bit[6];
} p_and_t_byte_t;

/* Private macro -------------------------------------------------------------*/
#define    BOOT_TIME            10 //ms
#define    TX_BUF_DIM         1000

/* Private variables ---------------------------------------------------------*/
static stmdev_ctx_t press_ctx;
static stmdev_ctx_t ag_ctx;

/* Extern variables ----------------------------------------------------------*/

/* Private functions ---------------------------------------------------------*/

static int32_t lsm6dsox_write_lps22hh_cx(void *ctx, uint8_t reg,
                                         const uint8_t *data, uint16_t len);

static int32_t lsm6dsox_read_lps22hh_cx(void *ctx, uint8_t reg,
                                        uint8_t *data, uint16_t len);



/* Main Example --------------------------------------------------------------*/

/*
 * Main Example
 *
 * Configure low level function to access to external device
 * Check if LPS22HH connected to Sensor Hub
 * Configure lps22hh for data acquisition
 * Configure Sensor Hub to read one slave with XL trigger
 * Set FIFO watermark
 * Set FIFO mode to Stream mode
 * Enable FIFO batching of Slave0 + ACC + Gyro samples
 * Poll for FIFO watermark interrupt and read samples
 */
void lsm6dsox_sh_fifo_lps22hh(void)
{
  uint8_t tx_buffer[TX_BUF_DIM];
  float angular_rate_mdps[3];
  float acceleration_mg[3];
  float temperature_degC;
  float pressure_hPa;
  uint8_t whoamI, rst, wtm_flag;
  lsm6dsox_pin_int1_route_t int1_route;
  lsm6dsox_sh_cfg_read_t sh_cfg_read;
  p_and_t_byte_t data_raw_press_temp;
  axis3bit16_t data_raw_acceleration;
  axis3bit16_t data_raw_angular_rate;
  axis3bit16_t dummy;
  /* Initialize lsm6dsox driver interface */
  ag_ctx.write_reg = platform_write;
  ag_ctx.read_reg = platform_read;
  ag_ctx.handle = &SENSOR_BUS;
  /* Initialize lps22hh driver interface */
  press_ctx.read_reg = lsm6dsox_read_lps22hh_cx;
  press_ctx.write_reg = lsm6dsox_write_lps22hh_cx;
  press_ctx.handle = &SENSOR_BUS;
  /* Init test platform */
  platform_init();
  /* Wait sensor boot time */
  platform_delay(BOOT_TIME);
  /* Check lsm6dsox ID. */
  lsm6dsox_device_id_get(&ag_ctx, &whoamI);

  if (whoamI != LSM6DSOX_ID)
    while (1);

  /* Restore default configuration. */
  lsm6dsox_reset_set(&ag_ctx, PROPERTY_ENABLE);

  do {
    lsm6dsox_reset_get(&ag_ctx, &rst);
  } while (rst);

  /* Disable I3C interface.*/
  lsm6dsox_i3c_disable_set(&ag_ctx, LSM6DSOX_I3C_DISABLE);
  /* Some hardware require to enable pull up on master I2C interface. */
  //lsm6dsox_sh_pin_mode_set(&ag_ctx, LSM6DSOX_INTERNAL_PULL_UP);
  /* Check if LPS22HH connected to Sensor Hub. */
  lps22hh_device_id_get(&press_ctx, &whoamI);

  if ( whoamI != LPS22HH_ID )
    while (1); /*manage here device not found */

  /* Configure LPS22HH. */
  lps22hh_block_data_update_set(&press_ctx, PROPERTY_ENABLE);
  lps22hh_data_rate_set(&press_ctx, LPS22HH_10_Hz_LOW_NOISE);
  /*
   * Configure LSM6DSOX FIFO.
   *
   *
   * Set FIFO watermark (number of unread sensor data TAG + 6 bytes
   * stored in FIFO) to 15 samples. 5 * (Acc + Gyro + Pressure)
   */
  lsm6dsox_fifo_watermark_set(&ag_ctx, 15);
  /* Set FIFO mode to Stream mode (aka Continuous Mode). */
  lsm6dsox_fifo_mode_set(&ag_ctx, LSM6DSOX_STREAM_MODE);
  /* Enable latched interrupt notification. */
  lsm6dsox_int_notification_set(&ag_ctx, LSM6DSOX_ALL_INT_LATCHED);
  /* Enable drdy 75 us pulse: uncomment if interrupt must be pulsed. */
  //lsm6dsox_data_ready_mode_set(&ag_ctx, LSM6DSOX_DRDY_PULSED);
  /*
   * FIFO watermark interrupt routed on INT1 pin.
   * Remember that INT1 pin is used by sensor to switch in I3C mode.
   */
  lsm6dsox_pin_int1_route_get(&ag_ctx, &int1_route);
  int1_route.fifo_th = PROPERTY_ENABLE;
  lsm6dsox_pin_int1_route_set(&ag_ctx, int1_route);
  /*
   * Enable FIFO batching of Slave0.
   * ODR batching is 13 Hz.
   */
  lsm6dsox_sh_batch_slave_0_set(&ag_ctx, PROPERTY_ENABLE);
  lsm6dsox_sh_data_rate_set(&ag_ctx, LSM6DSOX_SH_ODR_13Hz);
  /* Set FIFO batch XL/Gyro ODR to 12.5Hz. */
  lsm6dsox_fifo_xl_batch_set(&ag_ctx, LSM6DSOX_XL_BATCHED_AT_12Hz5);
  lsm6dsox_fifo_gy_batch_set(&ag_ctx, LSM6DSOX_GY_BATCHED_AT_12Hz5);
  /*
   * Prepare sensor hub to read data from external Slave0 continuously
   * in order to store data in FIFO.
   */
  sh_cfg_read.slv_add = (LPS22HH_I2C_ADD_H & 0xFEU) >>
                        1; /* 7bit I2C address */
  sh_cfg_read.slv_subadd = LPS22HH_STATUS;
  sh_cfg_read.slv_len = 6;
  lsm6dsox_sh_slv0_cfg_read(&ag_ctx, &sh_cfg_read);
  /* Configure Sensor Hub to read one slave. */
  lsm6dsox_sh_slave_connected_set(&ag_ctx, LSM6DSOX_SLV_0);
  /* Enable I2C Master. */
  lsm6dsox_sh_master_set(&ag_ctx, PROPERTY_ENABLE);
  /* Configure LSM6DSOX. */
  lsm6dsox_xl_full_scale_set(&ag_ctx, LSM6DSOX_2g);
  lsm6dsox_gy_full_scale_set(&ag_ctx, LSM6DSOX_2000dps);
  lsm6dsox_block_data_update_set(&ag_ctx, PROPERTY_ENABLE);
  lsm6dsox_xl_data_rate_set(&ag_ctx, LSM6DSOX_XL_ODR_12Hz5);
  lsm6dsox_gy_data_rate_set(&ag_ctx, LSM6DSOX_GY_ODR_12Hz5);

  while (1) {
    uint16_t num = 0;
    lsm6dsox_fifo_tag_t reg_tag;
    /* Read watermark flag. */
    lsm6dsox_fifo_wtm_flag_get(&ag_ctx, &wtm_flag);

    if ( wtm_flag ) {
      /* Read number of samples in FIFO. */
      lsm6dsox_fifo_data_level_get(&ag_ctx, &num);

      while (num--) {
        /* Read FIFO tag. */
        lsm6dsox_fifo_sensor_tag_get(&ag_ctx, &reg_tag);

        switch (reg_tag) {
          case LSM6DSOX_XL_NC_TAG:
            memset(data_raw_acceleration.u8bit, 0x00, 3 * sizeof(int16_t));
            lsm6dsox_fifo_out_raw_get(&ag_ctx, data_raw_acceleration.u8bit);
            acceleration_mg[0] = lsm6dsox_from_fs2_to_mg(
                                   data_raw_acceleration.i16bit[0]);
            acceleration_mg[1] = lsm6dsox_from_fs2_to_mg(
                                   data_raw_acceleration.i16bit[1]);
            acceleration_mg[2] = lsm6dsox_from_fs2_to_mg(
                                   data_raw_acceleration.i16bit[2]);
            sprintf( (char *)tx_buffer,
                     "Acceleration [mg]:%4.2f\t%4.2f\t%4.2f\r\n",
                     acceleration_mg[0],
                     acceleration_mg[1],
                     acceleration_mg[2] );
            tx_com(tx_buffer, strlen((char const *)tx_buffer));
            break;

          case LSM6DSOX_GYRO_NC_TAG:
            memset(data_raw_angular_rate.u8bit, 0x00, 3 * sizeof(int16_t));
            lsm6dsox_fifo_out_raw_get(&ag_ctx, data_raw_angular_rate.u8bit);
            angular_rate_mdps[0] = lsm6dsox_from_fs2000_to_mdps(
                                     data_raw_angular_rate.i16bit[0]);
            angular_rate_mdps[1] = lsm6dsox_from_fs2000_to_mdps(
                                     data_raw_angular_rate.i16bit[1]);
            angular_rate_mdps[2] = lsm6dsox_from_fs2000_to_mdps(
                                     data_raw_angular_rate.i16bit[2]);
            sprintf( (char *)tx_buffer,
                     "Angular rate [mdps]:%4.2f\t%4.2f\t%4.2f\r\n",
                     angular_rate_mdps[0],
                     angular_rate_mdps[1],
                     angular_rate_mdps[2]);
            tx_com(tx_buffer, strlen((char const *)tx_buffer));
            break;

          case LSM6DSOX_SENSORHUB_SLAVE0_TAG:
            memset(data_raw_press_temp.u8bit, 0x00, sizeof(p_and_t_byte_t));
            lsm6dsox_fifo_out_raw_get(&ag_ctx, data_raw_press_temp.u8bit);
            /* Please note: the conversion function lps22hh_from_lsb_to_hpa
             * work on uint32_t format left-aligned (not 24 bit), so an
             * additional 8-bit shift is required (4096.0f * 256 = 1048576.0f
             * sensitivity apply by the function).
             * In this case status register is in the lower position and
             * is used to perform the 8 bit shift.
             * */
            data_raw_press_temp.u8bit[0] = 0x00; // set to zero the status register
            pressure_hPa = lps22hh_from_lsb_to_hpa(
                             data_raw_press_temp.p_and_t.u32bit);
            temperature_degC = lps22hh_from_lsb_to_celsius(
                                 data_raw_press_temp.p_and_t.i16bit );
            sprintf( (char *)tx_buffer,
                     "Press [hPa]:%4.2f\r\nTemp [degC]:%4.2f\r\n",
                     pressure_hPa, temperature_degC);
            tx_com(tx_buffer, strlen((char const *)tx_buffer));
            break;

          default:
            /* Flush unused samples. */
            memset(dummy.u8bit, 0x00, 3 * sizeof(int16_t));
            lsm6dsox_fifo_out_raw_get(&ag_ctx, dummy.u8bit);
            break;
        }
      }
    }
  }
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
static int32_t lsm6dsox_write_lps22hh_cx(void *ctx, uint8_t reg,
                                         const uint8_t *data, uint16_t len)
{
  int16_t data_raw_acceleration[3];
  int32_t ret;
  uint8_t drdy;
  lsm6dsox_status_master_t master_status;
  lsm6dsox_sh_cfg_write_t sh_cfg_write;
  /* Configure Sensor Hub to read LPS22HH. */
  sh_cfg_write.slv0_add = (LPS22HH_I2C_ADD_H & 0xFEU) >>
                          1; /* 7bit I2C address */
  sh_cfg_write.slv0_subadd = reg,
  sh_cfg_write.slv0_data = *data,
  ret = lsm6dsox_sh_cfg_write(&ag_ctx, &sh_cfg_write);
  /* Disable accelerometer. */
  lsm6dsox_xl_data_rate_set(&ag_ctx, LSM6DSOX_XL_ODR_OFF);
  /* Enable I2C Master. */
  lsm6dsox_sh_master_set(&ag_ctx, PROPERTY_ENABLE);
  /* Enable accelerometer to trigger Sensor Hub operation. */
  lsm6dsox_xl_data_rate_set(&ag_ctx, LSM6DSOX_XL_ODR_104Hz);
  /* Wait Sensor Hub operation flag set. */
  lsm6dsox_acceleration_raw_get(&ag_ctx, data_raw_acceleration);

  do {
    HAL_Delay(20);
    lsm6dsox_xl_flag_data_ready_get(&ag_ctx, &drdy);
  } while (!drdy);

  do {
    HAL_Delay(20);
    lsm6dsox_sh_status_get(&ag_ctx, &master_status);
  } while (!master_status.sens_hub_endop);

  /* Disable I2C master and XL (trigger). */
  lsm6dsox_sh_master_set(&ag_ctx, PROPERTY_DISABLE);
  lsm6dsox_xl_data_rate_set(&ag_ctx, LSM6DSOX_XL_ODR_OFF);
  return ret;
}

/*
 * @brief  Read lps22hh device register (used by configuration functions)
 *
 * @param  handle    customizable argument. In this examples is used in
 *                   order to select the correct sensor bus handler.
 * @param  reg       register to read
 * @param  bufp      pointer to buffer that store the data read
 * @param  len       number of consecutive register to read
 *
 */
static int32_t lsm6dsox_read_lps22hh_cx(void *ctx, uint8_t reg,
                                        uint8_t *data, uint16_t len)
{
  lsm6dsox_sh_cfg_read_t sh_cfg_read;
  int16_t data_raw_acceleration[3];
  int32_t ret;
  uint8_t drdy;
  lsm6dsox_status_master_t master_status;
  /* Disable accelerometer. */
  lsm6dsox_xl_data_rate_set(&ag_ctx, LSM6DSOX_XL_ODR_OFF);
  /* Configure Sensor Hub to read LPS22HH. */
  sh_cfg_read.slv_add = (LPS22HH_I2C_ADD_H & 0xFEU) >>
                        1; /* 7bit I2C address */
  sh_cfg_read.slv_subadd = reg;
  sh_cfg_read.slv_len = len;
  ret = lsm6dsox_sh_slv0_cfg_read(&ag_ctx, &sh_cfg_read);
  lsm6dsox_sh_slave_connected_set(&ag_ctx, LSM6DSOX_SLV_0);
  /* Enable I2C Master and I2C master. */
  lsm6dsox_sh_master_set(&ag_ctx, PROPERTY_ENABLE);
  /* Enable accelerometer to trigger Sensor Hub operation. */
  lsm6dsox_xl_data_rate_set(&ag_ctx, LSM6DSOX_XL_ODR_104Hz);
  /* Wait Sensor Hub operation flag set. */
  lsm6dsox_acceleration_raw_get(&ag_ctx, data_raw_acceleration);

  do {
    HAL_Delay(20);
    lsm6dsox_xl_flag_data_ready_get(&ag_ctx, &drdy);
  } while (!drdy);

  do {
    //HAL_Delay(20);
    lsm6dsox_sh_status_get(&ag_ctx, &master_status);
  } while (!master_status.sens_hub_endop);

  /* Disable I2C master and XL(trigger). */
  lsm6dsox_sh_master_set(&ag_ctx, PROPERTY_DISABLE);
  lsm6dsox_xl_data_rate_set(&ag_ctx, LSM6DSOX_XL_ODR_OFF);
  /* Read SensorHub registers. */
  lsm6dsox_sh_read_data_raw_get(&ag_ctx, (lsm6dsox_emb_sh_read_t *)data,
                                len);
  return ret;
}
