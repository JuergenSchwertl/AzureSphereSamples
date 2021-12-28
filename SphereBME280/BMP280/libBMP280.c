#include <bits/alltypes.h>
#include <stdlib.h>
#include <time.h>
#include <memory.h>
#include <applibs/log.h>
#include <applibs/i2c.h>

#include "libBMP280.h"
#include "bmp280_defs.h"
#include "bmp280.h"

//#define VERBOSE 1

/// @brief This is an Azure Sphere wrapper library for the Bosch BME280 
/// temperature-, humidity- and pressure-sensor
/// <see href="https://github.com/BoschSensortec/BME280_driver" />
/// connected to Azure Sphere via I2C (i.e. the Seeed Groove BME280 sensor board)
/// <see href="http://wiki.seeedstudio.com/Grove-Barometer_Sensor-BME280/" />
///

/// @brief forward declarations of platform dependent helper functions for the Bosch BME280 driver
static int8_t user_i2c_read(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len);
static void user_delay_ms(uint32_t period);
static int8_t user_i2c_write(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len);


/// @brief 
/// File descriptor for I2C ISU block
///
static int i2cFd = -1;

/// @brief 
/// <see href="bme280_dev">bme280_dev</see> structure with platform dependent callbacks, calibration data and settings
///
struct bmp280_dev bmp = {
		chip_id:0,
		dev_id : BMP280_I2C_ADDR_PRIM,
		intf : BMP280_I2C_INTF,
		read : user_i2c_read,
		write : user_i2c_write,
		delay_ms : user_delay_ms,
		calib_param : {0},
		conf : {0}
};

/// @brief platform dependant helper functions for bmp280

static int8_t user_i2c_read(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
{
	ssize_t rslt = I2CMaster_WriteThenRead(i2cFd, (I2C_DeviceAddress) (bmp.dev_id), &reg_addr, 1, data, len);

#ifdef VERBOSE
	Log_Debug("[I2C read ] reg 0x%0.2x :", (unsigned int)reg_addr);
	for (ssize_t i = 0; i < len; i++)
	{
		Log_Debug(" %0.2x", (unsigned int) data[i]);
	}
	Log_Debug("\n");
#endif

	return (rslt != -1) ? BMP280_OK : BMP280_E_COMM_FAIL;
}

static void user_delay_ms(uint32_t period)
{
	struct timespec t = { 0, (long)period * 1000l * 1000l };
	nanosleep(&t, NULL);
}

static int8_t user_i2c_write(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
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

		rslt = I2CMaster_Write(i2cFd, (I2C_DeviceAddress)bmp.dev_id, buf, len2);
		
		free(buf);
	}
	return (rslt != -1) ? BMP280_OK : BMP280_E_COMM_FAIL;
}

bool BMP280_Init(int i2cInterfaceFd, bool onPrimaryI2CAddress)
{
	int8_t rslt = BMP280_OK;
	struct bmp280_config conf;

	i2cFd = i2cInterfaceFd;
	bmp.dev_id = onPrimaryI2CAddress ? BMP280_I2C_ADDR_PRIM : BMP280_I2C_ADDR_SEC;
	
	if ((rslt = bmp280_init(&bmp)) != BMP280_OK)
	{
		Log_Debug("ERROR: could not initialize BMP280");
		return false;
	}

	rslt = bmp280_get_config(&conf, &bmp);

   /* configuring the temperature oversampling, filter coefficient and output data rate */
    /* Overwrite the desired settings */
    conf.filter = BMP280_FILTER_COEFF_16;

	/* Temperature oversampling set at 2x */
    conf.os_temp = BMP280_OS_2X;

    /* Pressure oversampling set at 16x */
    conf.os_pres = BMP280_OS_16X;

	/* Setting the output data rate as 1HZ(1000ms) */
    conf.odr = BMP280_ODR_1000_MS;


	rslt = bmp280_set_config(&conf, &bmp);

	
	/* Always set the power mode after setting the configuration */
	if ((rslt = bmp280_set_power_mode(BMP280_NORMAL_MODE, &bmp)) != BMP280_OK)
	{
		Log_Debug("ERROR: could not set BMP280 sensor power mode");
		return false;
	}

	return true;
}


int BMP280_GetSensorData(bmp280_data_t *pData) {
	int8_t rslt;
	struct bmp280_uncomp_data ucomp_data;
	double pressure;
	double temperature;

	if( pData == NULL)
	{
		return BMP280_E_NULL_PTR;
	}

	/* Reading the raw data from sensor */
    rslt = bmp280_get_uncomp_data(&ucomp_data, &bmp);

	/* Getting the compensated pressure as floating point value */
    rslt = bmp280_get_comp_pres_double(&pressure, ucomp_data.uncomp_press, &bmp);
	pData->pressure = pressure / 100.0; // normalize to hPa

	/* Getting the compensated temperature as floating point value */
    rslt = bmp280_get_comp_temp_double(&temperature, ucomp_data.uncomp_temp, &bmp);
	pData->temperature = temperature;

	if (rslt != BMP280_OK)
	{
		return -1;
	}
	Log_Debug("[BMP280] Temperature: %0.2f degC, Pressure: %0.2f Pa\n", temperature, pressure);

	return 0;
}
