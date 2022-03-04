
#include <stddef.h>
#include "Inc/sensors.h"
#include "lsm6dso_internal.h"
#include "lps22hh_internal.h"

// extern float angular_rate_mdps[3];
// extern float acceleration_mg[3];
// extern float fTemperatureLSM6DSO_degC;
// extern float fTemperatureLPS22HH_degC;
// extern float fPressure_hPa;

/* Public Functions  ---------------------------------------------------------*/
/**
 * @brief 
 * 
 * @param fd 
 * @return int 
 */
bool Sensors_Init(int fd)
{
  if( lsm6dso_init(fd) )
  {
    return( lps22hh_init() );
  }
  return false;
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

  lsm6dso_read_chiptemp( &fTempLSM6DSO );
  lps22hh_read_dataset( &envDataLPS22HH );

  pEnvData->fPressure_hPa = envDataLPS22HH.fPressure_hPa;
  
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



