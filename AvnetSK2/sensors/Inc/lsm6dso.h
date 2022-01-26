#include <stdbool.h>

typedef struct _vector3d {
    float x;
    float y;
    float z;
} vector3d_t;

bool LSM6DSO_Init(int fd);

/// <summary>
///     Reads the temperature from the LSM6DSO
/// </summary>
/// <param name="pfTemperature">pointer to float temperature output</param>
/// <returns>true if temperature was read successfully</returns>
bool LSM6DSO_GetTemperature(float *pfTemperature);

/// <summary>
///     Reads the orientation vector from the LSM6DSO
/// </summary>
/// <param name="pvecAcceleration">pointer to 3d acceleration vector</param>
/// <returns>true if orientation was read successfully</returns>
bool LSM6DSO_GetAcceleration(vector3d_t *pvecAcceleration);
