/*
  04/07/2018 ottobiano DPX
*/

#ifndef FIRMWARE_SENSORS_2_H
#define FIRMWARE_SENSORS_2_H

#include "can.h"
#include "dspic.h"

#define CLUTCH_SENSE_PIN 2
#define FAN_SENSE_PIN 3
#define FUEL_SENSE_PIN 4
#define HPUMP_SENSE_PIN 5
#define DRS_SENSE_PIN 8
#define TEMP_SENSE_PIN 10
#define GEAR_IS1_SENSE_PIN 11
#define GEAR_IS2_SENSE_PIN 12

unsigned int getTempSensor();
unsigned int getDRSSensor();
unsigned int getFuelSensor();
unsigned int getGearSensor();
unsigned int getClutchSensor();
unsigned int getHPumpSensor();
unsigned int getFanSensor();

void sendSensorsDebug1(void);

void sendSensorsDebug2(void);

#endif //FIRMWARE_SENSORS_2_H