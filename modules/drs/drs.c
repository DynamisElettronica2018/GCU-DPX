//
// Created by Salvo 08/07/2018
//

#include "drs.h"
#include "sw.h"
#include "buzzer.h"

unsigned int drs_currentValue = 0;
unsigned int timer1_drsCounter = 0;
unsigned char drs_currentValueSX = 0;
unsigned char drs_currentValueDX = 0;
unsigned int drsFb = 0;

void Drs_initVoltReg(void)
{
   TRISGbits.TRISG12 = 0;
   LATGbits.LATG12 = 0;
}

void Drs_turnOnVoltReg(void)
{
   LATGbits.LATG12 = 1;
}

void Drs_turnOffVoltReg(void)
{
   LATGbits.LATG12 = 0;
}

void Drs_open(void)
{
    Drs_turnOnVoltReg();
    Drs_setDX(DRS_SERVO_DX_OPEN);
    Drs_setSX(DRS_SERVO_SX_OPEN);
    drs_currentValue = 1;
    //drs_currentValue = Drs_get();
    drsFb = (unsigned int)drs_currentValue;
    sendUpdatesSW(DRS_CODE);
    //Buzzer_bip();
}

void Drs_close(void)
{
    Drs_setDX(DRS_SERVO_DX_CLOSE);
    Drs_setSX(DRS_SERVO_SX_CLOSE);
    timer1_drsCounter = 0;
    drs_currentValue = 0;
    //drs_currentValue = Drs_get();
    drsFb = (unsigned int)drs_currentValue;
    sendUpdatesSW(DRS_CODE);
    //Buzzer_bip();
}

void Drs_setDX(unsigned char percentageDX) {
    unsigned char actualPercentageDX = 0;
    if (percentageDX > 100) {
        actualPercentageDX = 100;
    } else {
        actualPercentageDX = percentageDX;
    }
    DrsMotor_setPositionDX(100 - actualPercentageDX);
    drs_currentValueDX = actualPercentageDX;
}

void Drs_setSX(unsigned char percentageSX) {
    unsigned char actualPercentageSX = 0;
    if (percentageSX > 100) {
        actualPercentageSX = 100;
    } else {
        actualPercentageSX = percentageSX;
    }
    DrsMotor_setPositionSX(100 - actualPercentageSX);
    drs_currentValueSX = actualPercentageSX;
}

unsigned char Drs_getDX(void)
{
    return drs_currentValueDX;
}

unsigned char Drs_getSX(void)
{
    return drs_currentValueSX;
}

unsigned char Drs_get(void)
{
    unsigned char currentValueDX, currentvalueSX;
    currentValueSX = Drs_getSX();
    currentValueDX = Drs_getDX();
    if (currentValueSX > DRS_SERVO_CENTRAL_POSITION
        && currentValueDX < DRS_SERVO_CENTRAL_POSITION )
        {
           return 1; //DRS open
           //Buzzer_bip();
        }
    else if (currentValueSX < DRS_SERVO_CENTRAL_POSITION
        && currentValueDX > DRS_SERVO_CENTRAL_POSITION )
        {
           return 0; //DRS close
           //Buzzer_bip();
        }
}