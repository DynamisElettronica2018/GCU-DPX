/*
* 
*/

#ifndef ANTISTALL_H
#define ANTISTALL_H

#include "antistall_defaults.h"
#include "clutch.h"
#include "gearshift.h"
#include "efi.h"
#include "can.h"
#include "buzzer.h"

#define ANTISTALL_WORK_RATE_ms                   25
#define ANTISTALL_CLUTCH_RESET_LEVEL        50
#define ANTISTALL_NUM_PARAMS                          3
#define ANTISTALL_NUM_VALUES                         3

extern unsigned int antistallFb;

typedef enum{
    OFF_ANTISTALL,
    START_ANTISTALL,
    PULLING_ANTISTALL,
    STOPPING_ANTISTALL
}antistall_states;

typedef enum{
    RPM_LIMIT_ANTISTALL,
    SPEED_LIMIT_ANTISTALL,
    CLUTCH_PULL
}antistall_params;

typedef enum{
    RPM,
    WHEEL_SPEED,
    APPS
}antistall_values;

extern unsigned int gearShift_currentGear;

void antistall_init(void);
void antistall_stop(void);
void antistall_checkPlausibility(void);

void antistall_execute(void);

void antistall_checkPlausibility(void);

void antistall_loadDefaultParams(void);

void antistall_updateParam(const antistall_params id, const int value);

void antistall_updateExternValue(const antistall_values id, const int value);

int antistall_getParam(const antistall_params id);

int antistall_getExternValue(const antistall_values id);

void antistall_forceState(const antistall_states newState);

#endif