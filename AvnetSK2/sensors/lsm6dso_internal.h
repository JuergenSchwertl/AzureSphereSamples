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

#ifdef __cplusplus
extern "C" {
#endif

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
static int32_t platform_write(void *handle, uint8_t reg,
                              uint8_t *bufp,
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
static int32_t platform_read(void *handle, uint8_t reg, uint8_t *bufp,
                             uint16_t len);




/**
 * @brief  platform specific delay (platform dependent)
 *
 * @param  ms        delay in ms
 *
 */
static void platform_delay(uint32_t ms);

#ifdef __cplusplus
}
#endif

#endif /// LSM6DSO_INTERNAL_H