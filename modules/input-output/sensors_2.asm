
_getTempSensor:

;sensors_2.c,17 :: 		unsigned int getTempSensor()
;sensors_2.c,19 :: 		unsigned int analogValue = 0;
	PUSH	W10
;sensors_2.c,20 :: 		unsigned int voltTempSensor = 0;
;sensors_2.c,21 :: 		unsigned int tempSensor = 0;
;sensors_2.c,22 :: 		analogValue = ADC1_Read(TEMP_SENSE_PIN);
	MOV	#10, W10
	CALL	_ADC1_Read
;sensors_2.c,23 :: 		voltTempSensor = ((float)(analogValue * 5)/4095.0)*1000.0;
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
;sensors_2.c,24 :: 		tempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
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
;sensors_2.c,25 :: 		return tempSensor;
;sensors_2.c,26 :: 		}
;sensors_2.c,25 :: 		return tempSensor;
;sensors_2.c,26 :: 		}
L_end_getTempSensor:
	POP	W10
	RETURN
; end of _getTempSensor

_getDRSSensor:

;sensors_2.c,27 :: 		unsigned int getDRSSensor()
;sensors_2.c,29 :: 		unsigned int drsSensor = 0;
	PUSH	W10
; drsSensor start address is: 4 (W2)
	CLR	W2
;sensors_2.c,30 :: 		unsigned int analogValue = 0;
;sensors_2.c,31 :: 		analogValue = ADC1_Read(DRS_SENSE_PIN);
	MOV	#8, W10
	CALL	_ADC1_Read
;sensors_2.c,32 :: 		return drsSensor;
	MOV	W2, W0
; drsSensor end address is: 4 (W2)
;sensors_2.c,33 :: 		}
;sensors_2.c,32 :: 		return drsSensor;
;sensors_2.c,33 :: 		}
L_end_getDRSSensor:
	POP	W10
	RETURN
; end of _getDRSSensor

_getFuelSensor:

;sensors_2.c,34 :: 		unsigned int getFuelSensor()
;sensors_2.c,36 :: 		unsigned int fuelSensor = 0;
	PUSH	W10
; fuelSensor start address is: 4 (W2)
	CLR	W2
;sensors_2.c,37 :: 		unsigned int analogValue = 0;
;sensors_2.c,38 :: 		analogValue = ADC1_Read(FUEL_SENSE_PIN);
	MOV	#4, W10
	CALL	_ADC1_Read
;sensors_2.c,39 :: 		return  fuelSensor;
	MOV	W2, W0
; fuelSensor end address is: 4 (W2)
;sensors_2.c,40 :: 		}
;sensors_2.c,39 :: 		return  fuelSensor;
;sensors_2.c,40 :: 		}
L_end_getFuelSensor:
	POP	W10
	RETURN
; end of _getFuelSensor

_getGearSensor:

;sensors_2.c,41 :: 		unsigned int getGearSensor()
;sensors_2.c,43 :: 		unsigned int gearSensor = 0;
	PUSH	W10
; gearSensor start address is: 4 (W2)
	CLR	W2
;sensors_2.c,44 :: 		unsigned int analogValue = 0;
;sensors_2.c,45 :: 		analogValue = ADC1_Read(GEAR_IS1_SENSE_PIN);
	MOV	#11, W10
	CALL	_ADC1_Read
;sensors_2.c,46 :: 		return gearSensor;
	MOV	W2, W0
; gearSensor end address is: 4 (W2)
;sensors_2.c,47 :: 		}
;sensors_2.c,46 :: 		return gearSensor;
;sensors_2.c,47 :: 		}
L_end_getGearSensor:
	POP	W10
	RETURN
; end of _getGearSensor

_getClutchSensor:

;sensors_2.c,48 :: 		unsigned int getClutchSensor()
;sensors_2.c,50 :: 		unsigned int clutchSensor = 0;
	PUSH	W10
; clutchSensor start address is: 4 (W2)
	CLR	W2
;sensors_2.c,51 :: 		unsigned int analogValue = 0;
;sensors_2.c,52 :: 		analogValue = ADC1_Read(CLUTCH_SENSE_PIN);
	MOV	#2, W10
	CALL	_ADC1_Read
;sensors_2.c,53 :: 		return clutchSensor;
	MOV	W2, W0
; clutchSensor end address is: 4 (W2)
;sensors_2.c,54 :: 		}
;sensors_2.c,53 :: 		return clutchSensor;
;sensors_2.c,54 :: 		}
L_end_getClutchSensor:
	POP	W10
	RETURN
; end of _getClutchSensor

_getHPumpSensor:

;sensors_2.c,55 :: 		unsigned int getHPumpSensor()
;sensors_2.c,57 :: 		unsigned int HPumpSensor = 0;
	PUSH	W10
; HPumpSensor start address is: 4 (W2)
	CLR	W2
;sensors_2.c,58 :: 		unsigned int analogValue = 0;
;sensors_2.c,59 :: 		analogValue = ADC1_Read(HPUMP_SENSE_PIN);
	MOV	#5, W10
	CALL	_ADC1_Read
;sensors_2.c,60 :: 		return HPumpSensor;
	MOV	W2, W0
; HPumpSensor end address is: 4 (W2)
;sensors_2.c,61 :: 		}
;sensors_2.c,60 :: 		return HPumpSensor;
;sensors_2.c,61 :: 		}
L_end_getHPumpSensor:
	POP	W10
	RETURN
; end of _getHPumpSensor

_getFanSensor:

;sensors_2.c,62 :: 		unsigned int getFanSensor()
;sensors_2.c,64 :: 		unsigned int fanSensor = 0;
	PUSH	W10
; fanSensor start address is: 4 (W2)
	CLR	W2
;sensors_2.c,65 :: 		unsigned int analogValue = 0;
;sensors_2.c,66 :: 		analogValue = ADC1_Read(FAN_SENSE_PIN);
	MOV	#3, W10
	CALL	_ADC1_Read
;sensors_2.c,67 :: 		return fanSensor;
	MOV	W2, W0
; fanSensor end address is: 4 (W2)
;sensors_2.c,68 :: 		}
;sensors_2.c,67 :: 		return fanSensor;
;sensors_2.c,68 :: 		}
L_end_getFanSensor:
	POP	W10
	RETURN
; end of _getFanSensor

_sendSensorsDebug1:
	LNK	#6

;sensors_2.c,70 :: 		void sendSensorsDebug1(void)
;sensors_2.c,72 :: 		unsigned int temp = 0;
	PUSH	W10
	PUSH	W11
;sensors_2.c,73 :: 		unsigned int drs = 0;
;sensors_2.c,74 :: 		unsigned int fuel = 0;
;sensors_2.c,75 :: 		temp = getTempSensor();
	CALL	_getTempSensor
	MOV	W0, [W14+0]
;sensors_2.c,76 :: 		drs = getDRSSensor();
	CALL	_getDRSSensor
	MOV	W0, [W14+2]
;sensors_2.c,77 :: 		fuel = getFuelSensor();
	CALL	_getFuelSensor
	MOV	W0, [W14+4]
;sensors_2.c,78 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;sensors_2.c,79 :: 		Can_addIntToWritePacket(temp);
	MOV	[W14+0], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,80 :: 		Can_addIntToWritePacket(drs);
	MOV	[W14+2], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,81 :: 		Can_addIntToWritePacket(fuel);
	MOV	[W14+4], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,82 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,83 :: 		Can_write(GCU_DEBUG_1_ID);
	MOV	#790, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors_2.c,84 :: 		}
L_end_sendSensorsDebug1:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _sendSensorsDebug1

_sendSensorsDebug2:
	LNK	#8

;sensors_2.c,86 :: 		void sendSensorsDebug2(void)
;sensors_2.c,88 :: 		unsigned int gear = 0;
	PUSH	W10
	PUSH	W11
;sensors_2.c,89 :: 		unsigned int clutch = 0;
;sensors_2.c,90 :: 		unsigned int hPump = 0;
;sensors_2.c,91 :: 		unsigned int fan = 0;
;sensors_2.c,92 :: 		gear = getGearSensor();
	CALL	_getGearSensor
	MOV	W0, [W14+0]
;sensors_2.c,93 :: 		clutch = getClutchSensor();
	CALL	_getClutchSensor
	MOV	W0, [W14+2]
;sensors_2.c,94 :: 		hPump = getHPumpSensor();
	CALL	_getHPumpSensor
	MOV	W0, [W14+4]
;sensors_2.c,95 :: 		fan = getFanSensor();
	CALL	_getFanSensor
	MOV	W0, [W14+6]
;sensors_2.c,96 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;sensors_2.c,97 :: 		Can_addIntToWritePacket(gear);
	MOV	[W14+0], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,98 :: 		Can_addIntToWritePacket(clutch);
	MOV	[W14+2], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,99 :: 		Can_addIntToWritePacket(hPump);
	MOV	[W14+4], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,100 :: 		Can_addIntToWritePacket(fan);
	MOV	[W14+6], W10
	CALL	_Can_addIntToWritePacket
;sensors_2.c,101 :: 		Can_write(GCU_DEBUG_2_ID);
	MOV	#791, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors_2.c,102 :: 		}
L_end_sendSensorsDebug2:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _sendSensorsDebug2
