// Programa : Sensor de temperatura DS18B20
 
/*-----( Import needed libraries )-----*/
// Get 1-wire Library here: http://www.pjrc.com/teensy/arduino_libraries/OneWire.zip
#include <OneWire.h>
//Get DallasTemperature Library here: http://www.hacktronics.com/code/DallasTemperature.zip
#include <DallasTemperature.h>
 
// Porta do pino de sinal do DS18B20
#define ONE_WIRE_BUS 10
 
// Define uma instancia do oneWire para comunicacao com o sensor
OneWire oneWire(ONE_WIRE_BUS);
 
DallasTemperature sensors(&oneWire);
DeviceAddress sensor1;
DeviceAddress sensor2;
 
void setup(void)
{
  Serial.begin(9600);
  sensors.begin(); 
  if (!sensors.getAddress(sensor1, 0)) 
     Serial.println("Sensor 1 nao encontrados !"); 
  if (!sensors.getAddress(sensor2, 1)) 
     Serial.println("Sensor 2 nao encontrados !");   
}
 
void loop()
{
  // Le a informacao do sensor
  sensors.requestTemperatures();
  float temp_1 = sensors.getTempC(sensor1);
  float temp_2 = sensors.getTempC(sensor2);
  
  // Mostra dados no serial monitor
  Serial.print("!");
  Serial.print(temp_1);
  Serial.println();
  Serial.print("?");
  Serial.print(temp_2);
  Serial.println();
  delay(1000);
}
