#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/sw.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 187 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
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
#line 3 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
void sendUpdatesSW(unsigned int valCode);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 17 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/aac/aac.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/aac/aac_defaults.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/clutchmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/d_can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gcu_rio.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
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






extern unsigned int gearShift_timings[ TIMES_LAST ];
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
#line 28 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/aac/aac.h"
extern unsigned int accelerationFb;

unsigned int getAccelerationFb();

typedef enum{
 OFF,
 START,
 READY,
 START_RELEASE,
 RELEASING,
 RUNNING,
 STOPPING
}aac_states;


typedef enum{
 RAMP_START,
 RAMP_END,
 RAMP_TIME,

 RPM_LIMIT_1_2,
 RPM_LIMIT_2_3,
 RPM_LIMIT_3_4,
 RPM_LIMIT_4_5,
 SPEED_LIMIT_1_2,
 SPEED_LIMIT_2_3,
 SPEED_LIMIT_3_4,
 SPEED_LIMIT_4_5
}aac_params;


typedef enum{
 MEX_ON,
 MEX_READY,
 MEX_GO,
 MEX_OFF,
}aac_notifications;


typedef enum{
 RPM,
 WHEEL_SPEED,
 APPS
}aac_values;

extern unsigned int gearShift_currentGear;

void aac_init(void);


void aac_execute(void);


void aac_checkAndPrepare(void);

void aac_stop(void);

void aac_loadDefaultParams(void);

void aac_updateParam(const aac_params id, const int value);

void aac_updateExternValue(const aac_values id, const int value);

int aac_getParam(const aac_params id);

int aac_getExternValue(const aac_values id);

void aac_forceState(const aac_states newState);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/traction/traction.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gearshift.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/efi.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
#line 20 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/traction/traction.h"
extern unsigned int tractionFb;
extern unsigned int tractionVariable[11];

typedef enum{
 TRACTION_0,
 TRACTION_1,
 TRACTION_2,
 TRACTION_3,
 TRACTION_4,
 TRACTION_5,
 TRACTION_6,
 TRACTION_7
}traction_params;

void traction_init(void);

void tractionLoadDefaultsSettings(void);

setTraction(unsigned int codeValue, unsigned int tractionValue);

Efi_setTraction(unsigned int setState);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs/drs.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs/drsmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs/drsmotor.h"
void DrsMotor_init(void);

void DrsMotorDX_setupPWM(void);

void DrsMotorSX_setupPWM(void);

void DrsMotor_setPositionDX(unsigned char percentage);

void DrsMotor_setPositionSX(unsigned char percentage);
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs/drs.h"
extern unsigned int drsFb;

void Drs_open(void);

void Drs_close(void);

void Drs_setDX(unsigned char percentage);

void Drs_setSX(unsigned char percentage);

unsigned char Drs_getDX(void);

unsigned char Drs_getSX(void);

unsigned char Drs_get(void);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/sw.c"
void sendUpdatesSW(unsigned int valCode)
{
 Can_resetWritePacket();
 switch (valCode)
 {

 case  1 :
 Can_addIntToWritePacket( 1 );
 Can_addIntToWritePacket(accelerationFb);
 break;
#line 25 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/sw.c"
 case  3 :
 Can_addIntToWritePacket( 3 );
 Can_addIntToWritePacket(tractionFb);
 break;


 case  4 :
 Can_addIntToWritePacket( 4 );
 Can_addIntToWritePacket(drsFb);
 break;

 default:
 break;
 }
 Can_addIntToWritePacket(0);
 Can_addIntToWritePacket(0);
 Can_write( 0b01100011001 );
}
