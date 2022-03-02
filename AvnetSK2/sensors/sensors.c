
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


bool Sensors_GetSensorData(sensor_data_t *pSensorData)
{
  lsm6dso_read_dataset();


  pSensorData->envData.fPressure_hPa = fPressure_hPa;
  pSensorData->envData.fTemperature = ((fTemperatureLSM6DSO_degC - 11.0f) + (fTemperatureLPS22HH_degC - 9.5f)) / 2.0f;

  pSensorData->acceleration.x = acceleration_mg[0];

  return true;
}

bool Sensors_GetEnvironmentData(envdata_t *pEnvData)
{
  lsm6dso_read_dataset();
  pEnvData->fPressure_hPa = fPressure_hPa;
  pEnvData->fTemperature = ((fTemperatureLSM6DSO_degC - 11.0f) + (fTemperatureLPS22HH_degC - 9.5f)) / 2.0f;
  return true;
}


bool Sensors_GetEnvironmentData(envdata_t *pEnvData);
{
  // uint8_t isDataAvailable;

  // if( (!isLsm6dsoReady) && (pfTemperature == NULL) )
  // {
  //   return false;
  // }

  // lsm6dso_temp_flag_data_ready_get(&lsm6dso_ctx, &isDataAvailable);
  // if (isDataAvailable)
  // {
  //   // Read temperature data
  //   int16_t data_raw_temperature;
  //   lsm6dso_temperature_raw_get(&lsm6dso_ctx, &data_raw_temperature);
  //   *pfTemperature = lsm6dso_from_lsb_to_celsius(data_raw_temperature);

  //   Log_Debug("[LSM6DSO] Temperature1 [degC]: %.2f\r\n", *pfTemperature);
  //   return true;
  // }

  return false;
}


bool Sensors_GetAcceleration(vector3d_t *pvecAcceleration)
{
  uint8_t isDataAvailable;
  if( (!isLsm6dsoReady) && (pvecAcceleration == NULL) )
  {
    return false;
  }

 // Read output only if new xl value is available
	lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &isDataAvailable);
	if (isDataAvailable)
	{
    vector3d_uint16_t xl_raw;
		// Read acceleration field data
		lsm6dso_acceleration_raw_get(&lsm6dso_ctx, (int16_t *) &xl_raw);

		pvecAcceleration->y = lsm6dso_from_fs4_to_mg(xl_raw.x);
		pvecAcceleration->y = lsm6dso_from_fs4_to_mg(xl_raw.y);
		pvecAcceleration->z = lsm6dso_from_fs4_to_mg(xl_raw.y);

		Log_Debug("[LSM6DSO] Acceleration [mg]  : %.3lf, %.3lf, %.3lf\n",
			pvecAcceleration->x, pvecAcceleration->y, pvecAcceleration->z);

    return true;
	}
  
  Log_Debug("[LSM6DSO] ERROR reading acceleration data.\n");
  return false;
}

/**
 * @brief Reads the gyro vector from the LSM6DSO
 * 
 * @param pvecGyro pointer to 3d gyro vector
 * @return true 
 * @return false 
 */
bool Sensors_GetGyro(vector3d_t *pvecGyro)
{

  return false;
}
