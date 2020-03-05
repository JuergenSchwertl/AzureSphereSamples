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


///<summary>
///Initialize BME280 sensor at device address
///</summary>
///<param name="i2cInterfaceFd">Interface Id of Azure Sphere I2C ISU block</param>
///<param name="onPrimaryI2CAddress">use primary I2C bus address of BME 280 sensor</param>
///<returns>true if successful, false if error</returns>
bool BME280_Init(int i2cInterfaceFd, bool onPrimaryI2CAddress);

///<summary>
/// Reads temperature [°C], pressure [Pa] and humidity [%] from BME280 sensor
///</summary>
///<param name="pData">pointer to <see href="bme280_data_t">bme280_data_t</see> structure receiving output</param>
///<returns>0 if successful, -1 if error</returns>
int BME280_GetSensorData(bme280_data_t *pData);


