#line 1 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/traction/traction.c"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/traction/traction.h"
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
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/basic.h"
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/libs/dspic.h"
#line 17 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/input-output/buzzer.h"
void Buzzer_init(void);

void Buzzer_tick(void);

void Buzzer_Bip(void);
#line 15 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/traction/traction.h"
extern unsigned int tractionFb;
extern unsigned int tractionVariable[11];

void initTraction(void);

Efi_setTraction(unsigned int setState);
#line 1 "c:/users/salvatore/desktop/git repo/gcu-dpx/modules/traction/traction_settings.h"
#line 6 "C:/Users/Salvatore/Desktop/git Repo/GCU-DPX/modules/traction/traction.c"
unsigned int tractionFb = 0;
unsigned int tractionVariable[11];

void initTraction(void)
{
 int i = 0;
 tractionVariable[i] =  0 ;
 i++;
 tractionVariable[i] =  0 ;
 for (; i <=  8 ; i++)
 {
 tractionVariable[i] =  0  +  100 ;
 }

}

Efi_setTraction(unsigned int setState)
{
 Can_resetWritePacket();
 Can_addIntToWritePacket(setState);
 Can_addIntToWritePacket(0);
 Can_addIntToWritePacket(0);
 Can_addIntToWritePacket(0);
 Can_write( 0b10100000000 );

}
