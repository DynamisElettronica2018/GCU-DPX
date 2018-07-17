//Created by Salvo 08/07/2018

#ifndef FIRMWARE_DRS_H
#define FIRMWARE_DRS_H

#include "drsmotor.h"

//valori da sistemare testando
#define DRS_SERVO_SX_OPEN 60
#define DRS_SERVO_DX_OPEN 40
#define DRS_SERVO_SX_CLOSE 40
#define DRS_SERVO_DX_CLOSE 60
#define DRS_SERVO_CENTRAL_POSITION 50

extern unsigned int drsFb;

void Drs_open(void);

void Drs_close(void);

void Drs_setDX(unsigned char percentage);

void Drs_setSX(unsigned char percentage);

unsigned char Drs_getDX(void);

unsigned char Drs_getSX(void);

unsigned char Drs_get(void);

#endif //FIRMWARE_DRS_H