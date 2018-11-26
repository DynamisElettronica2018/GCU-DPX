#line 1 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/modules/input-output/sensors/sensors.c"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/input-output/sensors/sensors.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/can.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/input-output/d_signalled.h"
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
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/dspic.h"
#line 20 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/modules/input-output/sensors/sensors.h"
unsigned int getTempSensor();
unsigned int getDRSSensor();
unsigned int getFuelSensor();
unsigned int getGearSensor();
unsigned int getClutchSensor();
unsigned int getHPumpSensor();
unsigned int getFanSensor();

void sendSensorsDebug1(void);

void sendSensorsDebug2(void);
#line 18 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/modules/input-output/sensors/sensors.c"
unsigned int sensors_fanCurrent = 0,
 sensors_hpumpCurrent = 0,
 sensors_gearCurrent = 0,
 sensors_fuelCurrent = 0,
 sensors_clutchCurrent = 0,
 sensors_drsCurrent = 0,
 sensors_gcuTemp = 0;

unsigned int getTempSensor()
{
 unsigned int analogValue = 0;
 unsigned int voltTempSensor = 0;
 unsigned int convTempSensor = 0;
 analogValue = ADC1_Read( 10 );
 sensors_gcuTemp = sensors_gcuTemp * 0.95 + analogValue * 0.05;
 voltTempSensor = ((float)(sensors_gcuTemp * 5)/4095.0)*1000.0;
 convTempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
 return convTempSensor;
}
unsigned int getDRSSensor()
{
 unsigned int convDrsSensor = 0;
 unsigned int analogValue = 0;
 analogValue = ADC1_Read( 8 );
 sensors_drsCurrent = sensors_drsCurrent * 0.95 + analogValue * 0.05;
 convDrsSensor = (((sensors_drsCurrent * 5.05 / 4095) * 1000) / 0.2);
 return convDrsSensor;
}
unsigned int getFuelSensor()
{
 unsigned int convFuelSensor = 0;
 unsigned int analogValue = 0;
 analogValue = ADC1_Read( 4 );
 sensors_fuelCurrent = sensors_fuelCurrent * 0.95 + analogValue * 0.05;
 convFuelSensor = (((sensors_fuelCurrent * 5.05 / 4095) * 1000) / 0.2);
 return convFuelSensor;
}
unsigned int getGearSensor()
{
 unsigned int convGearSensor = 0;
 unsigned int analogValue = 0;
 analogValue = ADC1_Read( 11 );
 sensors_gearCurrent = sensors_gearCurrent * 0.95 + analogValue * 0.05;
 convGearSensor = sensors_gearCurrent;
 return convGearSensor;
}
unsigned int getClutchSensor()
{
 unsigned int convClutchSensor = 0;
 unsigned int analogValue = 0;
 analogValue = ADC1_Read( 2 );
 sensors_clutchCurrent = sensors_clutchCurrent * 0.95 + analogValue * 0.05;
 convClutchSensor = (((sensors_clutchCurrent * 5.05 / 4095) * 1000) / 0.2);
 return convClutchSensor;
}
unsigned int getHPumpSensor()
{
 unsigned int convHPumpSensor = 0;
 unsigned int analogValue = 0;
 analogValue = ADC1_Read( 5 );
 sensors_hpumpCurrent = sensors_hpumpCurrent * 0.95 + analogValue * 0.05;
 convHPumpSensor = (((sensors_hPumpCurrent * 5.05 / 4095) * 1000) / 0.2);
 return convHPumpSensor;
}
unsigned int getFanSensor()
{
 unsigned int convFanSensor = 0;
 unsigned int analogValue = 0;
 analogValue = ADC1_Read( 3 );
 sensors_fanCurrent = sensors_fanCurrent * 0.95 + analogValue * 0.05;
 convFanSensor = (((sensors_fanCurrent * 5.05 / 4095) * 1000) / 0.2);
 return convFanSensor;
}

void sendSensorsDebug1(void)
{
 unsigned int temp = 0;
 unsigned int drs = 0;
 unsigned int fuel = 0;
 temp = getTempSensor();
 drs = getDRSSensor();
 fuel = getFuelSensor();
 Can_resetWritePacket();
 Can_addIntToWritePacket(temp);
 Can_addIntToWritePacket(drs);
 Can_addIntToWritePacket(fuel);
 Can_addIntToWritePacket(0);
 Can_write( 0b01100010110 );
}

void sendSensorsDebug2(void)
{
 unsigned int gear = 0;
 unsigned int clutch = 0;
 unsigned int hPump = 0;
 unsigned int fan = 0;
 gear = getGearSensor();
 clutch = getClutchSensor();
 hPump = getHPumpSensor();
 fan = getFanSensor();
 Can_resetWritePacket();
 Can_addIntToWritePacket(gear);
 Can_addIntToWritePacket(clutch);
 Can_addIntToWritePacket(hPump);
 Can_addIntToWritePacket(fan);
 Can_write( 0b01100010111 );
}
