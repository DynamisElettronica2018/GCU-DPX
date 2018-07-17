/*
  04/07/2018 ottobiano DPX
*/
#include "sensors_2.h"

unsigned int getTempSensor()
{
     unsigned int analogValue = 0;
     unsigned int voltTempSensor = 0;
    analogValue = ADC1_Read(TEMP_SENSE_PIN);
    voltTempSensor = ((float)(analogValue * 5)/4095.0)*1000.0;
    voltTempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
    return voltTempSensor;
}
unsigned int getGearSensor()
{
    unsigned int analogValue = 0;
    unsigned int voltGearSensor = 0;
    analogValue = ADC1_Read(GEAR_SENSOR_PIN);
    voltGearSensor = analogValue;
    return voltGearSensor;
}