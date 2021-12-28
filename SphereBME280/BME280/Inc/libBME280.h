#include <stdbool.h>

#define GROOVE_BME280_I2C_ADDRESS 0x76


typedef struct BME280_DATA {
	/*! Compensated pressure in hPa*/
	double pressure;
	/*! Compensated temperature °C*/
	double temperature;
	/*! Compensated humidity in %*/
	double humidity;
} bme280_data_t;


/// @brief Initialize BME280 sensor at device address
///
/// @param i2cInterfaceFd Interface Id of Azure Sphere I2C ISU block
/// @param onPrimaryI2CAddress use primary I2C bus address of BME 280 sensor
/// @return true if successful, false if error
bool BME280_Init(int i2cInterfaceFd, bool onPrimaryI2CAddress);

/// @brief Reads temperature [°C], pressure [Pa] and humidity [%] from BME280 sensor
///
/// @param pData">pointer to @see bme280_data_t structure receiving output
/// @returns 0 if successful, -1 if error
int BME280_GetSensorData(bme280_data_t *pData);


