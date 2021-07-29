#include <stdbool.h>

#define BMP280_I2C_PRIMARY_ADDRESS                 UINT8_C(0x76)

typedef struct BMP280_DATA {
	/*! Compensated pressure in hPa*/
	double pressure;
	/*! Compensated temperature degC*/
	double temperature;
} bmp280_data_t;


/// @brief Initialize BMP280 sensor at device address
///
/// @param i2cInterfaceFd		Interface Id of Azure Sphere I2C ISU block
/// @param onPrimaryI2CAddress	use primary I2C bus address of BMP 280 sensor
/// @returns true if successful, false if error
bool BMP280_Init(int i2cInterfaceFd, bool onPrimaryI2CAddress);

/// @brief 
/// Reads temperature [degC], pressure [Pa] from BMP280 sensor
///
/// @param		pData	pointer to @see bmp280_data_t structure receiving output
/// @returns	0 if successful, -1 if error</returns>
int BMP280_GetSensorData(bmp280_data_t *pData);


