#line 1 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/libs/eeprom.c"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/eeprom.h"







void EEPROM_writeInt(unsigned int address, unsigned int value);

unsigned int EEPROM_readInt(unsigned int address);

void EEPROM_writeArray(unsigned int address, unsigned int *values);

void EEPROM_readArray(unsigned int address, unsigned int *values);
#line 7 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/libs/eeprom.c"
void EEPROM_writeInt(unsigned int address, unsigned int value) {
 unsigned int currentValue;
 currentValue = EEPROM_read(address);
 if (currentValue != value) {
 EEPROM_write(address, value);
 }
}

unsigned int EEPROM_readInt(unsigned int address) {
 return EEPROM_read(address);
}

void EEPROM_writeArray(unsigned int address, unsigned int *values) {
 unsigned int i;
 for (i = 0; i < sizeof(values); i += 1) {
 EEPROM_writeInt(address, values[i]);
 }
}

void EEPROM_readArray(unsigned int address, unsigned int *values) {
 unsigned int i;
 for (i = 0; i < sizeof(values); i += 1) {
 values[i] = EEPROM_read(address + i);
 }
}
