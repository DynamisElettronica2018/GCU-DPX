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
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drsmotor.h"
void DrsMotor_init(void);

void DrsMotor_setupPWM(void);

void DrsMotor_setPosition(unsigned char percentage);
#line 8 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs.h"
void Drs_insert(void);

void Drs_release(void);

void Drs_set(unsigned char percentage);

unsigned char Drs_get(void);
#line 7 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/drs.c"
unsigned char drs_currentValue = 0;

void Drs_insert(void) {
 Drs_set(100);
}

void Drs_release(void) {
 Drs_set(0);
}

void DRs_set(unsigned char percentage) {
 unsigned char actualPercentage = 0;
 if (percentage > 100) {
 actualPercentage = 100;
 } else {
 actualPercentage = percentage;
 }
 DrsMotor_setPosition(100 - actualPercentage);
 Drs_currentValue = actualPercentage;
}

unsigned char Drs_get(void) {
 return Drs_currentValue;
}
