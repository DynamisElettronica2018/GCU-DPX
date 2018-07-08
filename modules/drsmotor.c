//
// Created by Aaron Russo on 16/07/16.
//

#include "clutchmotor.h"
#include "dsPIC.h"

unsigned int DRS_PWM_PERIOD_VALUE;
double DRS_PERCENTAGE_STEP;
unsigned int DRSMOTOR_PWM_MAX_VALUE;
unsigned int DRSMOTOR_PWM_MIN_VALUE;

onTimer2Interrupt
{
    clearTimer2();
}

void ClutchMotor_init(void) {
    setTimer(TIMER2_DEVICE, DRSMOTOR_PWM_PERIOD);
    ClutchMotor_setupPWM();
}

void ClutchMotor_setupPWM(void) {
    OC3CON = 0x6; //PWM on Timer 2
    DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(DRSMOTOR_PWM_PERIOD, TIMER2_PRESCALER);   //PRESCALER calcolato 256
    //There will be 100 possible steps on the 5-10% PWM range
    DRSMOTOR_PWM_MAX_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MAX_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PWM_MIN_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
                                                (DRSMOTOR_MIN_PWM_PERCENTAGE / 100.0));
    DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
    OC3R = DRSMOTOR_PWM_MIN_VALUE;
    ClutchMotor_setPosition(100);
}

void ClutchMotor_setPosition(unsigned char percentage) {
    unsigned int pwmValue;
    pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
    if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
        pwmValue = DRSMOTOR_PWM_MAX_VALUE;
    } else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
        pwmValue = DRSMOTOR_PWM_MIN_VALUE;
    }
    OC3RS = pwmValue;
}