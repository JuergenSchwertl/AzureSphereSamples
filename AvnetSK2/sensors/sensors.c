
#include <stddef.h>
#include "Inc/sensors.h"
#include "lsm6dso_internal.h"
#include "lps22hh_internal.h"
#include "lsm6dso/lsm6dso_reg.h"

#include "applibs/log.h"

/* Public Functions  ---------------------------------------------------------*/
/**
 * @brief 
 * 
 * @param fd 
 * @return int 
 */
bool Sensors_Init(int fd)
{ bool bResult = false;

  if( lsm6dso_init(fd) )
  {
    if( lps22hh_init() )
    {
       bResult = true;
    }
    
    lsm6dso_selftest();

    lsm6dso_start_accelerometer();
    lsm6dso_start_gyro();
  }
  return bResult;
}


/**
 * @brief Converts a 3D acceleration vector into textual orientation (e.g. "face up"). 
 * 
 * @param pVector pointer to 3D vector. if NULL, reads new acceleration from lsm6dso sensor. 
 * @return const char* 
 */
const char *Sensors_GetOrientation( vector3d_t * pVector )
{ vector3d_t vector;
  if( pVector == NULL )
  {
    lsm6dso_read_acceleration( &vector );
    pVector = &vector;
  }

  const char *strOrientation = lsm6dso_get_orientation( pVector );
  Log_Debug("[Sensor] orientation: %s", strOrientation);
  return strOrientation;
}

bool Sensors_GetAcceleration(vector3d_t *pvecAcceleration)
{
  if( pvecAcceleration == NULL )
  {
    return false;
  }
  return lsm6dso_read_acceleration( pvecAcceleration );
}

bool Sensors_GetGyro(vector3d_t *pvecGyro)
{
  if( pvecGyro == NULL )
  {
    return false;
  }
  return lsm6dso_read_gyro( pvecGyro );
}

bool Sensors_GetEnvironmentData(envdata_t *pEnvData)
{
  float fTempLSM6DSO;
  envdata_t envDataLPS22HH;

  lps22hh_read_dataset( &envDataLPS22HH );
  lsm6dso_read_chiptemp( &fTempLSM6DSO );

  lsm6dso_start_accelerometer();
  
  pEnvData->fPressure_hPa = envDataLPS22HH.fPressure_hPa;
  
  // Use both, lsm6dso and lps22hh temperature data. Both seem to measure chip temperature
  // and emperical measurements showed the measured values being 9.5°C / 11°C higher than ambient temp.
  // I'm using both sensors and "calibrate" the readings 
  pEnvData->fTemperature = ((fTempLSM6DSO - 11.0f) + (envDataLPS22HH.fTemperature - 9.5f)) / 2.0f;
  return true;
}


bool Sensors_GetSensorData(sensor_data_t *pSensorData)
{
  lsm6dso_read_acceleration( &pSensorData->acceleration);
  lsm6dso_read_gyro( &pSensorData->gyro);
  Sensors_GetEnvironmentData(&pSensorData->envData);
  return true;
}



