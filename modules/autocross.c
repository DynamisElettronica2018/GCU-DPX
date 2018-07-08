#include "autocross.h"

unsigned int autocrossFb = 0;

autocross_states autocross_currentState;
int autocross_parameters[AUTOCROSS_NUM_PARAMS];
int autocross_externValues[AUTOCROSS_NUM_VALUES];
int autocross_dtRelease;      //counter for clutch "slow" release
char autocross_sendingAll = FALSE;
int autocross_timesCounter;

/*
int autocross_shiftTry = 0;
int autocross_shiftCounter = 0;
int autocross_targetGear = -1;
//*/
float autocross_clutchStep;   //step for each "frame" of autocross
float autocross_clutchValue;

void autocross_init(void){
    autocross_currentState = OFF;
    autocross_loadDefaultParams();
}

void autocross_execute(void){
    switch (autocross_currentState) {
        case START:
            Efi_setRPMLimiter();
//            Activate Launch Control
            Can_writeByte(SW_AUX_ID, MEX_READY);
            autocross_currentState = READY;
            autocross_clutchValue = 100;
            Clutch_set((unsigned int)autocross_clutchValue);
            return;
        case READY:
            Clutch_set(100);
            return;
        case START_RELEASE:
            autocross_clutchValue = autocross_parameters[RAMP_START];
            Clutch_set(autocross_clutchValue);
            autocross_dtRelease = autocross_parameters[RAMP_TIME] / AUTOCROSS_WORK_RATE_ms;
            autocross_clutchStep = ((float)(autocross_parameters[RAMP_START] - autocross_parameters[RAMP_END]) * AUTOCROSS_WORK_RATE_ms) / (float)autocross_parameters[RAMP_TIME];
            autocross_currentState = RELEASING;
            return;
        case RELEASING:
//             Clutch_set(autocross_parameters[RAMP_END] + (autocross_clutchStep * autocross_dtRelease));        //Works iff the cluth paddle is disabled
            autocross_clutchValue = autocross_clutchValue - autocross_clutchStep;
            Clutch_set((unsigned char)autocross_clutchValue);
            autocross_dtRelease--;
            if(autocross_dtRelease <= 0 || Clutch_get() <= autocross_parameters[RAMP_END]){
                Clutch_set(0);
                Efi_unsetRPMLimiter();
                autocross_currentState = RUNNING;                 //For gearshift  Use alternatively to autocross_stop
//UNCOMMENT FOR CLUTCH ONLY
               // autocross_stop();                               //For not gearshift (clutch only)
            }
            Buzzer_bip();
            return;
        case RUNNING:
        //Check condizioni e cambio
            if(gearShift_currentGear == 2){         //autocross finisce dopo aver inserito la seconda marcia in automatico
                autocross_stop();
                return;
            }
        //parameters for gear is taken using as a index the baseline (RPM_LIMIT_1_2) + (gear - 1)
            if(autocross_externValues[RPM] >= autocross_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
              && autocross_externValues[WHEEL_SPEED] >= autocross_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
                GearShift_up();
            }
            return;
        case STOPPING:
            autocross_currentState = OFF;
            Can_writeByte(SW_AUX_ID, MEX_OFF);
            return;
        //gearshift check
        default: return;
    }
}

void autocross_sendOneTime(time_id pos){
    autocross_timesCounter = pos;
}

void autocross_sendTimes(void)
{
    if(autocross_timesCounter >= 0){
        Can_resetWritePacket();
        Can_addIntToWritePacket(CODE_SET_AUTOCROSS);
        Can_addIntToWritePacket(autocross_timesCounter);
        Can_addIntToWritePacket(autocross_parameters[autocross_timesCounter]);
        if(Can_write(GCU_GEAR_TIMING_TELEMETRY_ID) < 0)
            Buzzer_Bip();
        autocross_timesCounter -= 1;
        if(!autocross_sendingAll || autocross_timesCounter < 0){
            autocross_sendingAll = FALSE;
            autocross_timesCounter = -1;
        }
    }
}

void autocross_sendAllTimes(void)
{
    if(!autocross_sendingAll){
        autocross_timesCounter = AUTOCROSS_NUM_PARAMS;
        autocross_sendingAll = TRUE;
    }
}

void autocross_loadDefaultParams(void){
//Use defaults only if eeprom unavailable
#ifndef AUTOCROSS_EEPROM_H
    autocross_parameters[RAMP_START]      = DEF_RAMP_START;
    autocross_parameters[RAMP_END]        = DEF_RAMP_END;
    autocross_parameters[RAMP_TIME]       = DEF_RAMP_TIME;
    autocross_parameters[RPM_LIMIT_1_2]   = DEF_RPM_LIMIT_1_2;
    autocross_parameters[RPM_LIMIT_2_3]   = DEF_RPM_LIMIT_2_3;
    autocross_parameters[RPM_LIMIT_3_4]   = DEF_RPM_LIMIT_3_4;
    autocross_parameters[SPEED_LIMIT_1_2] = DEF_SPEED_LIMIT_1_2;
    autocross_parameters[SPEED_LIMIT_2_3] = DEF_SPEED_LIMIT_2_3;
    autocross_parameters[SPEED_LIMIT_3_4] = DEF_SPEED_LIMIT_3_4;
#endif
}

void autocross_updateParam(const autocross_params id, const int value){
    if(id < AUTOCROSS_NUM_PARAMS)
        autocross_parameters[id] = value;
}

void autocross_stop(void){
    if(autocross_currentState != OFF)
        autocross_currentState = STOPPING;
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