#include "sw.h"
#include "buzzer.h"
#include "aac.h"
#include "traction.h"
#include "drs.h"

void sendUpdatesSW(unsigned int valCode)
{
    Can_resetWritePacket();
    switch (valCode)
    {
    #ifdef AAC_H
      case ACC_CODE:
           Can_addIntToWritePacket(ACC_CODE);
           Can_addIntToWritePacket(accelerationFb);
           break;
    #endif
    #ifdef AUTOCROSS_H
      case AUTOX_CODE:
           Can_addIntToWritePacket(AUTOX_CODE);
           Can_addIntToWritePacket(autocrossFb);
           break;
    #endif
    #ifdef TRACTION_H
      case TRACTION_CODE:
           Can_addIntToWritePacket(TRACTION_CODE);
           Can_addIntToWritePacket(tractionFb);
           break;
    #endif
    #ifdef DRS_H
      case DRS_CODE:
           Can_addIntToWritePacket(DRS_CODE);
           Can_addIntToWritePacket(drsFb);
           break;
    #endif
      default:
           break;
    }
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_write(GCU_FEEDBACK_ID);
}