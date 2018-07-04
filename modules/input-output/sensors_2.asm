
_getTempSensor:

;sensors_2.c,8 :: 		unsigned int getTempSensor()
;sensors_2.c,10 :: 		unsigned int analogValue = 0;
	PUSH	W10
;sensors_2.c,11 :: 		unsigned int voltTempSensor = 0;
;sensors_2.c,12 :: 		unsigned int tempSensor = 0;
;sensors_2.c,13 :: 		analogValue = ADC1_Read(10);
	MOV	#10, W10
	CALL	_ADC1_Read
;sensors_2.c,14 :: 		voltTempSensor = ((float)(analogValue * 5)/4095.0)*1000.0;
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
;sensors_2.c,15 :: 		tempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
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
;sensors_2.c,16 :: 		return tempSensor;
;sensors_2.c,17 :: 		}
;sensors_2.c,16 :: 		return tempSensor;
;sensors_2.c,17 :: 		}
L_end_getTempSensor:
	POP	W10
	RETURN
; end of _getTempSensor

_sendTempSensor:
	LNK	#2

;sensors_2.c,19 :: 		void sendTempSensor(void)
;sensors_2.c,21 :: 		unsigned int temp = 0;
	PUSH	W10
	PUSH	W11
;sensors_2.c,22 :: 		temp = getTempSensor();
	CALL	_getTempSensor
	MOV	W0, [W14+0]
;sensors_2.c,23 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;sensors_2.c,24 :: 		Can_addIntToWritePacket(temp);
	MOV	[W14+0], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,25 :: 		Can_write(GCU_DEBUG_1_ID);
	MOV	#790, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors_2.c,26 :: 		}
L_end_sendTempSensor:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _sendTempSensor
