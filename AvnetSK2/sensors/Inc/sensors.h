#pragma once
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

#ifndef AVNET_SENSORS_H
#define AVNET_SENSORS_H

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Initializes connected sensors
 * 
 * @param fd i2c file descriptor
 * @return true 
 * @return false 
 */
bool Sensors_Init(int fd);

typedef struct _envdata_s {
    float fTemperature;
    float fPressure_hPa;
} envdata_t;

typedef struct _vector3d_s {
    float x;
    float y;
    float z;
} vector3d_t;

typedef struct _sensor_data_s
{
    envdata_t envData;
    vector3d_t acceleration;
    vector3d_t gyro;
} sensor_data_t;


/**
 * @brief Reads the temperature from the LSM6DSO and temperature and pressure from LPS22HH
 * 
 * @param pSensorData complete data set with temperature and pressure readings
 * @return true 
 * @return false 
 */
bool Sensors_GetSensorData(sensor_data_t *pSensorData);

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


/**
 * @brief Reads the gyro vector from the LSM6DSO
 * 
 * @param pvecGyro pointer to 3d gyro vector
 * @return true 
 * @return false 
 */
bool Sensors_GetGyro(vector3d_t *pvecGyro);

/**
 * @brief Converts a 3D acceleration vector into textual orientation (e.g. "face up"). 
 * 
 * @param pVector pointer to 3D vector. if NULL, reads new acceleration from lsm6dso sensor. 
 * @return const char* 
 */
const char *Sensors_GetOrientation( vector3d_t * pVector );


#ifdef __cplusplus
}
#endif
#endif //AVNET_SENSORS_H
