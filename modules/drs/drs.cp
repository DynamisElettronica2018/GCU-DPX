#line 1 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/modules/drs/drs.c"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/drs/drs.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/drs/drsmotor.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/basic.h"
#line 16 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/dspic.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/basic.h"
#line 187 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/dspic.h"
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
#line 16 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/drs/drsmotor.h"
void DrsMotor_init(void);

void DrsMotorDX_setupPWM(void);

void DrsMotorSX_setupPWM(void);

void DrsMotor_setPositionDX(unsigned char percentage);

void DrsMotor_setPositionSX(unsigned char percentage);
#line 16 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/drs/drs.h"
extern unsigned int drsFb;

void Drs_initVoltReg(void);

void Drs_turnOnVoltReg(void);

void Drs_turnOffVoltReg(void);

void Drs_open(void);

void Drs_close(void);

void Drs_setDX(unsigned char percentage);

void Drs_setSX(unsigned char percentage);

unsigned char Drs_getDX(void);

unsigned char Drs_getSX(void);

unsigned char Drs_get(void);
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/sw.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/can.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/input-output/d_signalled.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/basic.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/dspic.h"
#line 22 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/d_can.h"
#line 60 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/can.h"
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
#line 3 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/sw.h"
void sendUpdatesSW(unsigned int valCode);
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/input-output/buzzer.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/basic.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/dspic.h"
#line 17 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
#line 9 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/modules/drs/drs.c"
unsigned int drs_currentValue = 0;
unsigned int timer1_drsCounter = 0;
unsigned char drs_currentValueSX = 0;
unsigned char drs_currentValueDX = 0;
unsigned int drsFb = 0;

void Drs_initVoltReg(void)
{
 TRISGbits.TRISG12 = 0;
 LATGbits.LATG12 = 0;
}

void Drs_turnOnVoltReg(void)
{
 LATGbits.LATG12 = 1;
}

void Drs_turnOffVoltReg(void)
{
 LATGbits.LATG12 = 0;
}

void Drs_open(void)
{
 Drs_turnOnVoltReg();
 Drs_setDX( 100 );
 Drs_setSX( 0 );
 drs_currentValue = 1;

 drsFb = (unsigned int)drs_currentValue;
 sendUpdatesSW( 4 );

}

void Drs_close(void)
{
 Drs_setDX( 0 );
 Drs_setSX( 100 );
 timer1_drsCounter = 0;
 drs_currentValue = 0;

 drsFb = (unsigned int)drs_currentValue;
 sendUpdatesSW( 4 );

}

void Drs_setDX(unsigned char percentageDX) {
 unsigned char actualPercentageDX = 0;
 if (percentageDX > 100) {
 actualPercentageDX = 100;
 } else {
 actualPercentageDX = percentageDX;
 }
 DrsMotor_setPositionDX(100 - actualPercentageDX);
 drs_currentValueDX = actualPercentageDX;
}

void Drs_setSX(unsigned char percentageSX) {
 unsigned char actualPercentageSX = 0;
 if (percentageSX > 100) {
 actualPercentageSX = 100;
 } else {
 actualPercentageSX = percentageSX;
 }
 DrsMotor_setPositionSX(100 - actualPercentageSX);
 drs_currentValueSX = actualPercentageSX;
}

unsigned char Drs_getDX(void)
{
 return drs_currentValueDX;
}

unsigned char Drs_getSX(void)
{
 return drs_currentValueSX;
}

unsigned char Drs_get(void)
{
 unsigned char currentValueDX, currentvalueSX;
 currentValueSX = Drs_getSX();
 currentValueDX = Drs_getDX();
 if (currentValueSX >  50 
 && currentValueDX <  50  )
 {
 return 1;

 }
 else if (currentValueSX <  50 
 && currentValueDX >  50  )
 {
 return 0;

 }
}
