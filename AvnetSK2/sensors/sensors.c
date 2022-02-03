
#include <stddef.h>
#include "Inc/sensors.h"
#include "lsm6dso_internal.h"
#include "lps22hh_internal.h"


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

bool Sensors_GetEnvironmentData(envdata_t *pEnvData)
{
  lsm6dso_read_dataset();
  return true;
}


/// <summary>
///     Reads the temperature from the LSM6DSO
/// </summary>
/// <param name="pfTemperature">pointer to temperature output</param>
/// <returns>true if temperature was read successfully</returns>
bool LSM6DSO_GetTemperature(float *pfTemperature)
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

/**
* @brief Reads the acceleration vector from the LSM6DSO
* @param pvecAcceleration pointer to 3d acceleration vector
* @returns true if acceleration was read successfully
*/
bool LSM6DSO_GetAcceleration(vector3d_t *pvecAcceleration)
{
//   uint8_t isDataAvailable;
//   if( (!isLsm6dsoReady) && (pvecAcceleration == NULL) )
//   {
//     return false;
//   }

//  // Read output only if new xl value is available
// 	lsm6dso_xl_flag_data_ready_get(&lsm6dso_ctx, &isDataAvailable);
// 	if (isDataAvailable)
// 	{
//     vector3d_uint16_t xl_raw;
// 		// Read acceleration field data
// 		lsm6dso_acceleration_raw_get(&lsm6dso_ctx, (int16_t *) &xl_raw);

// 		pvecAcceleration->y = lsm6dso_from_fs4_to_mg(xl_raw.x);
// 		pvecAcceleration->y = lsm6dso_from_fs4_to_mg(xl_raw.y);
// 		pvecAcceleration->z = lsm6dso_from_fs4_to_mg(xl_raw.y);

// 		Log_Debug("[LSM6DSO] Acceleration [mg]  : %.3lf, %.3lf, %.3lf\n",
// 			pvecAcceleration->x, pvecAcceleration->y, pvecAcceleration->z);

//     return true;
// 	}
  
//   Log_Debug("[LSM6DSO] ERROR reading acceleration data.\n");
  return false;
}
