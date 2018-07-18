/*
* 
*/

#ifndef SENSORS_H
#define SENSORS_H

#include "can.h"
#include "dspic.h"

#define TEMP_SENSE_PIN                10
#define GEAR_IS1_SENSE_PIN            11
#define GEAR_IS2_SENSE_PIN            12
#define DRS_SENSE_PIN                 8
#define FUEL_SENSE_PIN                4
#define HPUMP_SENSE_PIN               5
#define FANS_SENSE_PIN                3
#define CLUTCH_SENSE_PIN              2

unsigned int getTempSensor();
unsigned int getDRSSensor();
unsigned int getFuelSensor();
unsigned int getGearSensor();
unsigned int getClutchSensor();
unsigned int getHPumpSensor();
unsigned int getFanSensor();

void sendSensorsDebug1(void);

void sendSensorsDebug2(void);

#endif