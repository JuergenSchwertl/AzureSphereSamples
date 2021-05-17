#include <bits/alltypes.h>
#include <stdlib.h>
#include <time.h>
#include <memory.h>
#include <applibs/log.h>
#include <applibs/i2c.h>

#include "libBME280.h"
#include "bme280_defs.h"
#include "bme280.h"

//#define VERBOSE 1

///<summary>
/// This is an Azure Sphere wrapper library for the Bosch BME280 
/// temperature-, humidity- and pressure-sensor
/// <see href="https://github.com/BoschSensortec/BME280_driver" />
/// connected to Azure Sphere via I2C (i.e. the Seeed Groove BME280 sensor board)
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
			osr_h: BME280_OVERSAMPLING_8X,
			osr_p : BME280_OVERSAMPLING_8X,
			osr_t : BME280_OVERSAMPLING_8X,
			filter : BME280_FILTER_COEFF_16,
			standby_time : BME280_STANDBY_TIME_500_MS
		}
};

///<summary>
/// platform dependant helper functions for bme280
///</sdummary>

int8_t user_i2c_read(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
{
	ssize_t rslt = I2CMaster_WriteThenRead(i2cFd, (I2C_DeviceAddress) (dev.dev_id), &reg_addr, 1, data, len);

#ifdef VERBOSE
	Log_Debug("[I2C read ] reg 0x%0.2x :", (unsigned int)reg_addr);
	for (ssize_t i = 0; i < len; i++)
	{
		Log_Debug(" %0.2x", (unsigned int) data[i]);
	}
	Log_Debug("\n");
#endif

	return (rslt != -1) ? BME280_OK : BME280_E_COMM_FAIL;
}

void user_delay_ms(uint32_t period)
{
	struct timespec t = { 0, (long)period * 1000l * 1000l};
	nanosleep(&t, NULL);
}

int8_t user_i2c_write(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
{
	ssize_t rslt = -1;
	size_t len2 = (size_t)len + 1;
	uint8_t *buf = malloc(len2);

	if (buf != NULL)
	{
		buf[0] = reg_addr;
		memcpy(buf + 1, data, (size_t)len);

#ifdef VERBOSE
		Log_Debug("[I2C write] reg 0x%0.2x :", (unsigned int)buf[0]);
		for (ssize_t i = 1; i < len2; i++)
		{
			Log_Debug(" %0.2x", (unsigned int)buf[i]);
		}
		Log_Debug("\n");
#endif

		rslt = I2CMaster_Write(i2cFd, (I2C_DeviceAddress)dev.dev_id, buf, len2);
		
		free(buf);
	}
	return (rslt != -1) ? BME280_OK : BME280_E_COMM_FAIL;
}




void print_sensor_data(struct bme280_data *comp_data)
{
#ifdef DEBUG
#ifdef BME280_FLOAT_ENABLE
	Log_Debug("[BME280] Temperature: %0.2f °C, Pressure: %0.2f Pa, Humidity: %0.2f %%\n", 
		comp_data->temperature, comp_data->pressure, comp_data->humidity);
#else
	Log_Debug("[BME280] Temperature: %ld [°C * 100], Pressure: %ld [Pa], Humidity: %ld [%% * 100]\n", 
		comp_data->temperature, comp_data->pressure, comp_data->humidity);
#endif
#endif
}

///<summary>
///Initialize BME280 sensor at device address
///</summary>
///<param name="i2cInterfaceFd">Interface Id of Azure Sphere I2C ISU block</param>
///<param name="onPrimaryI2CAddress">use primary I2C bus address of BME 280 sensor</param>
///<returns>true if successful, false if error</returns>
bool BME280_Init(int i2cInterfaceFd, bool onPrimaryI2CAddress)
{
	int8_t rslt = BME280_OK;

	i2cFd = i2cInterfaceFd;
	dev.dev_id = onPrimaryI2CAddress ? BME280_I2C_ADDR_PRIM : BME280_I2C_ADDR_SEC;
	
	if ((rslt = bme280_init(&dev)) != BME280_OK)
	{
		Log_Debug("ERROR: could not initialize BME280");
		return false;
	}

	uint8_t settings_sel = BME280_OSR_PRESS_SEL | BME280_OSR_TEMP_SEL | BME280_OSR_HUM_SEL | BME280_FILTER_SEL | BME280_STANDBY_SEL;

	if ((rslt = bme280_set_sensor_settings(settings_sel, &dev)) != BME280_OK)
	{
		Log_Debug("ERROR: could not set BME280 sensor settings");
		return false;
	}

	if ((rslt = bme280_set_sensor_mode(BME280_NORMAL_MODE, &dev)) != BME280_OK)
	{
		Log_Debug("ERROR: could not set BME280 sensor mode");
		return false;
	}

	return true;
}

///<summary>
/// Reads temperature [°C], pressure [Pa] and humidity [%] from BME280 sensor
///</summary>
///<param name="pData">pointer to <see href="bme280_data_t">bme280_data_t</see> structure receiving output</param>
///<returns>0 if successful, -1 if error</returns>
int BME280_GetSensorData(bme280_data_t *pData) {
	int8_t rslt = BME280_OK;
	struct bme280_data comp_data;
	//const struct timespec tWait = { 1,0 };
#ifndef BME280_FLOAT_ENABLE
	rslt = bme280_get_sensor_data(BME280_ALL, &comp_data, &dev);
	pData->temperature = ((double)comp_data.temperature) / 100;
	pData->humidity = ((double)comp_data.humidity) / 1000;
	pData->pressure = ((double)comp_data.pressure) / 1000;
#else
	rslt = bme280_get_sensor_data(BME280_ALL, &comp_data, &dev);
	pData->temperature = comp_data.temperature;
	pData->humidity = comp_data.humidity;
	pData->pressure = comp_data.pressure / 100.0; // normalize to hPa
#endif
	if (rslt != BME280_OK)
	{
		return -1;
	}
	print_sensor_data(&comp_data);
	return 0;
}
