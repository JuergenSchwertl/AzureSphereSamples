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


#include <stdbool.h>
#include <bits/alltypes.h>

/* useful union to manage IMU data */
typedef union {
  int16_t i16bit[3];
  uint8_t u8bit[6];
} axis3bit16_t;

typedef union{
  int16_t i16bit;
  uint8_t u8bit[2];
} axis1bit16_t;

typedef union{
  int32_t i32bit[3];
  uint8_t u8bit[12];
} axis3bit32_t;

typedef union{
  int32_t i32bit;
  uint32_t u32bit;
  uint8_t u8bit[4];
} axis1bit32_t;

/* useful union to manage LPS22HH data */
typedef union {
  struct {
    uint32_t u32bit; /* pressure plus status register */
    int16_t  i16bit; /* temperature */
  } p_and_t;
  uint8_t u8bit[6];
} p_and_t_byte_t;

/**
 * @brief Initialise lps22hh onnected to lsm6dso
 * 
 * @return true 
 * @return false 
 */
bool lps22hh_init( void );

/**
 * @brief Read temperature and pressure from lps22hh connected to downstream lsm6dso i2c interface.
 * 
 * @return void 
 */
void lps22hh_read_dataset( void );

#endif // LPS22HH_INTERNAL_H