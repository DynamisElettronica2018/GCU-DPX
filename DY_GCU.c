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
#include "aac.h"                //COMMENT THIS LINE TO DISABLE AAC
#include "traction.h"
#include "drsmotor.h"
#include "drs.h"
#include "sw.h"
//*/

int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0, timer1_counter3 = 0, timer1_counter4 = 0;
char bello = 0;
char isSteeringWheelAvailable;

//TODO///////
//uncommentare il led 14 nel main e commentarlo/rimuoverl in onCanInterrupt





#ifdef AAC_H
  extern unsigned int accelerationFb;
  extern aac_states aac_currentState;
  extern int aac_externValues[AAC_NUM_VALUES];
  extern int aac_parameters[AAC_NUM_PARAMS ];
  //extern bool aac_sendingAll = false;
  extern int aac_timesCounter;
  int timer1_aac_counter = 0;
#endif

short unsigned int clutchPulled = 0;
unsigned int gearShift_timings[RIO_NUM_TIMES]; //30 tanto perch� su gcu c'� spazio e cos� possiamo fare fino a 30 step di cambiata, molto powa
extern unsigned int gearShift_currentGear;
extern char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;


#ifdef TRACTION_H
  extern unsigned int traction_currentState;
  extern int traction_parameters[TRACTION_NUM_PARAM];
#endif 

int x = 0;

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

    #ifdef TRACTION_H
        traction_init();
    #endif
    
    //Generic 1ms timer
    setTimer(TIMER1_DEVICE, 0.001);
    setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
    
  #ifdef AAC_H
    aac_init();
  #endif
  #ifdef DRS_H
    DRSMotor_init();
    Drs_close();
  #endif
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
    if (timer1_counter3 >= 1000) {
       if (x == 0)
       {
          //DrsMotor_setPositionDX(100);
          //DrsMotor_setPositionSX(0);
          //Drs_setSX(0);
          //Drs_open();
          x = 1;
       }
       else if (x == 1)
       {
          //DrsMotor_setPositionDX(0);
          //DrsMotor_setPositionSX(100);
          //Drs_setSX(100);
          //Drs_close();
          x = 0;
       }
        timer1_counter3 = 0;
    }

  #ifdef AAC_H
    timer1_aac_counter += 1;
    if(timer1_aac_counter == AAC_WORK_RATE_ms)
    {
        aac_execute();
        timer1_aac_counter = 0;
    }
  #endif
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

    switch (id) {
        case EFI_GEAR_RPM_TPS_APPS_ID:
            GearShift_setCurrentGear(firstInt);
            #ifdef AAC_H
               aac_updateExternValue(RPM, secondInt);
            #endif
            break;

        case SW_FIRE_GCU_ID:
            EngineControl_resetStartCheck();           //resetCheckCounter = 0
            EngineControl_start();                     //debug on LED D2 board
            break;

        case SW_GEARSHIFT_ID:
          GearShift_injectCommand(firstInt);
          break;

          #ifdef AAC_H
            if (Clutch_get() != 100
                  &&(firstInt == GEAR_COMMAND_NEUTRAL_DOWN
                     || firstInt == GEAR_COMMAND_NEUTRAL_UP
                     || firstInt == GEAR_COMMAND_DOWN)
                  && accelerationFb > 0)
                aac_stop();
          #endif
            GearShift_injectCommand(firstInt);
            break;
            
        case EFI_TRACTION_CONTROL_ID:
          #ifdef AAC_H
            aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
          #endif
            break;

        case SW_CLUTCH_TARGET_GCU_ID:
          #ifdef AAC_H
            if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL && accelerationFb > 0)
            {
                if (accelerationFb > 0)
                {
                  aac_stop();
                }
          #endif
                if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
                {
                   //Buzzer_Bip();
                   Clutch_setBiased(dataBuffer[0]);
                   //Clutch_set(dataBuffer[0]);
                   clutchPulled = 1;
                }
          #ifdef AAC_H
            }
          #endif
          if (clutchPulled == 0 && accelerationFb == 0)
          {
              Clutch_setBiased(dataBuffer[0]);
          }
          clutchPulled = 0;

            break;

        case EFI_HALL_ID:
              //salvare dati in variabili globali
              break;
              
        #ifdef AAC_H
        case SW_ACCELERATION_GCU_ID:
              //dSignalLed_switch(DSIGNAL_LED_RG12);
              if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
   //             && gearShift_currentGear == GEARSHIFT_NEUTRAL
   //             && aac_externValues[WHEEL_SPEED] <= 1
              {
                aac_currentState = START;   //comment to disable AAC
                //Buzzer_bip(); //for testing
              }
              else if(aac_currentState == READY && firstInt == 2)
              {
                aac_currentState = START_RELEASE; //comment to disable AAC
                //Buzzer_bip(); //for testing
              }
              //If none of the previous conditions are met, the aac is stopped
              else if (firstInt == 0)
              {
                if (accelerationFb > 0)
                {
                   aac_stop();
                   Clutch_release();
                }
              }
              break;
        #endif
        
        #ifdef TRACTION_H      
        case SW_TRACTION_CONTROL_GCU_ID:
            //set traction to EFI
            tractionFb = firstInt;
            //traction_state = tractionVariable[tractionFb];
            traction_currentState = tractionFb * 100;
            setTraction(TRACTION_CODE, traction_currentState);
            //Buzzer_Bip();
         
            break;      
        #endif

        #ifdef DRS_H    
        case SW_DRS_GCU_ID:
            if(firstInt == 1)
            {
                Drs_open();
                //Buzzer_Bip();
            }
            else if(firstInt == 0)
            {
                Drs_close();
                //Buzzer_Bip();
            }
            break;
        #endif
            
        default:
          break;
    }
}