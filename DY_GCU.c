/*
 * Software GCU DPX
*/

#include "dspic.h"
#include "d_signalled.h"
#include "eeprom.h"
#include "gearmotor.h"
#include "clutchmotor.h"
#include "drsmotor.h"
#include "efi.h"
#include "buzzer.h"
#include "sensors.h"
#include "clutch.h"
//#include "drs.h"
#include "enginecontrol.h"
#include "gearshift.h"
#include "stoplight.h"
#include "sensors_2.h"
//#include "aac.h"                //COMMENT THIS LINE TO DISABLE AAC
#include "traction.h"           //COMMENT THIS LINE TO DISABLE
//#include "autocross.h"          //COMMENT THIS LINE TO DISABLE AUTOCROSS
//*/
//int tractionTemp = 0;

int timer1_counter0 = 0, timer1_counter1 = 0, timer1_counter2 = 0, timer1_counter3 = 0, timer1_counter4 = 0;
char bello = 0;
char isSteeringWheelAvailable;
  unsigned int tempSens;
  unsigned int gearSens;


#ifdef AAC_H
  extern aac_states aac_currentState;
  extern int aac_externValues[AAC_NUM_VALUES];
  extern int acc_parameters[AAC_NUM_PARAMS ];
  //extern bool aac_sendingAll = false;
  extern int aac_timesCounter;
  int timer1_aac_counter = 0;
#endif

#ifdef TRACTION_H
  extern unsigned int traction_currentState;
  extern int traction_parameters[TRACTION_NUM_PARAM];
  extern int traction_timesCounter;
  int timer1_traction_counter = 0;
#endif

#ifdef AUTOCROSS_H
  //dichiarazioni variabili AUTOCROSS
  extern autocross_states autocross_currentState;
  extern int autocross_externValues[AUTOCROSS_NUM_VALUES];
  extern int autocross_parameters[AUTOCROSS_NUM_PARAMS];
  //extern bool autocross_sendingAll = false;
  extern int autocross_timesCounter;
  int timer1_autocross_counter = 0;
#endif

#ifdef DRS_H
  extern unsigned int drs_currentState;
#endif

unsigned int gearShift_timings[RIO_NUM_TIMES]; //30 tanto perch� su gcu c'� spazio e cos� possiamo fare fino a 30 step di cambiata, molto powa
extern unsigned int gearShift_currentGear;
extern char gearShift_isShiftingUp, gearShift_isShiftingDown, gearShift_isSettingNeutral, gearShift_isUnsettingNeutral;

void sendUpdatesSW(void)
{
    Can_resetWritePacket();
    #ifdef TRACTION_H
    Can_addIntToWritePacket(tractionFb);
    #endif
    #ifdef AAC_H
    Can_addIntToWritePacket(accelerationFb);
    #endif
    #ifdef DRS_H
    Can_addIntToWritePacket(drsFb);
    #endif
    #ifdef AUTOCROSS_H
    Can_addIntToWritePacket(autocrossFb);
    #endif
    #ifndef DRS_H
    Can_addIntToWritePacket(0);
    #endif
    #ifndef AUTOCROSS_H
    Can_addIntToWritePacket(0);
    #endif
    Can_write(GCU_DEBUG_2_ID);

}


void sendSensors2(void)
{

    tempSens = getTempSensor();
    gearSens = getGearSensor();
    Can_resetWritePacket();
    Can_addIntToWritePacket(tempSens);
    Can_addIntToWritePAcket(gearSens);
    Can_write(GCU_DEBUG_1_ID);
}


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
    DRSMotor_init();
    Efi_init();
    GearShift_init();
    StopLight_init();
    Buzzer_init();
    sendUpdatesSW();
    //Sensors_init();
  #ifdef AAC_H
    aac_init();
  #endif
  #ifdef TRACTION_H
    traction_init();
  #endif
  #ifdef AUTOCROSS_H
    //init autocross
    autocross_init();
  #endif
    //Generic 1ms timer
    setTimer(TIMER1_DEVICE, 0.001);
    setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
}



void main() {
    init();
    Buzzer_Bip();
    //Clutch_set(100);
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
        //Sensors_send();

        /*Efi_setTraction(tractionTemp);
        tractionFb = (int)(tractionTemp/100.0);
        sendControlsSW();
        tractionTemp += 100;
        if (tractionTemp > 700)
        {
           tractionTemp = 0;
        }*/
        
        timer1_counter2 = 0;
      }
    if (timer1_counter3 >= 10) {
        //rio_sendTimes();
      #ifdef AAC_H
        aac_sendTimes();
      #endif
      #ifdef FIRMWARE_SENSORS_2_H
         sendSensors2();
      #endif

        timer1_counter3 = 0;
        
    }

  #ifdef AAC_H
    timer1_aac_counter += 1;
    if(timer1_aac_counter == AAC_WORK_RATE_ms){
        aac_execute();
        timer1_aac_counter = 0;
    }
  #endif

  #ifdef AUTOCROSS_H
    timer1_autocross_counter += 1;
    if(timer1_autocross_counter == AUTOCROSS_WORK_RATE_ms){
        autocross_execute();
        timer1_autocross_counter = 0;
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

   //dSignalLed_switch(DSIGNAL_LED_RG12);              //switch led state on CAN receive
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
            //Buzzer_Bip();
            break;

        /*
        **** COMMENTATA PER RIFARE STRUTTURA CONTROLLO LAUNCH ****
        case SW_RIO_GEAR_BRK_STEER_ID:
          #ifdef AAC_H
            if (Clutch_get() != 100
                  &&(firstInt == GEAR_COMMAND_NEUTRAL_DOWN
                     || firstInt == GEAR_COMMAND_NEUTRAL_UP
                     || firstInt == GEAR_COMMAND_DOWN))
                aac_stop();
          #endif
            GearShift_injectCommand(firstInt);
            break;
         */

        case SW_GEARSHIFT_ID:
            #ifdef AAC_H
            if (Clutch_get() != 100
                  &&(firstInt == GEAR_COMMAND_NEUTRAL_DOWN
                     || firstInt == GEAR_COMMAND_NEUTRAL_UP
                     || firstInt == GEAR_COMMAND_DOWN))
                aac_stop();
            #endif
             GearShift_injectCommand(firstInt);
          break;


        case EFI_TRACTION_CONTROL_ID:
          #ifdef AAC_H
            aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
          #endif
          #ifdef AUTOCROSS_H
            autocross_updateExternValue(WHEEL_SPEED, firstInt / 10);
          #endif
            break;
            
        case SW_CLUTCH_TARGET_GCU_ID:
          #ifdef AAC_H
            if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL)
            {
                if (accelerationFb > 0)
                {
                  aac_stop();
                  accelerationFb = 0;
                  sendUpdatesSW();
                }

          #endif
          /*#ifdef AUTOCROSS_H
            if(dataBuffer[0] > AUTOCROSS_CLUTCH_NOISE_LEVEL)
            {
                autocross_stop();
                autocrossFb = 0;
                sendUpdatesSW();
          #endif*/
            if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) 
            {
              //Buzzer_Bip();
              Clutch_setBiased(dataBuffer[0]);
              //Clutch_set(dataBuffer[0]);
            }
          /*#ifdef AUTOCROSS_H
            }
          #endif*/
          #ifdef AAC_H
            }
          #endif
          break;
            
        case SW_AUX_ID:
           #ifdef AUTOCROSS_H
              if(autocross_currentState == OFF && secondInt == 1)
              {
                 autocross_currentState = START;
              }
              else if (autocross_currentState == READY && secondInt == 2)
              {
                  autocross_currentState = START_RELEASE;
              }
              else if(secondInt == 0)
              {     //controllare cosa faccio per stop in autocross
                  autocross_Stop();
                  autocrossFb = 0;
                  sendUpdatesSW();
              }
           #endif
           break;

        /*
        ***** COMMENTATA PER RIFARE STRUTTURA SET TIMINGS *****
        case GCU_GEAR_TIMING_TELEMETRY_ID:
            switch(firstInt){
                case CODE_SET_TIME:
                     gearShift_timings[secondInt] = thirdInt;
                     rio_sendOneTime(secondInt);
                     break;
                case CODE_REFRESH:
                     rio_sendAllTimes();
                   #ifdef AAC_H
                     autocross_sendAllTimes();
                   #endif
                     break;
              #ifdef AAC_H
<<<<<<< HEAD
          cacode_set_aac:
                     aac_parameters[secondInt] = thirdInt;
                     aac_sendOneTime(secondInt);
=======
                case CODE_SET_AAC:
                     autocross_parameters[secondInt] = thirdInt;
                     autocross_sendOneTime(secondInt);
>>>>>>> autocross
              #endif
                default:
                     break;
            }
            break;
          */

        case EFI_HALL_ID:
              //salvare dati in variabili globali
              break;

        case SW_ACCELERATION_GCU_ID:
          #ifdef AAC_H
              //dSignalLed_switch(DSIGNAL_LED_RG12);
              if(aac_currentState == OFF && firstInt == 1                                 //FOR TESTING
   //             && gearShift_currentGear == GEARSHIFT_NEUTRAL
   //             && aac_externValues[WHEEL_SPEED] <= 1
                )
                {
                  aac_currentState = START;   //comment to disable AAC
                  accelerationFb = 1;
                  sendUpdatesSW();
                  Buzzer_bip();
                }
              else if(aac_currentState == READY && firstInt == 2){
                  aac_currentState = START_RELEASE; //comment to disable AAC
                  accelerationFb = 2;
                  sendUpdatesSW();
                  Buzzer_bip();
              }
              //If none of the previous conditions are met, the aac is stopped
              else
              {
                  aac_stop();
                  accelerationFb = 0;
                  sendUpdatesSW();
                  Buzzer_bip();
              }
            #endif
            break;
            
        case SW_AUX_ID:
            #ifdef ATUOCROSS_H
              //dSignalLed_switch(DSIGNAL_LED_RG12);
              if(autocross_currentState == OFF_AUTOCROSS && secondInt == 1                            //FOR TESTING
   //             && gearShift_currentGear == GEARSHIFT_NEUTRAL
   //             && autocross_externValues[WHEEL_SPEED] <= 1
                ){
                  autocross_currentState = START_AUTOCROSS; //comment to disable AAC
                  autocrossFb = 1;
                  sendUpdatesSW();
              }
              else if(autocross_currentState == READY_AUTOCROSS && secondInt == 2){
                  autocross_currentState = START_RELEASE_AUTOCROSS; //comment to disable AAC
                  autocrossFb = 2;
                  sendUpdatesSW();
              }
              //If none of the previous conditions are met, the autocross is stopped
              else
              {
                  autocross_stop();
                  /*autocrossFb = 0;
                  sendUpdatesSW();*/
               }
          #endif
          break;

        case SW_TRACTION_CONTROL_GCU_ID:
          #ifdef TRACTION_H
             //set traction to EFI
             tractionFb = firstInt;
             //traction_state = tractionVariable[tractionFb];
             traction_currentState = tractionFb * 100;
             Efi_setTraction(traction_currentState);
             sendUpdatesSW();
             Buzzer_Bip();
          #endif
          break;

        case SW_DRS_GCU_ID:
          #ifdef DRS_H
             if(firstInt == 1)
                Drs_open();
                Buzzer_Bip();
             else if(firstInt == 0)
                Drs_close();
             Buzzer_Bip();
          #endif

          
        default:
          break;
    }
}