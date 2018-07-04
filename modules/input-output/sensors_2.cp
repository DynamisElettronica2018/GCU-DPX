#line 1 "C:/Users/nicol/Desktop/git/GCU-DPX/modules/input-output/sensors_2.c"
#line 8 "C:/Users/nicol/Desktop/git/GCU-DPX/modules/input-output/sensors_2.c"
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
 Can_write(GCU_DEBUG_1_ID);
}
