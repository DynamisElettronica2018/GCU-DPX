/*
 * Software GCU DPX
*/

#include "dspic.h"
#include "d_signalled.h"
#include "eeprom.h"
#include "gearmotor.h"
#include "clutchmotor.h"
#include "efi.h"
#include "buzzer.h"
#include "clutch.h"
#include "enginecontrol.h"
#include "gearshift.h"
#include "stoplight.h"
#include "drsmotor.h"
#include "drs.h"
//*/

int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0, timer1_counter3 = 0, timer1_counter4 = 0;
char bello = 0;
char isSteeringWheelAvailable;
unsigned int gearShift_timings[RIO_NUM_TIMES]; //30 tanto perch� su gcu c'� spazio e cos� possiamo fare fino a 30 step di cambiata, molto powa
extern unsigned int gearShift_currentGear;
extern char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;

#ifdef DRS_H
  extern unsigned int drs_currentState;
  extern unsigned int drsFb = 0;
#endif

void GCU_isAlive(void) {
    Can_resetWritePacket();
    Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
    Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_write(GCU_CLUTCH_FB_SW_ID);

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
    DRSMotor_init();
    //Generic 1ms timer
    setTimer(TIMER1_DEVICE, 0.001);
    setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
}

void main() {
    init();
    Buzzer_Bip();
    //ShiftTimings_load();
    while (1) 
    {
      //dSignalLed_switch(DSIGNAL_LED_RG14);
      //Delay_ms(1000);
      bello += 1;
      //dSignalLed_switch(DSIGNAL_LED_RG14);
    }
}

//Generic 1ms timer
onTimer1Interrupt{
    clearTimer1();
    GearShift_msTick();
    //Sensors_tick();
    timer1_counter0 += 1;
    timer1_counter1 += 1;
    timer1_counter2 += 1;
    timer1_counter3 += 1;
    timer1_counter4 += 1;
    //STUFF FOR REPEATED SHIFT

    //*/

    if (timer1_counter0 > 25) {
        if (!EngineControl_isStarting()) {
            EngineControl_stop();
            //Buzzer_Bip();
        }
        timer1_counter0 = 0;
    }
    if (timer1_counter1 >= 20) {
        GCU_isAlive();
        timer1_counter1 = 0;
    }

//    if (timer1_counter2 >= 166) {
    if (timer1_counter2 >= 1000) {
        dSignalLed_switch(DSIGNAL_LED_RG14);
        
        timer1_counter2 = 0;
      }
    if (timer1_counter3 >= 10) {
        timer1_counter3 = 0;
    }


}

onCanInterrupt{
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

   //dSignalLed_switch(DSIGNAL_LED_RG12);              //switch led state on CAN receive
    switch (id) {
        case EFI_GEAR_RPM_TPS_APPS_ID:
            GearShift_setCurrentGear(firstInt);
            break;

        case SW_FIRE_GCU_ID:

            EngineControl_resetStartCheck();           //resetCheckCounter = 0
            EngineControl_start();                     //debug on LED D2 board
            //Buzzer_Bip();
            break;

        case SW_GEARSHIFT_ID:
          GearShift_injectCommand(firstInt);
          break;


        case SW_CLUTCH_TARGET_GCU_ID:

            if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
              //Buzzer_Bip();
              Clutch_setBiased(dataBuffer[0]);
              //Clutch_set(dataBuffer[0]);
            }
            break;

        case EFI_HALL_ID:
              //salvare dati in variabili globali
              break;

        case SW_DRS_GCU_ID:
            #ifdef DRS_H
                if(firstInt == 1)
                {
                    Drs_open();
                    Buzzer_Bip();
                }
                else if(firstInt == 0)
                {
                    Drs_close();
                    Buzzer_Bip();
                }
            #endif

        default:
            break;
    }
}