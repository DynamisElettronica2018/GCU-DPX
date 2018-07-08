

#ifndef FIRMWARE_DRS_H
#define FIRMWARE_DRS_H

#include "drsmotor.h"

void Drs_insert(void);

void Drs_release(void);

void Drs_set(unsigned char percentage);

unsigned char Drs_get(void);

#endif //FIRMWARE_CLUTCH_H