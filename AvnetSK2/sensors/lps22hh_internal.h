/**
 * @file lps22hh_internal.h
 * @author Juergen Schwertl (jschwert@microsoft.com)
 * @brief 
 * @version 0.1
 * @date 2022-01-31
 * 
 * @copyright Copyright (c) 2022
 * 
 */
#ifndef LPS22HH_INTERNAL_H
#define LPS22HH_INTERNAL_H

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

/* useful union to manage LPS22HH data */
typedef union {
  struct {
    uint32_t u32bit; /* pressure plus status register */
    int16_t  i16bit; /* temperature */
  } p_and_t;
  uint8_t u8bit[6];
} p_and_t_byte_t;

/**
 * @brief Initialise lps22hh connected to lsm6dso
 * 
 * @return true 
 * @return false 
 */
bool lps22hh_init( void );

/**
 * @brief Read temperature and pressure from lps22hh connected to downstream lsm6dso i2c interface.
 * @param pEnvData  address of envdata_t structure for environmental sensor data
 * @return true on success
 * @return false on error
 */
bool lps22hh_read_dataset( envdata_t *pEnvData );

#ifdef __cplusplus
}
#endif
#endif // LPS22HH_INTERNAL_H