#line 1 "C:/Users/sofia/Desktop/GIT REPO/GCU-DPX/modules/input-output/sensors_2.c"
#line 1 "c:/users/sofia/desktop/git repo/gcu-dpx/modules/input-output/sensors_2.h"
#line 1 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/can.h"
#line 1 "c:/users/sofia/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
#line 1 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/basic.h"
#line 16 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
#line 1 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 1 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/basic.h"
#line 177 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/dspic.h"
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
#line 22 "c:/users/sofia/desktop/git repo/gcu-dpx/modules/input-output/d_signalled.h"
void dSignalLed_init(void);

void dSignalLed_switch(unsigned char led);

void dSignalLed_set(unsigned char led);

void dSignalLed_unset(unsigned char led);
#line 1 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/d_can.h"
#line 60 "c:/users/sofia/desktop/git repo/gcu-dpx/libs/can.h"
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
#line 8 "C:/Users/sofia/Desktop/GIT REPO/GCU-DPX/modules/input-output/sensors_2.c"
unsigned int getTempSensor()
{
 unsigned int analogValue = 0;
 unsigned int voltTempSensor = 0;
 unsigned int tempSensor = 0;
 analogValue = ADC1_Read(10);
 voltTempSensor = ((float)(analogValue * 5)/4095.0)*1000.0;
 tempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
 return tempSensor;
}

void sendTempSensor(void)
{
 unsigned int temp = 0;
 temp = getTempSensor();
 Can_resetWritePacket();
 Can_addIntToWritePacket(temp);
 Can_write( 0b01100010110 );
}
