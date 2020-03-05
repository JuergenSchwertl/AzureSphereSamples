#include "DHT11.h"

/*
*  DHTlib.c:
*	reads temperature and humidity from DHT11 or DHT22 sensor and outputs according to selected mode
*      initial Author: Juergen Wolf-Hofer
*      Azure Sphere adaptation: Juergen Schwertl
*
*	DHT protocol as described in https://cdn-shop.adafruit.com/datasheets/DHT22.pdf
*   and for DHT11 in https://github.com/SeeedDocument/Grove_Temperature_and_Humidity_Sensor/raw/master/resources/DHT11.pdf
*	18ms low pulse from host initializes DHT
*	20-40 µs (1kOhm pullup pulls data to high)
*	80 µs low + 80 µs high initiates data transfer
*	50 µsec low pulse from sensor initiates bit
*	26-28 µsec ==> "0"
*	70 µsec ==> "1"
*	4 bytes data & 1 byte checksum
*/

// CONSTANTS 

#define MAX_TRANSITIONS		84				// (5bytes=40bits=80 transitions + 2 initial transitions+2 buffer)
#define THRESHOLD_COUNT		16
#define TIMEOUT_COUNT		50
#define READING_DELAY_TIME	{ 2, 0 }		// DHT11 needs minimum of 2 seconds to recover in between reads
#define START_DELAY_TIME	{ 0, 18000000 } // 18ms = 18.000.000nsec




// GLOBAL VARIABLES
static DHT_SensorData dhtLastReading;
static struct timespec tsEarliestRead;

static const struct timespec ctsReadingDelay = READING_DELAY_TIME;
static const struct timespec ctsStartDelay = START_DELAY_TIME;

// inline time utilities.
static inline bool TimerCompareLessOrEqual(const struct timespec *l, const struct timespec *r)
{
	return (l->tv_sec == r->tv_sec) ? (l->tv_nsec <= r->tv_nsec) : (l->tv_sec) <= (r->tv_sec);
}

static inline void TimerAdd(const struct timespec *s, const struct timespec *a, struct timespec *d)
{
	d->tv_sec = s->tv_sec + a->tv_sec;
	if ((d->tv_nsec = s->tv_nsec + a->tv_nsec) >= 1000000000) {
		d->tv_nsec -= 1000000000;
		d->tv_sec++;
	}
}


DHT_SensorData * DHT_ReadData(GPIO_Id gpioPin)
{
	struct timespec tsCurrent;
	clock_gettime(CLOCK_MONOTONIC, &tsCurrent);

	// check if read attempt is outside 2 second window
	if (TimerCompareLessOrEqual(&tsCurrent, &tsEarliestRead))
	{
		Log_Debug("[DHT] ERROR: Cannot read data from DHT within 2 second delay.\n");
		return NULL;
	}

	TimerAdd(&tsCurrent, &ctsReadingDelay, &tsEarliestRead);

	int fdGpioPin;
	GPIO_Value_Type gpioLastState = GPIO_Value_High;
	GPIO_Value_Type gpioNewState = GPIO_Value_High;
	uint8_t uSampleCnt = 0;
	uint8_t uBitCount = 0;
	uint8_t uTransitions = 0;
	uint8_t data[5];
	data[0] = data[1] = data[2] = data[3] = data[4] = 0;


	/* pull pin down for 18 milliseconds! (DHT11 requires this, for DHT22, 1ms would suffice)*/
	if ((fdGpioPin = GPIO_OpenAsOutput(gpioPin, GPIO_OutputMode_PushPull, GPIO_Value_Low)) < 0)
	{
		Log_Debug("[DHT] ERROR: Could not open GPIO #%d as output\n", gpioPin);
		return NULL;
	};

	nanosleep(&ctsStartDelay, NULL);
	close(fdGpioPin); // this closes the output port, yet the port remains in low state

					  // prepare to read the pin
	if ((fdGpioPin = GPIO_OpenAsInput(gpioPin)) < 0)
	{
		Log_Debug("[DHT] ERROR: Could not open GPIO #%d as input\n", gpioPin);
		return NULL;
	};

	// the pullup resistor draws the line to high. The protocol specs 20-40µs in high state 
	// until the DHT pulls it low for 80µs and high for 80µs each to initiate data transfer
	// since closing/re-opening the GPIO port as input takes ~30µs we may have already missed the initial high->low transition
	while ((gpioNewState != GPIO_Value_Low) && (uSampleCnt++ < TIMEOUT_COUNT))
	{
		GPIO_GetValue(fdGpioPin, &gpioNewState);
	}

	if (uSampleCnt >= TIMEOUT_COUNT) {
		Log_Debug("[DHT] ERROR: sensor timeout\n");
		close(fdGpioPin); //free GPIO pin on timeout
		return NULL;
	}

	uSampleCnt = 1;
	gpioLastState = gpioNewState;

	/* detect change and read data */
	for (uTransitions = 0; uTransitions < MAX_TRANSITIONS; uTransitions++) {
		/* Azure Sphere Timing: 1 loop iteration (count) is ~3µs */
		while ((gpioNewState == gpioLastState) && (uSampleCnt++ < TIMEOUT_COUNT)) {
			GPIO_GetValue(fdGpioPin, &gpioNewState);
		}

		if (uSampleCnt >= TIMEOUT_COUNT) {
			break;
		}

		/* ignore first 2 transitions: 80µs low -> 80µs high -> 50µs low */
		if ((uTransitions > 2) && (gpioLastState == GPIO_Value_High)) {
			/* shove each bit into the storage bytes */
			//uint8_t uByteIndex = uBitCount >> 3;
			register uint8_t *pDataByte = &data[ uBitCount >> 3 ];
			*pDataByte = (uint8_t) (*pDataByte << 1); // == <<1
			if (uSampleCnt > THRESHOLD_COUNT)
				*pDataByte |= 1;
			uBitCount++;
		}
		uSampleCnt = 0;
		gpioLastState = gpioNewState;
	}
	close(fdGpioPin); // free GPIO pin for next read

					  /*
					  * check if we read 40 bits (8bit x 5 ) + verify checksum in the last byte
					  * print it out if data is good
					  */
	if ((uBitCount >= 40) && (data[4] == ((data[0] + data[1] + data[2] + data[3]) & 0xFF))) {
		float h = (float)((((int)data[0]) << 8) + ((int)data[1])) / 10.0F;
		if (h > 100) {
			h = (float)data[0];	// for DHT11
		}
		float c = (float)(((data[2] & 0x7F) << 8) + data[3]) / 10.0F;
		if (c > 125) {
			c = (float)data[2];	// for DHT11
		}
		if (data[2] & 0x80) {
			c = -c;
		}
		dhtLastReading.Humidity = h;
		dhtLastReading.TemperatureCelsius = c;
		dhtLastReading.TemperatureFahrenheit = c * 1.8f + 32;

		Log_Debug("[DHT] Humidity = %.1f %% Temperature = %.1f *C (%.1f *F)\n",
			dhtLastReading.Humidity,
			dhtLastReading.TemperatureCelsius,
			dhtLastReading.TemperatureFahrenheit);

		return &dhtLastReading; // OK
	}
	else {
		Log_Debug("[DHT] ERROR: Data not good: %d %d %d %d checksum %d!=%d, skip\n", data[0], data[1], data[2], data[3], data[0] + data[1] + data[2] + data[3], data[4]);
		dhtLastReading.Humidity = dhtLastReading.TemperatureCelsius = dhtLastReading.TemperatureFahrenheit = -1;
		return NULL; // NOK
	}
}
