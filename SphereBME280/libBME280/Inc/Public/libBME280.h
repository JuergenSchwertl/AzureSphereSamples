#include <applibs/i2c.h>

#define GROOVE_BME280_I2C_ADDRESS 0x76


typedef struct BME280_DATA {
	/*! Compensated pressure */
	double pressure;
	/*! Compensated temperature */
	double temperature;
	/*! Compensated humidity */
	double humidity;
} bme280_data_t;


///<summary>
///Initialize I2C interface and BME280 sensor at device address
///</summary>
///<param name="i2cInterfaceId">Interface Id of Azure Sphere I2C ISU block</param>
///<param name="i2cDeviceAddr">I2C bus address of BME 280 sensor</param>
///<returns>i2c file descriptor if successful, -1 if error</returns>
int BME280_Init(I2C_InterfaceId i2cInterfaceId, I2C_DeviceAddress i2cDeviceAddr);

///<summary>
/// Reads temperature [°C], pressure [Pa] and humidity [%] from BME280 sensor
///</summary>
///<param name="pData">pointer to <see href="bme280_data_t">bme280_data_t</see> structure receiving output</param>
///<returns>0 if successful, -1 if error</returns>
int BME280_GetSensorData(bme280_data_t *pData);


