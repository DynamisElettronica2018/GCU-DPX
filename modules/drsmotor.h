//
// 
//

#ifndef FIRMWARE_DRSHMOTOR_H
#define FIRMWARE_DRSHMOTOR_H

#define DRSMOTOR_PWM_PERIOD 0.020
//1% = 0.2ms
#define DRSMOTOR_MAX_PWM_PERCENTAGE 10
#define DRSMOTOR_MIN_PWM_PERCENTAGE  5

#include "basic.h"
#include "dspic.h"

void DrsMotor_init(void);

void DrsMotorDX_setupPWM(void);

void DrsMotorSX_setupPWM(void);

void DrsMotor_setPositionDX(unsigned char percentage);

void DrsMotor_setPositionSX(unsigned char percentage);

#endif //FIRMWARE_DRSMOTOR_H