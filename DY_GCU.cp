#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/DY_GCU.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 22 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/eeprom.h"







void EEPROM_writeInt(unsigned int address, unsigned int value);

unsigned int EEPROM_readInt(unsigned int address);

void EEPROM_writeArray(unsigned int address, unsigned int *values);

void EEPROM_readArray(unsigned int address, unsigned int *values);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/gearmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 26 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/gearmotor.h"
void GearMotor_init(void);

void GearMotor_turnLeft(void);

void GearMotor_turnRight(void);

void GearMotor_brake(void);

void GearMotor_release(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/clutchmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/clutchmotor.h"
void ClutchMotor_init(void);

void ClutchMotor_setupPWM(void);

void ClutchMotor_setPosition(unsigned char percentage);
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/clutchmotor.h"
#line 14 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
void Clutch_insert(void);

void Clutch_release(void);

void Clutch_set(unsigned char percentage);

unsigned char Clutch_get(void);

void Clutch_setBiased(unsigned char value);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/enginecontrol.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
#line 25 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/enginecontrol.h"
void EngineControl_init(void);

void EngineControl_keyOn(void);

void EngineControl_keyOff(void);

void EngineControl_start(void);

void EngineControl_stop(void);

void EngineControl_resetStartCheck(void);

char EngineControl_isStarting(void);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gearshift.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/gearmotor.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/efi.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/d_can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gcu_rio.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/stoplight.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 17 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/stoplight.h"
void StopLight_init(void);

void StopLight_setupPWM(void);

void StopLight_setBrightness(unsigned char percentage);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/aac/aac.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/aac/aac_defaults.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/clutch.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/gearshift.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/efi.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 3 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
void sendUpdatesSW(int valCode);
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/can.h"
#line 3 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/sw.h"
void sendUpdatesSW(int valCode);
#line 22 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/DY_GCU.c"
int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0, timer1_counter3 = 0, timer1_counter4 = 0;
char bello = 0;
char isSteeringWheelAvailable;









 extern unsigned int accelerationFb;
 extern aac_states aac_currentState;
 extern int aac_externValues[ 3 ];
 extern int aac_parameters[ 11  ];

 extern int aac_timesCounter;
 int timer1_aac_counter = 0;


short unsigned int clutchPulled = 0;
unsigned int gearShift_timings[ TIMES_LAST ];
extern unsigned int gearShift_currentGear;
extern char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;

void GCU_isAlive(void) {
 Can_resetWritePacket();
 Can_addIntToWritePacket((unsigned int) 99 );
 Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
 Can_addIntToWritePacket(0);
 Can_addIntToWritePacket(0);
 Can_write( 0b01100010000 );
}

void init(void) {
 EngineControl_init();
 dSignalLed_init();
 Can_init();
 GearMotor_init();
 ClutchMotor_init();
 Efi_init();
 GearShift_init();
 StopLight_init();
 Buzzer_init();

 setTimer( 1 , 0.001);
 setInterruptPriority( 1 ,  4 );


 aac_init();


 setTimer( 1 , 0.001);
 setInterruptPriority( 1 ,  4 );

}


void main() {
 init();
 Buzzer_Bip();

 while (1)
 {


 bello += 1;

 }
}


 void timer1_interrupt() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
  IFS0bits.T1IF  = 0 ;
 GearShift_msTick();
 timer1_counter0 += 1;
 timer1_counter1 += 1;
 timer1_counter2 += 1;
 timer1_counter3 += 1;
 timer1_counter4 += 1;




 if (timer1_counter0 > 25) {
 if (!EngineControl_isStarting()) {
 EngineControl_stop();

 }
 timer1_counter0 = 0;
 }
 if (timer1_counter1 >= 20) {
 GCU_isAlive();
 timer1_counter1 = 0;
 }


 if (timer1_counter2 >= 1000) {
 dSignalLed_switch( 0 );


 timer1_counter2 = 0;
 }
 if (timer1_counter3 >= 10) {
 timer1_counter3 = 0;
 }


 timer1_aac_counter += 1;
 if(timer1_aac_counter ==  25 )
 {
 aac_execute();
 timer1_aac_counter = 0;
 }

}

 void CAN_Interrupt() iv IVT_ADDR_C1INTERRUPT {
 unsigned int intCommand, firstInt, secondInt, thirdInt, fourthInt;
 unsigned long int id;
 char dataBuffer[8];
 unsigned int dataLen, flags;
 Can_read(&id, dataBuffer, &dataLen, &flags);
 Can_clearInterrupt();

 if (dataLen >= 2) {
 firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
 }
 if (dataLen >= 4) {
 secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
 }
 if (dataLen >= 6) {
 thirdInt = (unsigned int) ((dataBuffer[4] << 8) | (dataBuffer[5] & 0xFF));
 }
 if (dataLen >= 8) {
 fourthInt = (unsigned int) ((dataBuffer[6] << 8) | (dataBuffer[7] & 0xFF));
 }

 switch (id) {
 case  0b01100000101 :
 GearShift_setCurrentGear(firstInt);

 aac_updateExternValue(RPM, secondInt);

 break;

 case  0b01000000100 :
 EngineControl_resetStartCheck();
 EngineControl_start();
 break;

 case  0b01000000000 :
 GearShift_injectCommand(firstInt);
 break;


 if (Clutch_get() != 100
 &&(firstInt ==  100 
 || firstInt ==  50 
 || firstInt ==  200 )
 && accelerationFb > 0)
 aac_stop();

 GearShift_injectCommand(firstInt);
 break;

 case  0b01100000110 :

 aac_updateExternValue(WHEEL_SPEED, firstInt / 10);

 break;

 case  0b01000000001 :

 if(dataBuffer[0] >  30  && accelerationFb > 0)
 {
 if (accelerationFb > 0)
 {
 aac_stop();
 }

 if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
 {

 Clutch_setBiased(dataBuffer[0]);

 clutchPulled = 1;
 }

 }

 if (clutchPulled == 0 && accelerationFb == 0)
 {
 Clutch_setBiased(dataBuffer[0]);
 }
 clutchPulled = 0;

 break;

 case  0b01100000100 :

 break;

 case  0b01000000010 :


 if(aac_currentState == OFF && firstInt == 1)


 {
 aac_currentState = START;

 }
 else if(aac_currentState == READY && firstInt == 2)
 {
 aac_currentState = START_RELEASE;

 }

 else if (firstInt == 0)
 {
 if (accelerationFb > 0)
 {
 aac_stop();
 Clutch_release();
 }

 }

 break;
 default:
 break;
 }
}
