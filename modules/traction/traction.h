/**/

#ifndef TRACTION_H
#define TRACTION_H

#include "clutch.h"
#include "gearshift.h"
#include "efi.h"
#include "can.h"
#include "buzzer.h"

#define MAX_TRACTION_VARIABLES 8        //0 per disabilitare
#define FIRST_TRACTION_VARIABLES 0
#define END_TRACTION_VARIABLES 700
#define STEP_TRACTION_VARIABLES 100
#define UNSET_TRACTION 0

#define TRACTION_NUM_PARAM 8

extern unsigned int tractionFb;
extern unsigned int tractionVariable[11];

typedef enum{
    TRACTION_0,
    TRACTION_1,
    TRACTION_2,
    TRACTION_3,
    TRACTION_4,
    TRACTION_5,
    TRACTION_6,
    TRACTION_7
}traction_params;

void traction_init(void);

void tractionLoadDefaultsSettings(void);

setTraction(unsigned int codeValue, unsigned int tractionValue);

Efi_setTraction(unsigned int setState);



#endif