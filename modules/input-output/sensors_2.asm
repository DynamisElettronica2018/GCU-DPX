
_getTempSensor:

;sensors_2.c,6 :: 		unsigned int getTempSensor()
;sensors_2.c,8 :: 		unsigned int analogValue = 0;
	PUSH	W10
;sensors_2.c,9 :: 		unsigned int voltTempSensor = 0;
;sensors_2.c,10 :: 		analogValue = ADC1_Read(TEMP_SENSE_PIN);
	MOV	#10, W10
	CALL	_ADC1_Read
;sensors_2.c,11 :: 		voltTempSensor = ((float)(analogValue * 5)/4095.0)*1000.0;
	MOV	#5, W1
	MUL.UU	W0, W1, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#61440, W2
	MOV	#17791, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17530, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
;sensors_2.c,12 :: 		voltTempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
	MOV	#100, W1
	SUB	W0, W1, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15820, W3
	CALL	__Mul_FP
	MOV	#0, W2
	MOV	#16928, W3
	CALL	__Sub_FP
	CALL	__Float2Longint
;sensors_2.c,13 :: 		return voltTempSensor;
;sensors_2.c,14 :: 		}
;sensors_2.c,13 :: 		return voltTempSensor;
;sensors_2.c,14 :: 		}
L_end_getTempSensor:
	POP	W10
	RETURN
; end of _getTempSensor

_getGearSensor:

;sensors_2.c,15 :: 		unsigned int getGearSensor()
;sensors_2.c,17 :: 		unsigned int analogValue = 0;
	PUSH	W10
;sensors_2.c,18 :: 		unsigned int voltGearSensor = 0;
;sensors_2.c,19 :: 		analogValue = ADC1_Read(GEAR_SENSOR_PIN);
	MOV	#11, W10
	CALL	_ADC1_Read
;sensors_2.c,21 :: 		return voltGearSensor;
;sensors_2.c,22 :: 		}
;sensors_2.c,21 :: 		return voltGearSensor;
;sensors_2.c,22 :: 		}
L_end_getGearSensor:
	POP	W10
	RETURN
; end of _getGearSensor
