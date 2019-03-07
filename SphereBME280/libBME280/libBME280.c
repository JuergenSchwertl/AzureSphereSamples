#include <bits/alltypes.h>
#include <stdlib.h>
#include <time.h>
#include <memory.h>
#include <applibs/log.h>

#include "libBME280.h"
#include "bme280_defs.h"
#include "bme280.h"


///<summary>
/// This is an Azure Sphere wrapper library for the Bosch BME280 
/// temperature-, humidity- and pressure-sensor
/// <see href="https://github.com/BoschSensortec/BME280_driver" />
/// connected to Azure Sphere via I2Cbis (i.e. the Seeed Groove BME280 sensor board)
/// <see href="http://wiki.seeedstudio.com/Grove-Barometer_Sensor-BME280/" />
///</summary>

///<summary>
/// forward declarations of platform dependent helper functions for the Bosch BME280 driver
///</summary>
int8_t user_i2c_read(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len);
void user_delay_ms(uint32_t period);
int8_t user_i2c_write(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len);


///<summary>
/// File descriptor for I2C ISU block
///</summary>
static int i2cFd = -1;

///<summary>
/// <see href="bme280_dev">bme280_dev</see> structure with platform dependent callbacks, calibration data and settings
///</summary>
struct bme280_dev dev = {
		chip_id:0,
		dev_id : BME280_I2C_ADDR_PRIM,
		intf : BME280_I2C_INTF,
		read : user_i2c_read,
		write : user_i2c_write,
		delay_ms : user_delay_ms,
		calib_data : {0},
		settings : {
			osr_h: BME280_OVERSAMPLING_1X,
			osr_p : BME280_OVERSAMPLING_1X,
			osr_t : BME280_OVERSAMPLING_1X,
			filter : BME280_FILTER_COEFF_OFF,
			standby_time : BME280_STANDBY_TIME_250_MS
		}
};

///<summary>
/// platform dependant helper functions for bme280
///</sdummary>

int8_t user_i2c_read(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
{
	ssize_t rslt = I2CMaster_WriteThenRead(i2cFd, (I2C_DeviceAddress) (dev.dev_id), &reg_addr, 1, data, len);

	Log_Debug("[I2C read] ");
	for (ssize_t i = 0; i < rslt; i++)
	{
		Log_Debug("%2x ", (unsigned int) data[i]);
	}
	Log_Debug("\n");

	//write(i2cFd, &reg_addr, 1);
	//read(i2cFd, data, len);
	return (rslt != -1) ? BME280_OK : BME280_E_COMM_FAIL;
}

void user_delay_ms(uint32_t period)
{
	struct timespec t = { 0, (long)period * 1000l };
	nanosleep(&t, NULL);
}

int8_t user_i2c_write(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
{
	ssize_t rslt = -1;
	uint8_t *buf;

	buf = malloc((size_t)len + 1);
	if (buf != NULL)
	{
		buf[0] = reg_addr;
		memcpy(buf + 1, data, (size_t)len);
		rslt = I2CMaster_Write(i2cFd, (I2C_DeviceAddress)dev.dev_id, data, (size_t)len + 1);
		//write(i2cFd, buf, len + 1);
		free(buf);
	}
	return (rslt != -1) ? BME280_OK : BME280_E_COMM_FAIL;
}




void print_sensor_data(struct bme280_data *comp_data)
{
#ifdef BME280_FLOAT_ENABLE
	Log_Debug("[BME280] Temperature: %0.2f °C, Pressure: %0.2f Pa, Humidity: %0.2f %%\n", 
		comp_data->temperature, comp_data->pressure, comp_data->humidity);
#else
	Log_Debug("[BME280] Temperature: %ld [°C * 100], Pressure: %ld [Pa], Humidity: %ld [%% * 100]\n", 
		comp_data->temperature, comp_data->pressure, comp_data->humidity);
#endif
}

///<summary>
///Initialize I2C interface and BME280 sensor at device address
///</summary>
///<param name="i2cInterfaceId">Interface Id of Azure Sphere I2C ISU block</param>
///<param name="i2cDeviceAddr">I2C bus address of BME 280 sensor</param>
///<returns>i2c file descriptor if successful, -1 if error</returns>
int BME280_Init(I2C_InterfaceId i2cInterfaceId, I2C_DeviceAddress i2cDeviceAddr)
{
	int8_t rslt = BME280_OK;
	
	if ((i2cFd = I2CMaster_Open(i2cInterfaceId)) < 0)
	{
		return -1;
	}
	dev.dev_id = (uint8_t) i2cDeviceAddr & 0x7F;
	
	if ((rslt = bme280_init(&dev)) != BME280_OK)
	{
		return -1;
	}

	uint8_t settings_sel = BME280_OSR_PRESS_SEL | BME280_OSR_TEMP_SEL | BME280_OSR_HUM_SEL | BME280_FILTER_SEL | BME280_STANDBY_SEL;
	if ((rslt = bme280_set_sensor_settings(settings_sel, &dev)) != BME280_OK)
	{
		return -1;
	}

	Log_Debug("[BME280] initialisation completed.\n");
	return i2cFd;
}

///<summary>
/// Reads temperature [°C], pressure [Pa] and humidity [%] from BME280 sensor
///</summary>
///<param name="pData">pointer to <see href="bme280_data_t">bme280_data_t</see> structure receiving output</param>
///<returns>0 if successful, -1 if error</returns>
int BME280_GetSensorData(bme280_data_t *pData) {
	int8_t rslt = BME280_OK;
	//uint8_t settings_sel = BME280_OSR_PRESS_SEL | BME280_OSR_TEMP_SEL | BME280_OSR_HUM_SEL | BME280_FILTER_SEL;
	//rslt = bme280_set_sensor_settings(settings_sel, &dev);

	//rslt = bme280_set_sensor_mode(BME280_FORCED_MODE, &dev);

	if ((rslt = bme280_set_sensor_mode(BME280_FORCED_MODE, &dev)) != BME280_OK)
	{
		return -1;
	}
	
	user_delay_ms(40);
#ifndef BME280_FLOAT_ENABLE
	struct bme280_data comp_data;
	rslt = bme280_get_sensor_data(BME280_ALL, &comp_data, &dev);
	print_sensor_data(&comp_data);
	/// [JSchwert] work in progress to get the compressed data structure converted
#else
	rslt = bme280_get_sensor_data(BME280_ALL, (struct bme280_data *) pData, &dev);
	print_sensor_data((struct bme280_data *) pData);
#endif
	if (rslt != BME280_OK)
	{
		return -1;
	}

	return 0;
}