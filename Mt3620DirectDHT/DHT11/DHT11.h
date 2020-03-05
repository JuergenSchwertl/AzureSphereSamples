#ifndef DHTLIB_H
#define DHTLIB_H

#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>
#include <applibs/gpio.h>
#include <applibs/log.h>

typedef struct DHT_SensorData {
	float Humidity;
	float TemperatureCelsius;
	float TemperatureFahrenheit;
} DHT_SensorData;


DHT_SensorData * DHT_ReadData(GPIO_Id gpioPin);

#endif //#ifndef DHTLIB_H