#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/drs.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drsmotor.h"
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
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drsmotor.h"
void DrsMotor_init(void);

void DrsMotorDX_setupPWM(void);

void DrsMotorSX_setupPWM(void);

void DrsMotor_setPositionDX(unsigned char percentage);

void DrsMotor_setPositionSX(unsigned char percentage);
#line 14 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs.h"
extern unsigned int drsFb;

void Drs_open(void);

void Drs_close(void);

void Drs_setDX(unsigned char percentage);

void Drs_setSX(unsigned char percentage);

unsigned char Drs_get(void);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/drs.c"
unsigned char drs_currentValue = 0;
unsigned int drsFb = 0;

void Drs_open(void)
{
 Drs_setDX( 40 );
 Drs_setSX( 60 );
}

void Drs_close(void)
{
 Drs_setDX( 60 );
 Drs_setSX( 40 );
}

void Drs_setDX(unsigned char percentage) {
 unsigned char actualPercentage = 0;
 if (percentage > 100) {
 actualPercentage = 100;
 } else {
 actualPercentage = percentage;
 }
 DrsMotor_setPositionDX(100 - actualPercentage);
 Drs_currentValue = actualPercentage;
}

void Drs_setSX(unsigned char percentage) {
 unsigned char actualPercentage = 0;
 if (percentage > 100) {
 actualPercentage = 100;
 } else {
 actualPercentage = percentage;
 }
 DrsMotor_setPositionSX(100 - actualPercentage);
 Drs_currentValue = actualPercentage;
}

unsigned char Drs_get(void) {
 return Drs_currentValue;
}
