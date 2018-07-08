//
// Created by Salvo 08/07/2018
//

#include "drs.h"

unsigned char drs_currentValue = 0;
unsigned int drsFb = 0;

void Drs_insert(void) {
    Drs_set(100);
}

void Drs_release(void) {
    Drs_set(0);
}

void DRs_set(unsigned char percentage) {
    unsigned char actualPercentage = 0;
    if (percentage > 100) {
        actualPercentage = 100;
    } else {
        actualPercentage = percentage;
    }
    DrsMotor_setPosition(100 - actualPercentage);
    Drs_currentValue = actualPercentage;
}

unsigned char Drs_get(void) {
    return Drs_currentValue;
}