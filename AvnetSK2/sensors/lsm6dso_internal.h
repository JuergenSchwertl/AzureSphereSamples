/**
 ******************************************************************************
* @file    lsm6dso_internal.h
* @author  jschwert@microsoft.com
* @brief   This file contains all internal functions prototypes for 
*          platform specific functions on i2c and sleep timers
******************************************************************************
*/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef LSM6DSO_INTERNAL_H
#define LSM6DSO_INTERNAL_H

#include <stdbool.h>

#define __NEED_uint8_t
#define __NEED_int16_t
#define __NEED_uint16_t
#define __NEED_int32_t
#define __NEED_uint32_t

#include <bits/alltypes.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief check if lsm6dso is connected and operable
 * 
 * @param fd file descriptor for i2C bus
 * @return true 
 * @return false 
 */
bool lsm6dso_init(int fd);

/**
 * @brief reads the complete lsm6dso dataset with accel, gyro & (chip) temp
 * 
 * @return true if command read lsm6dso dataset
 */
bool lsm6dso_read_dataset( void );

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
                              uint16_t len);

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
                             uint16_t len);




/**
 * @brief  platform specific delay (platform dependent)
 *
 * @param  ms        delay in ms
 *
 */
void platform_delay(uint32_t ms);

#ifdef __cplusplus
}
#endif

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
                                uint16_t len);


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
                                 const uint8_t *data, uint16_t len);

#endif /// LSM6DSO_INTERNAL_H