
_getTempSensor:
	LNK	#10

;sensors.c,26 :: 		unsigned int getTempSensor()
;sensors.c,28 :: 		unsigned int analogValue = 0;
	PUSH	W10
;sensors.c,29 :: 		unsigned int voltTempSensor = 0;
;sensors.c,30 :: 		unsigned int convTempSensor = 0;
;sensors.c,31 :: 		analogValue = ADC1_Read(TEMP_SENSE_PIN);
	MOV	#10, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+0]
;sensors.c,32 :: 		sensors_gcuTemp = sensors_gcuTemp * 0.95 + analogValue * 0.05;
	MOV	_sensors_gcuTemp, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	MOV	W0, [W14+6]
	MOV	W1, [W14+8]
	MOV	[W14+0], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+6], W2
	MOV	[W14+8], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_gcuTemp
;sensors.c,33 :: 		voltTempSensor = ((float)(sensors_gcuTemp * 5)/4095.0)*1000.0;
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
;sensors.c,34 :: 		convTempSensor = (unsigned int)((voltTempSensor - 100)*0.1-40);
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
;sensors.c,35 :: 		return convTempSensor;
;sensors.c,36 :: 		}
;sensors.c,35 :: 		return convTempSensor;
;sensors.c,36 :: 		}
L_end_getTempSensor:
	POP	W10
	ULNK
	RETURN
; end of _getTempSensor

_getDRSSensor:
	LNK	#12

;sensors.c,37 :: 		unsigned int getDRSSensor()
;sensors.c,39 :: 		unsigned int convDrsSensor = 0;
	PUSH	W10
	MOV	#0, W0
	MOV	W0, [W14+0]
;sensors.c,40 :: 		unsigned int analogValue = 0;
;sensors.c,41 :: 		analogValue = ADC1_Read(DRS_SENSE_PIN);
	MOV	#8, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+2]
;sensors.c,42 :: 		sensors_drsCurrent = sensors_drsCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_drsCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_drsCurrent
;sensors.c,43 :: 		return convDrsSensor;
	MOV	[W14+0], W0
;sensors.c,44 :: 		}
;sensors.c,43 :: 		return convDrsSensor;
;sensors.c,44 :: 		}
L_end_getDRSSensor:
	POP	W10
	ULNK
	RETURN
; end of _getDRSSensor

_getFuelSensor:
	LNK	#12

;sensors.c,45 :: 		unsigned int getFuelSensor()
;sensors.c,47 :: 		unsigned int convFuelSensor = 0;
	PUSH	W10
	MOV	#0, W0
	MOV	W0, [W14+0]
;sensors.c,48 :: 		unsigned int analogValue = 0;
;sensors.c,49 :: 		analogValue = ADC1_Read(FUEL_SENSE_PIN);
	MOV	#4, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+2]
;sensors.c,50 :: 		sensors_fuelCurrent = sensors_fuelCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_fuelCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_fuelCurrent
;sensors.c,51 :: 		return  convFuelSensor;
	MOV	[W14+0], W0
;sensors.c,52 :: 		}
;sensors.c,51 :: 		return  convFuelSensor;
;sensors.c,52 :: 		}
L_end_getFuelSensor:
	POP	W10
	ULNK
	RETURN
; end of _getFuelSensor

_getGearSensor:
	LNK	#12

;sensors.c,53 :: 		unsigned int getGearSensor()
;sensors.c,55 :: 		unsigned int convGearSensor = 0;
	PUSH	W10
	MOV	#0, W0
	MOV	W0, [W14+0]
;sensors.c,56 :: 		unsigned int analogValue = 0;
;sensors.c,57 :: 		analogValue = ADC1_Read(GEAR_IS1_SENSE_PIN);
	MOV	#11, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+2]
;sensors.c,58 :: 		sensors_gearCurrent = sensors_gearCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_gearCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_gearCurrent
;sensors.c,59 :: 		return convGearSensor;
	MOV	[W14+0], W0
;sensors.c,60 :: 		}
;sensors.c,59 :: 		return convGearSensor;
;sensors.c,60 :: 		}
L_end_getGearSensor:
	POP	W10
	ULNK
	RETURN
; end of _getGearSensor

_getClutchSensor:
	LNK	#12

;sensors.c,61 :: 		unsigned int getClutchSensor()
;sensors.c,63 :: 		unsigned int convClutchSensor = 0;
	PUSH	W10
	MOV	#0, W0
	MOV	W0, [W14+0]
;sensors.c,64 :: 		unsigned int analogValue = 0;
;sensors.c,65 :: 		analogValue = ADC1_Read(CLUTCH_SENSE_PIN);
	MOV	#2, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+2]
;sensors.c,66 :: 		sensors_clutchCurrent = sensors_clutchCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_clutchCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_clutchCurrent
;sensors.c,67 :: 		return convClutchSensor;
	MOV	[W14+0], W0
;sensors.c,68 :: 		}
;sensors.c,67 :: 		return convClutchSensor;
;sensors.c,68 :: 		}
L_end_getClutchSensor:
	POP	W10
	ULNK
	RETURN
; end of _getClutchSensor

_getHPumpSensor:
	LNK	#12

;sensors.c,69 :: 		unsigned int getHPumpSensor()
;sensors.c,71 :: 		unsigned int convHPumpSensor = 0;
	PUSH	W10
	MOV	#0, W0
	MOV	W0, [W14+0]
;sensors.c,72 :: 		unsigned int analogValue = 0;
;sensors.c,73 :: 		analogValue = ADC1_Read(HPUMP_SENSE_PIN);
	MOV	#5, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+2]
;sensors.c,74 :: 		sensors_hpumpCurrent = sensors_hpumpCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_hpumpCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_hpumpCurrent
;sensors.c,75 :: 		return convHPumpSensor;
	MOV	[W14+0], W0
;sensors.c,76 :: 		}
;sensors.c,75 :: 		return convHPumpSensor;
;sensors.c,76 :: 		}
L_end_getHPumpSensor:
	POP	W10
	ULNK
	RETURN
; end of _getHPumpSensor

_getFanSensor:
	LNK	#12

;sensors.c,77 :: 		unsigned int getFanSensor()
;sensors.c,79 :: 		unsigned int convFanSensor = 0;
	PUSH	W10
	MOV	#0, W0
	MOV	W0, [W14+0]
;sensors.c,80 :: 		unsigned int analogValue = 0;
;sensors.c,81 :: 		analogValue = ADC1_Read(FANS_SENSE_PIN);
	MOV	#3, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+2]
;sensors.c,82 :: 		sensors_fanCurrent = sensors_fanCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_fanCurrent, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16243, W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	MOV	W0, _sensors_fanCurrent
;sensors.c,83 :: 		return convFanSensor;
	MOV	[W14+0], W0
;sensors.c,84 :: 		}
;sensors.c,83 :: 		return convFanSensor;
;sensors.c,84 :: 		}
L_end_getFanSensor:
	POP	W10
	ULNK
	RETURN
; end of _getFanSensor

_sendSensorsDebug1:
	LNK	#6

;sensors.c,86 :: 		void sendSensorsDebug1(void)
;sensors.c,88 :: 		unsigned int temp = 0;
	PUSH	W10
	PUSH	W11
;sensors.c,89 :: 		unsigned int drs = 0;
;sensors.c,90 :: 		unsigned int fuel = 0;
;sensors.c,91 :: 		temp = getTempSensor();
	CALL	_getTempSensor
	MOV	W0, [W14+0]
;sensors.c,92 :: 		drs = getDRSSensor();
	CALL	_getDRSSensor
	MOV	W0, [W14+2]
;sensors.c,93 :: 		fuel = getFuelSensor();
	CALL	_getFuelSensor
	MOV	W0, [W14+4]
;sensors.c,94 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;sensors.c,95 :: 		Can_addIntToWritePacket(temp);
	MOV	[W14+0], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,96 :: 		Can_addIntToWritePacket(drs);
	MOV	[W14+2], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,97 :: 		Can_addIntToWritePacket(fuel);
	MOV	[W14+4], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,98 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sensors.c,99 :: 		Can_write(GCU_DEBUG_1_ID);
	MOV	#790, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors.c,100 :: 		}
L_end_sendSensorsDebug1:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _sendSensorsDebug1

_sendSensorsDebug2:
	LNK	#8

;sensors.c,102 :: 		void sendSensorsDebug2(void)
;sensors.c,104 :: 		unsigned int gear = 0;
	PUSH	W10
	PUSH	W11
;sensors.c,105 :: 		unsigned int clutch = 0;
;sensors.c,106 :: 		unsigned int hPump = 0;
;sensors.c,107 :: 		unsigned int fan = 0;
;sensors.c,108 :: 		gear = getGearSensor();
	CALL	_getGearSensor
	MOV	W0, [W14+0]
;sensors.c,109 :: 		clutch = getClutchSensor();
	CALL	_getClutchSensor
	MOV	W0, [W14+2]
;sensors.c,110 :: 		hPump = getHPumpSensor();
	CALL	_getHPumpSensor
	MOV	W0, [W14+4]
;sensors.c,111 :: 		fan = getFanSensor();
	CALL	_getFanSensor
	MOV	W0, [W14+6]
;sensors.c,112 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;sensors.c,113 :: 		Can_addIntToWritePacket(gear);
	MOV	[W14+0], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,114 :: 		Can_addIntToWritePacket(clutch);
	MOV	[W14+2], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,115 :: 		Can_addIntToWritePacket(hPump);
	MOV	[W14+4], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,116 :: 		Can_addIntToWritePacket(fan);
	MOV	[W14+6], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,117 :: 		Can_write(GCU_DEBUG_2_ID);
	MOV	#791, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors.c,118 :: 		}
L_end_sendSensorsDebug2:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _sendSensorsDebug2
