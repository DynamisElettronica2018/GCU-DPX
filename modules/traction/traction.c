/*
*/
#include "traction.h"
#include "traction_settings.h"
#include "sw.h"

unsigned int tractionFb = 0;
unsigned int tractionVariable[11];
unsigned int traction_currentState;
int traction_parameters[TRACTION_NUM_PARAM];

void traction_init(void)
{
     tractionLoadDefaultsSettings();
}

void tractionLoadDefaultsSettings(void)
{
    #ifndef EXTERNAL_EEPROM_H
      traction_parameters[TRACTION_0] = DEF_TRACTION_0;
      traction_parameters[TRACTION_1] = DEF_TRACTION_1;
      traction_parameters[TRACTION_2] = DEF_TRACTION_2;
      traction_parameters[TRACTION_3] = DEF_TRACTION_3;
      traction_parameters[TRACTION_4] = DEF_TRACTION_4;
      traction_parameters[TRACTION_5] = DEF_TRACTION_5;
      traction_parameters[TRACTION_6] = DEF_TRACTION_6;
      traction_parameters[TRACTION_7] = DEF_TRACTION_7;
    #endif
}

setTraction(unsigned int codeValue, unsigned int tractionValue)
{
    Efi_setTraction(tractionValue);
    sendUpdatesSW(codeValue);
}


Efi_setTraction(unsigned int setTractionValue)
{
    Can_resetWritePacket();
    Can_addIntToWritePacket(setTractionValue);
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_write(GCU_TRACTION_CONTROL_EFI_ID);

}