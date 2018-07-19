/*
* 
*/

#include "sensors.h"

/*
#define TEMP_SENSE_PIN                10
#define GEAR_IS1_SENSE_PIN            11
#define GEAR_IS2_SENSE_PIN            12
#define DRS_SENSE_PIN                 8
#define FUEL_SENSE_PIN                4
#define HPUMP_SENSE_PIN               5
#define FANS_SENSE_PIN                3
#define CLUTCH_SENSE_PIN              2
*/

unsigned int sensors_fanCurrent = 0,
            sensors_hpumpCurrent = 0,
            sensors_gearCurrent = 0,
            sensors_fuelCurrent = 0,
            sensors_clutchCurrent = 0,
            sensors_drsCurrent = 0,
            sensors_gcuTemp = 0;

unsigned int getTempSensor()
{
    unsigned int analogValue = 0;
    unsigned int voltTempSensor = 0;
    unsigned int convTempSensor = 0;
    analogValue = ADC1_Read(TEMP_SENSE_PIN);
    sensors_gcuTemp = sensors_gcuTemp * 0.95 + analogValue * 0.05;
    voltTempSensor = ((float)(sensors_gcuTemp * 5)/4095.0)*1000.0;
    convTempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
    return convTempSensor;
}
unsigned int getDRSSensor()
{
    unsigned int convDrsSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(DRS_SENSE_PIN);
    sensors_drsCurrent = sensors_drsCurrent * 0.95 + analogValue * 0.05;
    convDrsSensor = (((sensors_drsCurrent * 5.05 / 4095) * 1000) / 0.2);
    return convDrsSensor;
}
unsigned int getFuelSensor()
{
    unsigned int convFuelSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(FUEL_SENSE_PIN);
    sensors_fuelCurrent = sensors_fuelCurrent * 0.95 + analogValue * 0.05;
    convFuelSensor = (((sensors_fuelCurrent * 5.05 / 4095) * 1000) / 0.2);
    return  convFuelSensor;
}
unsigned int getGearSensor()
{
    unsigned int convGearSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(GEAR_IS1_SENSE_PIN);
    sensors_gearCurrent = sensors_gearCurrent * 0.95 + analogValue * 0.05;
    convGearSensor = sensors_gearCurrent;
    return convGearSensor;
}
unsigned int getClutchSensor()
{
    unsigned int convClutchSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(CLUTCH_SENSE_PIN);
    sensors_clutchCurrent = sensors_clutchCurrent * 0.95 + analogValue * 0.05;
    convClutchSensor = (((sensors_clutchCurrent * 5.05 / 4095) * 1000) / 0.2);
    return convClutchSensor;
}
unsigned int getHPumpSensor()
{
    unsigned int convHPumpSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(HPUMP_SENSE_PIN);
    sensors_hpumpCurrent = sensors_hpumpCurrent * 0.95 + analogValue * 0.05;
    convHPumpSensor = (((sensors_hPumpCurrent * 5.05 / 4095) * 1000) / 0.2);
    return convHPumpSensor;
}
unsigned int getFanSensor()
{
    unsigned int convFanSensor = 0;
    unsigned int analogValue = 0;
    analogValue = ADC1_Read(FANS_SENSE_PIN);
    sensors_fanCurrent = sensors_fanCurrent * 0.95 + analogValue * 0.05;
    convFanSensor = (((sensors_fanCurrent * 5.05 / 4095) * 1000) / 0.2);
    return convFanSensor;
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