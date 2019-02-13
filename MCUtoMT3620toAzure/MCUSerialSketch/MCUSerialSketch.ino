float temp, humidity;
String message;

void setup() {
	Serial.begin(9600);
	pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
	// turn LED on and output randomized temperature and humidity once per second
	digitalWrite(LED_BUILTIN, LOW);
	temp = random(7100, 7500);
	humidity = random(3000, 4000);
	message = "Temperature:";
	message += temp / 100;
	message += ";Humidity:";
	message += humidity / 100;
	Serial.println(message);
	delay(100);
	// turn LED off
	digitalWrite(LED_BUILTIN, HIGH);
	delay(900);
}
