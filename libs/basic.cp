#line 1 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/libs/basic.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdio.h"
#line 1 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/basic.h"
#line 16 "c:/users/sa/desktop/gcu-dpx-ottobiano-16-10/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);
#line 8 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/libs/basic.c"
void unsignedIntToString(unsigned int number, char *text) {
 emptyString(text);
 sprintf(text, "%u", number);
}

void signedIntToString(int number, char *text) {
 emptyString(text);
 sprintf(text, "%d", number);
}

void emptyString(char *myString) {
 myString[0] = '\0';
#line 23 "C:/Users/sA/Desktop/GCU-DPX-OTTOBIANO-16-10/libs/basic.c"
}

unsigned char getNumberDigitCount(unsigned char number) {
 if (number >= 100) {
 return 3;
 } else if (number >= 10) {
 return 2;
 } else {
 return 1;
 }
}
