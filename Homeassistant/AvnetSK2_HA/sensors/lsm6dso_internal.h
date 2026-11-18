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

#define __NEED_uint8_t
#define __NEED_int16_t
#define __NEED_uint16_t
#define __NEED_int32_t
#define __NEED_uint32_t
#include <bits/alltypes.h>

#include <stdbool.h>

#include "Inc/sensors.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum
{
  LSM6DSO_OK = 0,
  LSM6DSO_ERROR =-1
} _lsm6dso_status_t;


/**
 * @brief Converts a 3D acceleration vector into textual orientation (e.g. "face up"). 
 * 
 * @param pVector pointer to 3D vector. SHALL NOT be NULL. 
 * @return const char* 
 */
const char *lsm6dso_get_orientation( vector3d_t * pVector );

/**
 * @brief initialize accelerometer for 26Hz, 5G with filters 
 * 
 */
void lsm6dso_start_accelerometer( void );

/**
 * @brief initialize gyro for 12.5 Hz bis 2000dps
 * 
 */
void lsm6dso_start_gyro( void );

/**
 * @brief check if lsm6dso is connected and operable
 * 
 * @param fd file descriptor for i2C bus
 * @return true 
 * @return false 
 */
bool lsm6dso_init(int fd);

/**
 * @brief self test accelerometer and gyro
 * 
 */
void lsm6dso_selftest( void );

/**
 * @brief reads the complete lsm6dso dataset with accel, gyro & (chip) temp
 * 
 * @return true if command read lsm6dso dataset
 */
bool lsm6dso_read_dataset( void );

/**
 * @brief reads acceleration vector from lsm6dso
 * 
 * @param pAcceleration address of 3d vector structure for x/y/z acceleration/orientation
 * @return true on success
 * @return false on error
 */
bool lsm6dso_read_acceleration( vector3d_t * pAcceleration );

/**
 * @brief reads gyro vector from lsm6dso
 * 
 * @param pGyro address of 3d vector structure for x/y/z angular movement indicator
 * @return true on success
 * @return false on error
 */
bool lsm6dso_read_gyro( vector3d_t * pGyro );

/**
 * @brief reads lsm6dso chip temperature
 * 
 * @param pTemp address of temperature variable [out]
 * @return true on success
 * @return false on error
 */
bool lsm6dso_read_chiptemp( float * pTemp );


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


#ifdef __cplusplus
}
#endif
#endif /// LSM6DSO_INTERNAL_H
