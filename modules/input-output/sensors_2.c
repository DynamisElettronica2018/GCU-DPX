/*
  04/07/2018 ottobiano DPX
*/


#include "sensors_2.h"

/*#define CLUTCH_SENSE_PIN 2
#define FAN_SENSE_PIN 3
#define FUEL_SENSE_PIN 4
#define HPUMP_SENSE_PIN 5
#define DRS_SENSE_PIN 8
#define TEMP_SENSE_PIN 10
#define GEAR_IS1_SENSE_PIN 11
#define GEAR_IS2_SENSE_PIN 12*/

unsigned int getTempSensor()
{
    unsigned int analogValue = 0;
    unsigned int voltTempSensor = 0;
    unsigned int tempSensor = 0;
    analogValue = ADC1_Read(TEMP_SENSE_PIN);
    voltTempSensor = ((float)(analogValue * 5)/4095.0)*1000.0;
    tempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
    return tempSensor;
}
unsigned int getDRSSensor()
{
    unsigned int drsSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(DRS_SENSE_PIN);
    return drsSensor;
}
unsigned int getFuelSensor()
{
    unsigned int fuelSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(FUEL_SENSE_PIN);
    return  fuelSensor;
}
unsigned int getGearSensor()
{
    unsigned int gearSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(GEAR_IS1_SENSE_PIN);
    return gearSensor;
}
unsigned int getClutchSensor()
{
    unsigned int clutchSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(CLUTCH_SENSE_PIN);
    return clutchSensor;
}
unsigned int getHPumpSensor()
{
    unsigned int HPumpSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(HPUMP_SENSE_PIN);
    return HPumpSensor;
}
unsigned int getFanSensor()
{
    unsigned int fanSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(FAN_SENSE_PIN);
    return fanSensor;
}

void sendSensorsDebug1(void)
{
    unsigned int temp = 0;
    unsigned int drs = 0;
    unsigned int fuel = 0;
    temp = getTempSensor();
    drs = getDRSSensor();
    fuel = getFuelSensor();
    Can_resetWritePacket();
    Can_addIntToWritePacket(temp);
    Can_addIntToWritePacket(drs);
    Can_addIntToWritePacket(fuel);
    Can_addIntToWritePacket(0);
    Can_write(GCU_DEBUG_1_ID);
}

void sendSensorsDebug2(void)
{
    unsigned int gear = 0;
    unsigned int clutch = 0;
    unsigned int hPump = 0;
    unsigned int fan = 0;
    gear = getGearSensor();
    clutch = getClutchSensor();
    hPump = getHPumpSensor();
    fan = getFanSensor();
    Can_resetWritePacket();
    Can_addIntToWritePacket(gear);
    Can_addIntToWritePacket(clutch);
    Can_addIntToWritePacket(hPump);
    Can_addIntToWritePacket(fan);
    Can_write(GCU_DEBUG_2_ID);
}