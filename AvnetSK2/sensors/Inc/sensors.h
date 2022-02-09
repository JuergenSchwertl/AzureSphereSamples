#pragma once
#ifndef AVNET_SENSORS_H
#define AVNET_SENSORS_H

#include "stdbool.h"

/**
 * @file sensors.h
 * @author Juergen Schwertl (jschwert@microsoft.com)
 * @brief AVNET Starter Kit sensor library with lsm6dso and lps22hh
 * @version 0.1
 * @date 2022-01-28
 * 
 * @copyright Copyright (c) 2022
 * 
 */


#include <stdbool.h>

typedef struct _vector3d {
    float x;
    float y;
    float z;
} vector3d_t;

typedef struct _envdata {
    float fTemperature;
    float fPressure_hPa;
} envdata_t;

typedef struct _vector {
    float x;
    float y;
    float z;
} vector_t;

/**
 * @brief Initializes connected sensors
 * 
 * @param fd i2c file descriptor
 * @return true 
 * @return false 
 */
bool Sensors_Init(int fd);

/**
 * @brief Reads the temperature from the LSM6DSO and temperature and pressure from LPS22HH
 * 
 * @param pEnvData environemntal data set with temperature and pressure readings
 * @return true 
 * @return false 
 */
bool Sensors_GetEnvironmentData(envdata_t *pEnvData);

/**
 * @brief Reads the orientation vector from the LSM6DSO
 * 
 * @param pvecAcceleration pointer to 3d acceleration vector
 * @return true 
 * @return false 
 */
bool Sensors_GetAcceleration(vector3d_t *pvecAcceleration);

#endif //AVNET_SENSORS_H
