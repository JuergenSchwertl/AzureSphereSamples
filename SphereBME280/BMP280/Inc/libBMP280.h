#include <stdbool.h>

#define BMP280_I2C_PRIMARY_ADDRESS                 UINT8_C(0x76)

typedef struct BMP280_DATA {
	/*! Compensated pressure in hPa*/
	double pressure;
	/*! Compensated temperature degC*/
	double temperature;
} bmp280_data_t;


///<summary>
///Initialize BMP280 sensor at device address
///</summary>
///<param name="i2cInterfaceFd">Interface Id of Azure Sphere I2C ISU block</param>
///<param name="onPrimaryI2CAddress">use primary I2C bus address of BMP 280 sensor</param>
///<returns>true if successful, false if error</returns>
bool BMP280_Init(int i2cInterfaceFd, bool onPrimaryI2CAddress);

///<summary>
/// Reads temperature [degC], pressure [Pa] from BMP280 sensor
///</summary>
///<param name="pData">pointer to <see href="bmp280_data_t">bmp280_data_t</see> structure receiving output</param>
///<returns>0 if successful, -1 if error</returns>
int BMP280_GetSensorData(bmp280_data_t *pData);


