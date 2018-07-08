//
// Created by Salvo 08/07/2018
//

#include "drs.h"

unsigned char drs_currentValue = 0;
unsigned int drsFb = 0;

void Drs_open(void)
{
    Drs_setDX(DRS_SERVO_DX_OPEN);
    Drs_setSX(DRS_SERVO_SX_OPEN);
}

void Drs_close(void)
{
    Drs_setDX(DRS_SERVO_DX_CLOSE);
    Drs_setSX(DRS_SERVO_SX_CLOSE);
}

void Drs_setDX(unsigned char percentage) {
    unsigned char actualPercentage = 0;
    if (percentage > 100) {
        actualPercentage = 100;
    } else {
        actualPercentage = percentage;
    }
    DrsMotor_setPositionDX(100 - actualPercentage);
    Drs_currentValue = actualPercentage;
}

void Drs_setSX(unsigned char percentage) {
    unsigned char actualPercentage = 0;
    if (percentage > 100) {
        actualPercentage = 100;
    } else {
        actualPercentage = percentage;
    }
    DrsMotor_setPositionSX(100 - actualPercentage);
    Drs_currentValue = actualPercentage;
}

unsigned char Drs_get(void) {
    return Drs_currentValue;
}