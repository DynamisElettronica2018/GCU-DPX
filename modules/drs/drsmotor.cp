#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/drs/drsmotor.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs/drsmotor.h"
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
#line 16 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/drs/drsmotor.h"
void DrsMotor_init(void);

void DrsMotorDX_setupPWM(void);

void DrsMotorSX_setupPWM(void);

void DrsMotor_setPositionDX(unsigned char percentage);

void DrsMotor_setPositionSX(unsigned char percentage);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 8 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/drs/drsmotor.c"
unsigned int DRSMOTOR_PWM_PERIOD_VALUE;
double DRSMOTOR_PERCENTAGE_STEP;
unsigned int DRSMOTOR_PWM_MAX_VALUE;
unsigned int DRSMOTOR_PWM_MIN_VALUE;

 void timer3_interrupt() iv IVT_ADDR_T3INTERRUPT ics ICS_AUTO {
  IFS0bits.T3IF  = 0 ;
}

void DrsMotor_init(void) {

 DrsMotorDX_setupPWM();
 DrsMotorSX_setupPWM();
}

void DrsMotorDX_setupPWM(void) {
 OC1CON = 0x6;
 DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod( 0.020 ,  T2CONbits.TCKPS );

 DRSMOTOR_PWM_MAX_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
 ( 11  / 100.0));
 DRSMOTOR_PWM_MIN_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
 ( 5  / 100.0));
 DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
 OC1R = DRSMOTOR_PWM_MIN_VALUE;

}

void DrsMotorSX_setupPWM(void) {
 OC2CON = 0x6;
 DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod( 0.020 ,  T2CONbits.TCKPS );

 DRSMOTOR_PWM_MAX_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
 ( 11  / 100.0));
 DRSMOTOR_PWM_MIN_VALUE = (unsigned int) (DRSMOTOR_PWM_PERIOD_VALUE *
 ( 5  / 100.0));
 DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
 OC2R = DRSMOTOR_PWM_MIN_VALUE;

}

void DrsMotor_setPositionDX(unsigned char percentage) {
 unsigned int pwmValue;
 pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
 if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
 pwmValue = DRSMOTOR_PWM_MAX_VALUE;
 } else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
 pwmValue = DRSMOTOR_PWM_MIN_VALUE;
 }
 OC1RS = pwmValue;
}

void DrsMotor_setPositionSX(unsigned char percentage) {
 unsigned int pwmValue;
 pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
 if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
 pwmValue = DRSMOTOR_PWM_MAX_VALUE;
 } else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
 pwmValue = DRSMOTOR_PWM_MIN_VALUE;
 }
 OC2RS = pwmValue;
}
