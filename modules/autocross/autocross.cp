#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/autocross/autocross.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/autocross/autocross.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/autocross/autocross_defaults.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/clutchmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 177 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
void setAllPinAsDigital(void);

void setInterruptPriority(unsigned char device, unsigned char priority);

void setExternalInterrupt(unsigned char device, char edge);

void switchExternalInterruptEdge(unsigned char);

char getExternalInterruptEdge(unsigned char);

void clearExternalInterrupt(unsigned char);

void setTimer(unsigned char device, double timePeriod);

void clearTimer(unsigned char device);

void turnOnTimer(unsigned char device);

void turnOffTimer(unsigned char device);

unsigned int getTimerPeriod(double timePeriod, unsigned char prescalerIndex);

unsigned char getTimerPrescaler(double timePeriod);

double getExactTimerPrescaler(double timePeriod);

void setupAnalogSampling(void);

void turnOnAnalogModule();

void turnOffAnalogModule();

void startSampling(void);

unsigned int getAnalogValue(void);

void setAnalogPIN(unsigned char pin);

void unsetAnalogPIN(unsigned char pin);

void setAnalogInterrupt(void);

void unsetAnalogInterrupt(void);

void clearAnalogInterrupt(void);


void setAutomaticSampling(void);

void unsetAutomaticSampling(void);


void setAnalogVoltageReference(unsigned char mode);

void setAnalogDataOutputFormat(unsigned char adof);

int getMinimumAnalogClockConversion(void);
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/clutchmotor.h"
void ClutchMotor_init(void);

void ClutchMotor_setupPWM(void);

void ClutchMotor_setPosition(unsigned char percentage);
#line 14 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
void Clutch_insert(void);

void Clutch_release(void);

void Clutch_set(unsigned char percentage);

unsigned char Clutch_get(void);

void Clutch_setBiased(unsigned char value);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gearshift.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/gearmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 26 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/gearmotor.h"
void GearMotor_init(void);

void GearMotor_turnLeft(void);

void GearMotor_turnRight(void);

void GearMotor_brake(void);

void GearMotor_release(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/efi.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 23 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/efi.h"
void Efi_init(void);

void Efi_setCut(void);

void Efi_unsetCut(void);

void Efi_setBlip(void);

void Efi_unsetBlip(void);

void Efi_setRPMLimiter(void);

void Efi_unsetRPMLimiter(void);

void Efi_setRPMLimiter_CAN(unsigned int limit);

void Efi_unsetRPMLimiter_CAN(unsigned int limit);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 17 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/d_can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gcu_rio.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 22 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/d_can.h"
#line 60 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
void Can_init(void);

void Can_read(unsigned long int *id, char dataBuffer[], unsigned int *dataLength, unsigned int *inFlags);

void Can_writeByte(unsigned long int id, unsigned char dataOut);

void Can_writeInt(unsigned long int id, int dataOut);

void Can_addIntToWritePacket(int dataOut);

void Can_addByteToWritePacket(unsigned char dataOut);

unsigned int Can_write(unsigned long int id);

void Can_setWritePriority(unsigned int txPriority);

void Can_resetWritePacket(void);

unsigned int Can_getWriteFlags(void);

unsigned char Can_B0hasBeenReceived(void);

unsigned char Can_B1hasBeenReceived(void);

void Can_clearB0Flag(void);

void Can_clearB1Flag(void);

void Can_clearInterrupt(void);

void Can_initInterrupt(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
#line 41 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gcu_rio.h"
typedef enum {

 NT_PUSH_1_N,
 NT_CLUTCH_1_N,
 NT_REBOUND_1_N,
 NT_BRAKE_1_N,

 NT_PUSH_2_N,
 NT_CLUTCH_2_N,
 NT_REBOUND_2_N,
 NT_BRAKE_2_N,

 DN_PUSH,
 CLUTCH,
 DN_REBOUND,
 DN_BRAKE,

 UP_PUSH_1_2,
 UP_PUSH_2_3,
 UP_PUSH_3_4,
 UP_PUSH_4_5,

 DELAY,
 UP_REBOUND,
 UP_BRAKE,

 NT_CLUTCH_DELAY,


 DOWN_TIME_CHECK,
 UP_TIME_CHECK,
 MAX_TRIES,


 TIMES_LAST
 }time_id;

 typedef enum{

 H2O_DC,
 TH2O_ENGINE,
 TH2O_IN,
 TH2O_OUT,

 POIL,
 TOIL_IN,
 TOIL_OUT,
 BATTERY,

 P_FUEL,
 FAN,
 INJ1,
 INJ2,

 DATA_LAST
 }efi_dataIds;




extern unsigned int gearShift_timings[ TIMES_LAST ];

void rio_init(void);

extern void rio_sendOneTime(time_id pos);

extern void rio_sendAllTimes(void);

extern void rio_sendTimes(void);

extern void rio_send(void);
#line 17 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gearshift.h"
typedef enum {
 STEP_UP_START,

 STEP_UP_PUSH,
 STEP_UP_REBOUND,
 STEP_UP_BRAKE,
 STEP_DOWN_START,

 STEP_DOWN_PUSH,
 STEP_DOWN_REBOUND,
 STEP_DOWN_BRAKE,
 STEP_UP_END,
 STEP_DOWN_END
 }shiftStep;
#line 71 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gearshift.h"
extern unsigned int gearShift_timings[ TIMES_LAST ];


void GearShift_init(void);

void GearShift_injectCommand(unsigned int command);

void GearShift_shift(unsigned int command);

void GearShift_setNeutral(unsigned int command);

void GearShift_setCurrentGear(unsigned int gear);

void GearShift_up(void);

void GearShift_down(void);

char GearShift_isShifting(void);

void GearShift_setNextStep_A(unsigned char step);

void GearShift_nextStep_A(void);

void GearShift_setNextStep_B(unsigned char step);

void GearShift_nextStep_B(void);

void GearShift_setMsTicks_A(unsigned int ticks);

void GearShift_setMsTicks_B(unsigned int ticks);

void GearShift_msTick(void);

void GearShift_loadDefaultTimings(void);

void GearShift_loadNeutralTimings(void);

int Gearshift_get_time(shiftStep step);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/efi.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 3 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
void sendUpdatesSW(unsigned int valCode);
#line 26 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/autocross/autocross.h"
extern unsigned int autocrossFb;



typedef enum{
 OFF_AUTOCROSS,
 START_AUTOCROSS,
 READY_AUTOCROSS,
 START_RELEASE_AUTOCROSS,
 RELEASING_AUTOCROSS,
 RUNNING_AUTOCROSS,
 STOPPING_AUTOCROSS
}autocross_states;


typedef enum{
 RAMP_START_AUTOCROSS,
 RAMP_END_AUTOCROSS,
 RAMP_TIME_AUTOCROSS,

 RPM_LIMIT_1_2_AUTOCROSS,
 RPM_LIMIT_2_3_AUTOCROSS,
 RPM_LIMIT_3_4_AUTOCROSS,
 RPM_LIMIT_4_5_AUTOCROSS,
 SPEED_LIMIT_1_2_AUTOCROSS,
 SPEED_LIMIT_2_3_AUTOCROSS,
 SPEED_LIMIT_3_4_AUTOCROSS,
 SPEED_LIMIT_4_5_AUTOCROSS
}autocross_params;




typedef enum{
 RPM_AUTOCROSS,
 WHEEL_SPEED_AUTOCROSS,
 APPS_AUTOCROSS
}autocross_values;

extern unsigned int gearShift_currentGear;

void autocross_init(void);


void autocross_execute(void);


void autocross_checkAndPrepare(void);

void autocross_stop(void);

void autocross_loadDefaultParams(void);

void autocross_updateParam(const autocross_params id, const int value);

void autocross_updateExternValue(const autocross_values id, const int value);

int autocross_getParam(const autocross_params id);

int autocross_getExternValue(const autocross_values id);

void autocross_forceState(const autocross_states newState);
#line 3 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/autocross/autocross.c"
autocross_states autocross_currentState;
int autocross_parameters[ 9 ];
int autocross_externValues[ 3 ];
int autocross_dtRelease;
char autocross_sendingAll =  0 ;
int autocross_timesCounter;
unsigned int autocrossFb = 0;
#line 16 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/autocross/autocross.c"
float autocross_clutchStep;
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

 autocross_currentState = READY_AUTOCROSS;
 autocross_clutchValue = 100;
 Clutch_set((unsigned int)autocross_clutchValue);
 autocrossFb = 1;
 sendUpdatesSW( 2 );
 return;
 case READY_AUTOCROSS:
 Clutch_set(100);
 return;
 case START_RELEASE_AUTOCROSS:
 autocrossFb = 2;
 autocross_clutchValue = autocross_parameters[RAMP_START_AUTOCROSS];
 Clutch_set(autocross_clutchValue);
 autocross_dtRelease = autocross_parameters[RAMP_TIME_AUTOCROSS] /  25 ;
 autocross_clutchStep = ((float)(autocross_parameters[RAMP_START_AUTOCROSS] - autocross_parameters[RAMP_END_AUTOCROSS]) *  25 ) / (float)autocross_parameters[RAMP_TIME_AUTOCROSS];
 autocross_currentState = RELEASING_AUTOCROSS;
 autocrossFb = 2;
 sendUpdatesSW( 2 );
 return;
 case RELEASING_AUTOCROSS:

 autocross_clutchValue = autocross_clutchValue - autocross_clutchStep;
 Clutch_set((unsigned char)autocross_clutchValue);
 autocross_dtRelease--;
 if(autocross_dtRelease <= 0 || Clutch_get() <= autocross_parameters[RAMP_END_AUTOCROSS]){
 Clutch_set(0);
 Efi_unsetRPMLimiter();
 autocross_currentState = RUNNING_AUTOCROSS;


 }
 Buzzer_bip();
 return;
 case RUNNING_AUTOCROSS:

 if(gearShift_currentGear == 2){
 autocross_stop();
 return;
 }

 if(autocross_externValues[RPM_AUTOCROSS] >= autocross_parameters[RPM_LIMIT_1_2_AUTOCROSS + gearShift_currentGear - 1]
 && autocross_externValues[WHEEL_SPEED_AUTOCROSS] >= autocross_parameters[SPEED_LIMIT_1_2_AUTOCROSS + gearShift_currentGear - 1]){
 GearShift_up();
 }
 return;
 case STOPPING_AUTOCROSS:
 autocross_currentState = OFF_AUTOCROSS;
 return;

 default: return;
 }
}


void autocross_loadDefaultParams(void){


 autocross_parameters[RAMP_START_AUTOCROSS] =  70 ;
 autocross_parameters[RAMP_END_AUTOCROSS] =  0 ;
 autocross_parameters[RAMP_TIME_AUTOCROSS] =  250 ;
 autocross_parameters[RPM_LIMIT_1_2_AUTOCROSS] =  11300 ;
 autocross_parameters[RPM_LIMIT_2_3_AUTOCROSS] =  11300 ;
 autocross_parameters[RPM_LIMIT_3_4_AUTOCROSS] =  11300 ;
 autocross_parameters[SPEED_LIMIT_1_2_AUTOCROSS] =  47 ;
 autocross_parameters[SPEED_LIMIT_2_3_AUTOCROSS] =  65 ;
 autocross_parameters[SPEED_LIMIT_3_4_AUTOCROSS] =  80 ;

}

void autocross_updateParam(const autocross_params id, const int value){
 if(id <  9 )
 autocross_parameters[id] = value;
}

void autocross_stop(void){
 if(autocross_currentState != OFF_AUTOCROSS)
 {
 autocross_currentState = STOPPING_AUTOCROSS;
 autocrossFb = 0;
 sendUpdatesSW( 2 );
 }
}

void autocross_updateExternValue(const autocross_values id, const int value){
 if(id <  3 )
 autocross_externValues[id] = value;
}

int autocross_getParam(const autocross_params id){
 if(id <  9 )
 return autocross_parameters[id];
 return -1;
}

int autocross_getExternValue(const autocross_params id){
 if(id <  3 )
 return autocross_externValues[id];
 return -1;
}
