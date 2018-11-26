//
// Created by Aaron Russo on 16/07/16.
//

#include "drsmotor.h"
#include "dsPIC.h"

unsigned int DRSMOTOR_PWM_PERIOD_VALUE;
double DRSMOTOR_PERCENTAGE_STEP;
unsigned int DRSMOTOR_PWM_MAX_VALUE;
unsigned int DRSMOTOR_PWM_MIN_VALUE;

onTimer3Interrupt{
    clearTimer3();
}

void DrsMotor_init(void) {
    //setTimer(TIMER3_DEVICE, DRSMOTOR_PWM_PERIOD);
    DrsMotorDX_setupPWM();
    DrsMotorSX_setupPWM();
}

void DrsMotorDX_setupPWM(void) {
    OC1CON = 0x6; //DX SERVO PWM on Timer 3
    DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(DRSMOTOR_PWM_PERIOD, TIMER2_PRESCALER);   //PRESCALER calcolato 256
    //There will be 100 possible steps on the 5-10% PWM range
    DRSMOTOR_PWM_MAX_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MAX_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PWM_MIN_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MIN_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
    OC1R = DRSMOTOR_PWM_MIN_VALUE;   //DX DRS SERVO
    //DRSMotor_setPosition(100);
}

void DrsMotorSX_setupPWM(void) {
    OC2CON = 0x6; //SX SERVO PWM on Timer 3
    DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(DRSMOTOR_PWM_PERIOD, TIMER2_PRESCALER);   //PRESCALER calcolato 256
    //There will be 100 possible steps on the 5-10% PWM range
    DRSMOTOR_PWM_MAX_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MAX_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PWM_MIN_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MIN_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
    OC2R = DRSMOTOR_PWM_MIN_VALUE;   //SX DRS SERVO
    //DRSMotor_setPosition(100);
}

void DrsMotor_setPositionDX(unsigned char percentage) {
    unsigned int pwmValue;
    pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
    if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
        pwmValue = DRSMOTOR_PWM_MAX_VALUE;
    } else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
        pwmValue = DRSMOTOR_PWM_MIN_VALUE;
    }
    OC1RS = pwmValue;   //DX DRS SERVO
}

void DrsMotor_setPositionSX(unsigned char percentage) {
    unsigned int pwmValue;
    pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
    if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
        pwmValue = DRSMOTOR_PWM_MAX_VALUE;
    } else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
        pwmValue = DRSMOTOR_PWM_MIN_VALUE;
    }
    OC2RS = pwmValue;   //SX DRS SERVO
}