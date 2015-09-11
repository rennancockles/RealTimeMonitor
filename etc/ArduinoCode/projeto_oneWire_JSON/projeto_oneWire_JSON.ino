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
DeviceAddress sensor0;
DeviceAddress sensor1;

int adress0;
int adress1;
 
void setup(void)
{
  Serial.begin(9600);
  sensors.begin();   
}
 
void loop()
{
  // Get sensor adress 
  adress0 = sensors.getAddress(sensor0, 0);
  adress1 = sensors.getAddress(sensor1, 1);
  
  // Read sensors
  sensors.requestTemperatures();
  float temp_0 = sensors.getTempC(sensor0);
  float temp_1 = sensors.getTempC(sensor1);

  //Print JSON format
  Serial.println("{");
  
  Serial.print("'sensors':[");
  Serial.print(adress0);
  Serial.print(",");
  Serial.print(adress1);
  Serial.println("],");
  
  Serial.print("'temp':[");
  Serial.print(temp_0);
  Serial.print(",");
  Serial.print(temp_1);
  Serial.println("]");

  Serial.println("}");
  
  delay(1000);
}
