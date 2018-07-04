/*
*/
#include "traction.h"
#include "traction_settings.h"

unsigned int tractionFb = 0;
unsigned int tractionVariable[11];

void initTraction(void)
{
     int i = 0;
     tractionVariable[i] = UNSET_TRACTION;
     i++;
     tractionVariable[i] = FIRST_TRACTION_VARIABLES;
     for (; i <= MAX_TRACTION_VARIABLES; i++)
     {
         tractionVariable[i] = FIRST_TRACTION_VARIABLES + STEP_TRACTION_VARIABLES;
     }

}

Efi_setTraction(unsigned int setState)
{
    Can_resetWritePacket();
    Can_addIntToWritePacket(setState);
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_addIntToWritePacket(0);
    Can_write(GCU_TRACTION_CONTROL_EFI_ID);

}

