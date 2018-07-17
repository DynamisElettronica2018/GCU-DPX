/*
*
*/

#include "antistall.h"
#include "sw.h"

antistall_states antistall_currentState;
int antistall_parameters[ANTISTALL_NUM_PARAMS];
int antistall_externValues[ANTISTALL_NUM_VALUES];
int antistall_dtRelease;
int antistall_timesCoutner;

unsigned int antistallFb = 0;

unsigned int antistall_clutchValue;

void antistall_init(void)
{
        antistall_currentState = OFF_ANTISTALL;
        antistall_loadDefaultParams();
}

void antistall_execute(void)
{
        switch (antistall_currentState)
        {
                case START_ANTISTALL:
                        antistall_currentState = PULLING_ANTISTALL;
                        return;
                case PULLING_ANTISTALL:
                        antistall_clutchValue = antistall_parameters[CLUTCH_PULL];
                        Clutch_set(antistall_clutchValue);
                        return;
                case STOPPING_ANTISTALL:
                        antistall_currentState = OFF_ANTISTALL;
                        Clutch_set(0);
                        return;
                default:
                        return;
        }
}

void antistall_checkPlausibility(void)
{
        if (antistall_externValues[RPM] < antistall_parameters[RPM_LIMIT_ANTISTALL]
                && antistall_externValues[WHEEL_SPEED] < antistall_parameters[SPEED_LIMIT_ANTISTALL])
        
        {
                antistall_currentState = START_ANTISTALL;
                antistallFb = 1;
                sendUpdatesSW(ANTISTALL_CODE);
        }
}

void antistall_loadDefaultParams(void){
//Use defaults only if eeprom unavailable
#ifndef ANTISTALL_EEPROM_H
    antistall_parameters[RPM_LIMIT_ANTISTALL]         = DEF_RPM_LIMIT_ANTISTALL;
    antistall_parameters[SPEED_LIMIT_ANTISTALL] = DEF_SPEED_LIMIT_ANTISTALL;
    antistall_parameters[CLUTCH_PULL]                        = DEF_CLUTCH_PULL;
#endif
}

void antistall_updateParam(const antistall_params id, const int value){
    if(id < ANTISTALL_NUM_PARAMS)
        antistall_parameters[id] = value;
}

void antistall_stop(void){
    if(antistall_currentState != OFF_ANTISTALL)
    {
        antistall_currentState = STOPPING_ANTISTALL;
        antistallFb = 0;
                sendUpdatesSW(ANTISTALL_CODE);
    }
}

void antistall_updateExternValue(const antistall_values id, const int value){
    if(id < ANTISTALL_NUM_VALUES)
        antistall_externValues[id] = value;
}

int antistall_getParam(const antistall_params id){
    if(id < ANTISTALL_NUM_PARAMS)
        return antistall_parameters[id];
    return -1;
}

int antistall_getExternValue(const antistall_params id){
    if(id < ANTISTALL_NUM_VALUES)
        return antistall_externValues[id];
    return -1;
}