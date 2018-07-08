//
// 
//

#ifndef FIRMWARE_DRSHMOTOR_H
#define FIRMWARE_DRSHMOTOR_H

#define DRSMOTOR_PWM_PERIOD 0.020
//1% = 0.2ms
#define DRSHMOTOR_MAX_PWM_PERCENTAGE 10
#define DRSMOTOR_MIN_PWM_PERCENTAGE  5

#include "basic.h"
#include "dspic.h"

void DrsMotor_init(void);

void DrsMotor_setupPWM(void);

void DrsMotor_setPosition(unsigned char percentage);

#endif //FIRMWARE_CLUTCHMOTOR_H