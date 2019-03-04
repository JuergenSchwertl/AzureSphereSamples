#include <applibs/i2c.h>

#define GROOVE_BME280_I2C_ADDRESS 0x76

///<summary>
///Initialize I2C interface and BME280 sensor at device address
///</summary>
///<param name="i2cInterfaceId">Interface Id of Azure Sphere I2C ISU block</param>
///<param name="i2cDeviceAddr">I2C bus address of BME 280 sensor</param>
///<returns>i2c file descriptor if successful, -1 if error</returns>
int BME280_Init(I2C_InterfaceId i2cInterfaceId, I2C_DeviceAddress i2cDeviceAddr);

void BME280_GetSensorData(void);


