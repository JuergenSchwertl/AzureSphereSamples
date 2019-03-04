#include <bits/alltypes.h>
#include <stdlib.h>
#include <time.h>
#include <memory.h>
#include <applibs/log.h>

#include "libBME280.h"
#include "bme280_defs.h"
#include "bme280.h"


///<summary>
/// This is an Azure Sphere wrapper library for the high quality
/// Bosch BME280 temperature-, humidity- and pressure-sensor
/// <see href="https://github.com/BoschSensortec/BME280_driver" />
/// connected to Azure Sphere via I2Cbis (i.e. the Seeed Groove BME280 sensor board)
/// <see href="http://wiki.seeedstudio.com/Grove-Barometer_Sensor-BME280/" />
///</summary>

int8_t user_i2c_read(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len);
void user_delay_ms(uint32_t period);
int8_t user_i2c_write(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len);


static int i2cFd = -1;
static I2C_DeviceAddress i2cBME280Address = 0;
struct bme280_dev dev = {
		chip_id:0,
		dev_id : 0,
		intf : BME280_I2C_INTF,
		read : user_i2c_read,
		write : user_i2c_write,
		delay_ms : user_delay_ms,
		calib_data : {0},
		settings : {
			osr_h: BME280_OVERSAMPLING_1X,
			osr_p : BME280_OVERSAMPLING_16X,
			osr_t : BME280_OVERSAMPLING_2X,
			filter : BME280_FILTER_COEFF_16
		}
};

///<summary>
///helper functions for bme280
///</sdummary>

int8_t user_i2c_read(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
{
	ssize_t rslt = I2CMaster_WriteThenRead(i2cFd, (I2C_DeviceAddress) (dev.dev_id), &reg_addr, 1, data, len);
	//write(i2cFd, &reg_addr, 1);
	//read(i2cFd, data, len);
	return (int8_t) rslt;
}

void user_delay_ms(uint32_t period)
{
	struct timespec t = { 0, (long)period * 1000l };
	nanosleep(&t, NULL);
}

int8_t user_i2c_write(uint8_t id, uint8_t reg_addr, uint8_t *data, uint16_t len)
{
	uint8_t *buf;
	buf = malloc((size_t)len + 1);
	buf[0] = reg_addr;
	memcpy(buf + 1, data, (size_t)len);
	ssize_t rslt = I2CMaster_Write(i2cFd, (I2C_DeviceAddress) dev.dev_id, data, (size_t)len+1);
	//write(i2cFd, buf, len + 1);
	free(buf);
	return (int8_t)rslt;
}




void print_sensor_data(struct bme280_data *comp_data)
{
#ifdef BME280_FLOAT_ENABLE
	Log_Debug("temp %0.2f, p %0.2f, hum %0.2f\r\n", comp_data->temperature, comp_data->pressure, comp_data->humidity);
#else
	Log_Debug("temp %ld, p %ld, hum %ld\r\n", comp_data->temperature, comp_data->pressure, comp_data->humidity);
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
	i2cBME280Address = i2cDeviceAddr;
	i2cFd = I2CMaster_Open(i2cInterfaceId);
	if (i2cFd < 0)
	{
		return -1;
	}
	dev.dev_id = (uint8_t) i2cDeviceAddr & 0x7F;
	rslt = bme280_init(&dev);
	if (rslt != BME280_OK)
	{
		return -1;
	}

	return i2cFd;
}


void BME280_GetSensorData( void )
{
	int8_t rslt = BME280_OK;
	struct bme280_data comp_data;

	uint8_t settings_sel = BME280_OSR_PRESS_SEL | BME280_OSR_TEMP_SEL | BME280_OSR_HUM_SEL | BME280_FILTER_SEL;
	rslt = bme280_set_sensor_settings(settings_sel, &dev);

	rslt = bme280_set_sensor_mode(BME280_FORCED_MODE, &dev);
	user_delay_ms(40);
	rslt = bme280_get_sensor_data(BME280_ALL, &comp_data, &dev);
	if (rslt != BME280_OK)
	{
		return;
	}
	print_sensor_data(&comp_data);
}