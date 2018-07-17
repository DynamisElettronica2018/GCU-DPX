#include "autocross.h"

autocross_states autocross_currentState;
int autocross_parameters[AUTOCROSS_NUM_PARAMS];
int autocross_externValues[AUTOCROSS_NUM_VALUES];
int autocross_dtRelease;      //counter for clutch "slow" release
char autocross_sendingAll = FALSE;
int autocross_timesCounter;
unsigned int autocrossFb = 0;

/*
int autocross_shiftTry = 0;
int autocross_shiftCounter = 0;
int autocross_targetGear = -1;
//*/
float autocross_clutchStep;   //step for each "frame" of autocross
float autocross_clutchValue;

void autocross_init(void){
    autocross_currentState = OFF_AUTOCROSS;
    autocross_loadDefaultParams();
}

void autocross_execute(void){
    switch (autocross_currentState) {
        case START_AUTOCROSS:
            Efi_setRPMLimiter();
            autocrossFb = 1;
//            Activate Launch Control
            autocross_currentState = READY_AUTOCROSS;
            autocross_clutchValue = 100;
            Clutch_set((unsigned int)autocross_clutchValue);
            autocrossFb = 1;
            sendUpdatesSW(AUTOX_CODE);
            return;
        case READY_AUTOCROSS:
            Clutch_set(100);
            return;
        case START_RELEASE_AUTOCROSS:
             autocrossFb = 2;
            autocross_clutchValue = autocross_parameters[RAMP_START_AUTOCROSS];
            Clutch_set(autocross_clutchValue);
            autocross_dtRelease = autocross_parameters[RAMP_TIME_AUTOCROSS] / AUTOCROSS_WORK_RATE_ms;
            autocross_clutchStep = ((float)(autocross_parameters[RAMP_START_AUTOCROSS] - autocross_parameters[RAMP_END_AUTOCROSS]) * AUTOCROSS_WORK_RATE_ms) / (float)autocross_parameters[RAMP_TIME_AUTOCROSS];
            autocross_currentState = RELEASING_AUTOCROSS;
            autocrossFb = 2;
            sendUpdatesSW(AUTOX_CODE);
            return;
        case RELEASING_AUTOCROSS:
//             Clutch_set(autocross_parameters[RAMP_END] + (autocross_clutchStep * autocross_dtRelease));        //Works iff the cluth paddle is disabled
            autocross_clutchValue = autocross_clutchValue - autocross_clutchStep;
            Clutch_set((unsigned char)autocross_clutchValue);
            autocross_dtRelease--;
            if(autocross_dtRelease <= 0 || Clutch_get() <= autocross_parameters[RAMP_END_AUTOCROSS]){
                Clutch_set(0);
                Efi_unsetRPMLimiter();
                autocross_currentState = RUNNING_AUTOCROSS;                 //For gearshift  Use alternatively to autocross_stop
//UNCOMMENT FOR CLUTCH ONLY
               // autocross_stop();                               //For not gearshift (clutch only)
            }
            Buzzer_bip();
            return;
        case RUNNING_AUTOCROSS:
        //Check condizioni e cambio
            if(gearShift_currentGear == 2){         //autocross finisce dopo aver inserito la seconda marcia in automatico
                autocross_stop();
                return;
            }
        //parameters for gear is taken using as a index the baseline (RPM_LIMIT_1_2) + (gear - 1)
            if(autocross_externValues[RPM_AUTOCROSS] >= autocross_parameters[RPM_LIMIT_1_2_AUTOCROSS + gearShift_currentGear - 1]
              && autocross_externValues[WHEEL_SPEED_AUTOCROSS] >= autocross_parameters[SPEED_LIMIT_1_2_AUTOCROSS + gearShift_currentGear - 1]){
                GearShift_up();
            }
            return;
        case STOPPING_AUTOCROSS:
            autocross_currentState = OFF_AUTOCROSS;
            return;
        //gearshift check
        default: return;
    }
}


void autocross_loadDefaultParams(void){
//Use defaults only if eeprom unavailable
#ifndef AUTOCROSS_EEPROM_H
    autocross_parameters[RAMP_START_AUTOCROSS]      = DEF_RAMP_START_AUTOCROSS;
    autocross_parameters[RAMP_END_AUTOCROSS]        = DEF_RAMP_END_AUTOCROSS;
    autocross_parameters[RAMP_TIME_AUTOCROSS]       = DEF_RAMP_TIME_AUTOCROSS;
    autocross_parameters[RPM_LIMIT_1_2_AUTOCROSS]   = DEF_RPM_LIMIT_1_2_AUTOCROSS;
    autocross_parameters[RPM_LIMIT_2_3_AUTOCROSS]   = DEF_RPM_LIMIT_2_3_AUTOCROSS;
    autocross_parameters[RPM_LIMIT_3_4_AUTOCROSS]   = DEF_RPM_LIMIT_3_4_AUTOCROSS;
    autocross_parameters[SPEED_LIMIT_1_2_AUTOCROSS] = DEF_SPEED_LIMIT_1_2_AUTOCROSS;
    autocross_parameters[SPEED_LIMIT_2_3_AUTOCROSS] = DEF_SPEED_LIMIT_2_3_AUTOCROSS;
    autocross_parameters[SPEED_LIMIT_3_4_AUTOCROSS] = DEF_SPEED_LIMIT_3_4_AUTOCROSS;
#endif
}

void autocross_updateParam(const autocross_params id, const int value){
    if(id < AUTOCROSS_NUM_PARAMS)
        autocross_parameters[id] = value;
}

void autocross_stop(void){
    if(autocross_currentState != OFF_AUTOCROSS)
    {
        autocross_currentState = STOPPING_AUTOCROSS;
        autocrossFb = 0;
        sendUpdatesSW(AUTOX_CODE);
    }
}

void autocross_updateExternValue(const autocross_values id, const int value){
    if(id < AUTOCROSS_NUM_VALUES)
        autocross_externValues[id] = value;
}

int autocross_getParam(const autocross_params id){
    if(id < AUTOCROSS_NUM_PARAMS)
        return autocross_parameters[id];
    return -1;
}

int autocross_getExternValue(const autocross_params id){
    if(id < AUTOCROSS_NUM_VALUES)
        return autocross_externValues[id];
    return -1;
}