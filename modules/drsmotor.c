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
    setTimer(TIMER3_DEVICE, DRSMOTOR_PWM_PERIOD);
    DrsMotor_setupPWM();
}

void DrsMotor_setupPWM(void) {
    OC1CON = 0x6; //DX SERVO PWM on Timer 3
    OC2CON = 0x6; //SX SERVO PWM on Timer 3
    DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(DRSMOTOR_PWM_PERIOD, TIMER3_PRESCALER);   //PRESCALER calcolato 256
    //There will be 100 possible steps on the 5-10% PWM range
    DRSMOTOR_PWM_MAX_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MAX_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PWM_MIN_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MIN_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
    OC1R = DRSMOTOR_PWM_MIN_VALUE;   //DX DRS SERVO
    OC2R = DRSMOTOR_PWM_MIN_VALUE;   //SX DRS SERVO
    //DRSMotor_setPosition(100);
}

void DrshMotor_setPosition(unsigned char percentage) {
    unsigned int pwmValue;
    pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
    if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
        pwmValue = DRSMOTOR_PWM_MAX_VALUE;
    } else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
        pwmValue = DRSMOTOR_PWM_MIN_VALUE;
    }
    OC1R = pwmValue;   //DX DRS SERVO
    OC2R = pwmValue;   //SX DRS SERVO
}