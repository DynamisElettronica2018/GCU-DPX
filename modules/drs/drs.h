//Created by Salvo 08/07/2018

#ifndef DRS_H
#define DRS_H


#include "drsmotor.h"

//valori da sistemare tes.tando
#define DRS_SERVO_SX_OPEN 0
#define DRS_SERVO_DX_OPEN 100
#define DRS_SERVO_SX_CLOSE 100
#define DRS_SERVO_DX_CLOSE 0
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