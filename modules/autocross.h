/*
* autocross routine
*/

#ifndef AUTOCROSS_H
#define AUTOCROSS_H

#include "autocross_defaults.h"
#include "clutch.h"
#include "gearshift.h"
#include "efi.h"
#include "can.h"

#define CODE_SET_AUTOCROSS   2

#define AUTOCROSS_WORK_RATE_ms   25
#define CLUTCH_PULL_MAX_TIME_s 10
#define AUTOCROSS_CLUTCH_NOISE_LEVEL 10       //margin against accidental clutch lever pulling
#define AUTOCROSS_MAX_SHIFT_TIMES    22      //maximum number of tries to insert a new gear
#define AUTOCROSS_INTER_GEAR_TIME    500     //time after which a gearshift is considered succesful or failed

#define AUTOCROSS_NUM_PARAMS    9            //Number of autocross_params enum elements
#define AUTOCROSS_NUM_VALUES    3            //Number of autocross_values enum elements

extern unsigned int autocrossFb;

//float AUTOCROSS_WORK_RATE_ms = 25;

typedef enum{
    OFF_AUTOCROSS,
    START_AUTOCROSS,
    READY_AUTOCROSS,
    START_RELEASE_AUTOCROSS,
    RELEASING_AUTOCROSS,
    RUNNING_AUTOCROSS,
    STOPPING_AUTOCROSS
}autocross_states;

//when modifying entries update AUTOCROSS_NUM_PARAMS
typedef enum{
    RAMP_START_AUTOCROSS,
    RAMP_END_AUTOCROSS,
    RAMP_TIME_AUTOCROSS,
    //MANTAIN THE ORDER!!!!!!!!!
    RPM_LIMIT_1_2_AUTOCROSS,
    RPM_LIMIT_2_3_AUTOCROSS,
    RPM_LIMIT_3_4_AUTOCROSS,
    SPEED_LIMIT_1_2_AUTOCROSS,
    SPEED_LIMIT_2_3_AUTOCROSS,
    SPEED_LIMIT_3_4_AUTOCROSS
}autocross_params;



//when modifying entries update AUTOCROSS_NUM_VALUES
typedef enum{
    RPM_AUTOCROSS,
    WHEEL_SPEED_AUTOCROSS,
    APPS_AUTOCROSS
}autocross_values;

extern unsigned int gearShift_currentGear;

void autocross_init(void);

//Releases Clutch gradually
void autocross_execute(void);

//Checks if conditions are valid and modify the current state accordingly
void autocross_checkAndPrepare(void);

void autocross_stop(void);

void autocross_loadDefaultParams(void);

void autocross_updateParam(const autocross_params id, const int value);

void autocross_updateExternValue(const autocross_values id, const int value);

int autocross_getParam(const autocross_params id);

int autocross_getExternValue(const autocross_values id);

void autocross_forceState(const autocross_states newState);

void autocross_sendTimes(void);

void autocross_sendOneTime(time_id pos);

void autocross_sendAllTimes(void);


#endif