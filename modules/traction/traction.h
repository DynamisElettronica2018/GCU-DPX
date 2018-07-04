/**/

#ifndef TRACTION_H
#define TRACTION_H

#include "can.h"
#include "buzzer.h"

#define MAX_TRACTION_VARIABLES 8        //0 per disabilitare
#define FIRST_TRACTION_VARIABLES 0
#define END_TRACTION_VARIABLES 700
#define STEP_TRACTION_VARIABLES 100
#define UNSET_TRACTION 0

extern unsigned int tractionFb;
extern unsigned int tractionVariable[11];

void initTraction(void);

Efi_setTraction(unsigned int setState);



#endif