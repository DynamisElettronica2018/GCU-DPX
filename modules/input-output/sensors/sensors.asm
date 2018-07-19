
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
	LNK	#10

;sensors.c,37 :: 		unsigned int getDRSSensor()
;sensors.c,39 :: 		unsigned int convDrsSensor = 0;
	PUSH	W10
;sensors.c,40 :: 		unsigned int analogValue = 0;
;sensors.c,41 :: 		analogValue = ADC1_Read(DRS_SENSE_PIN);
	MOV	#8, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+0]
;sensors.c,42 :: 		sensors_drsCurrent = sensors_drsCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_drsCurrent, W0
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
	MOV	W0, _sensors_drsCurrent
;sensors.c,43 :: 		convDrsSensor = (((sensors_drsCurrent * 5.05 / 4095) * 1000) / 0.2);
	CLR	W1
	CALL	__Long2Float
	MOV	#39322, W2
	MOV	#16545, W3
	CALL	__Mul_FP
	MOV	#61440, W2
	MOV	#17791, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17530, W3
	CALL	__Mul_FP
	MOV	#52429, W2
	MOV	#15948, W3
	CALL	__Div_FP
	CALL	__Float2Longint
;sensors.c,44 :: 		return convDrsSensor;
;sensors.c,45 :: 		}
;sensors.c,44 :: 		return convDrsSensor;
;sensors.c,45 :: 		}
L_end_getDRSSensor:
	POP	W10
	ULNK
	RETURN
; end of _getDRSSensor

_getFuelSensor:
	LNK	#10

;sensors.c,46 :: 		unsigned int getFuelSensor()
;sensors.c,48 :: 		unsigned int convFuelSensor = 0;
	PUSH	W10
;sensors.c,49 :: 		unsigned int analogValue = 0;
;sensors.c,50 :: 		analogValue = ADC1_Read(FUEL_SENSE_PIN);
	MOV	#4, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+0]
;sensors.c,51 :: 		sensors_fuelCurrent = sensors_fuelCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_fuelCurrent, W0
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
	MOV	W0, _sensors_fuelCurrent
;sensors.c,52 :: 		convFuelSensor = (((sensors_fuelCurrent * 5.05 / 4095) * 1000) / 0.2);
	CLR	W1
	CALL	__Long2Float
	MOV	#39322, W2
	MOV	#16545, W3
	CALL	__Mul_FP
	MOV	#61440, W2
	MOV	#17791, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17530, W3
	CALL	__Mul_FP
	MOV	#52429, W2
	MOV	#15948, W3
	CALL	__Div_FP
	CALL	__Float2Longint
;sensors.c,53 :: 		return  convFuelSensor;
;sensors.c,54 :: 		}
;sensors.c,53 :: 		return  convFuelSensor;
;sensors.c,54 :: 		}
L_end_getFuelSensor:
	POP	W10
	ULNK
	RETURN
; end of _getFuelSensor

_getGearSensor:
	LNK	#10

;sensors.c,55 :: 		unsigned int getGearSensor()
;sensors.c,57 :: 		unsigned int convGearSensor = 0;
	PUSH	W10
;sensors.c,58 :: 		unsigned int analogValue = 0;
;sensors.c,59 :: 		analogValue = ADC1_Read(GEAR_IS1_SENSE_PIN);
	MOV	#11, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+0]
;sensors.c,60 :: 		sensors_gearCurrent = sensors_gearCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_gearCurrent, W0
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
	MOV	W0, _sensors_gearCurrent
;sensors.c,62 :: 		return convGearSensor;
;sensors.c,63 :: 		}
;sensors.c,62 :: 		return convGearSensor;
;sensors.c,63 :: 		}
L_end_getGearSensor:
	POP	W10
	ULNK
	RETURN
; end of _getGearSensor

_getClutchSensor:
	LNK	#10

;sensors.c,64 :: 		unsigned int getClutchSensor()
;sensors.c,66 :: 		unsigned int convClutchSensor = 0;
	PUSH	W10
;sensors.c,67 :: 		unsigned int analogValue = 0;
;sensors.c,68 :: 		analogValue = ADC1_Read(CLUTCH_SENSE_PIN);
	MOV	#2, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+0]
;sensors.c,69 :: 		sensors_clutchCurrent = sensors_clutchCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_clutchCurrent, W0
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
	MOV	W0, _sensors_clutchCurrent
;sensors.c,70 :: 		convClutchSensor = (((sensors_clutchCurrent * 5.05 / 4095) * 1000) / 0.2);
	CLR	W1
	CALL	__Long2Float
	MOV	#39322, W2
	MOV	#16545, W3
	CALL	__Mul_FP
	MOV	#61440, W2
	MOV	#17791, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17530, W3
	CALL	__Mul_FP
	MOV	#52429, W2
	MOV	#15948, W3
	CALL	__Div_FP
	CALL	__Float2Longint
;sensors.c,71 :: 		return convClutchSensor;
;sensors.c,72 :: 		}
;sensors.c,71 :: 		return convClutchSensor;
;sensors.c,72 :: 		}
L_end_getClutchSensor:
	POP	W10
	ULNK
	RETURN
; end of _getClutchSensor

_getHPumpSensor:
	LNK	#10

;sensors.c,73 :: 		unsigned int getHPumpSensor()
;sensors.c,75 :: 		unsigned int convHPumpSensor = 0;
	PUSH	W10
;sensors.c,76 :: 		unsigned int analogValue = 0;
;sensors.c,77 :: 		analogValue = ADC1_Read(HPUMP_SENSE_PIN);
	MOV	#5, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+0]
;sensors.c,78 :: 		sensors_hpumpCurrent = sensors_hpumpCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_hpumpCurrent, W0
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
	MOV	W0, _sensors_hpumpCurrent
;sensors.c,79 :: 		convHPumpSensor = (((sensors_hPumpCurrent * 5.05 / 4095) * 1000) / 0.2);
	CLR	W1
	CALL	__Long2Float
	MOV	#39322, W2
	MOV	#16545, W3
	CALL	__Mul_FP
	MOV	#61440, W2
	MOV	#17791, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17530, W3
	CALL	__Mul_FP
	MOV	#52429, W2
	MOV	#15948, W3
	CALL	__Div_FP
	CALL	__Float2Longint
;sensors.c,80 :: 		return convHPumpSensor;
;sensors.c,81 :: 		}
;sensors.c,80 :: 		return convHPumpSensor;
;sensors.c,81 :: 		}
L_end_getHPumpSensor:
	POP	W10
	ULNK
	RETURN
; end of _getHPumpSensor

_getFanSensor:
	LNK	#10

;sensors.c,82 :: 		unsigned int getFanSensor()
;sensors.c,84 :: 		unsigned int convFanSensor = 0;
	PUSH	W10
;sensors.c,85 :: 		unsigned int analogValue = 0;
;sensors.c,86 :: 		analogValue = ADC1_Read(FANS_SENSE_PIN);
	MOV	#3, W10
	CALL	_ADC1_Read
	MOV	W0, [W14+0]
;sensors.c,87 :: 		sensors_fanCurrent = sensors_fanCurrent * 0.95 + analogValue * 0.05;
	MOV	_sensors_fanCurrent, W0
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
	MOV	W0, _sensors_fanCurrent
;sensors.c,88 :: 		convFanSensor = (((sensors_fanCurrent * 5.05 / 4095) * 1000) / 0.2);
	CLR	W1
	CALL	__Long2Float
	MOV	#39322, W2
	MOV	#16545, W3
	CALL	__Mul_FP
	MOV	#61440, W2
	MOV	#17791, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17530, W3
	CALL	__Mul_FP
	MOV	#52429, W2
	MOV	#15948, W3
	CALL	__Div_FP
	CALL	__Float2Longint
;sensors.c,89 :: 		return convFanSensor;
;sensors.c,90 :: 		}
;sensors.c,89 :: 		return convFanSensor;
;sensors.c,90 :: 		}
L_end_getFanSensor:
	POP	W10
	ULNK
	RETURN
; end of _getFanSensor

_sendSensorsDebug1:
	LNK	#6

;sensors.c,92 :: 		void sendSensorsDebug1(void)
;sensors.c,94 :: 		unsigned int temp = 0;
	PUSH	W10
	PUSH	W11
;sensors.c,95 :: 		unsigned int drs = 0;
;sensors.c,96 :: 		unsigned int fuel = 0;
;sensors.c,97 :: 		temp = getTempSensor();
	CALL	_getTempSensor
	MOV	W0, [W14+0]
;sensors.c,98 :: 		drs = getDRSSensor();
	CALL	_getDRSSensor
	MOV	W0, [W14+2]
;sensors.c,99 :: 		fuel = getFuelSensor();
	CALL	_getFuelSensor
	MOV	W0, [W14+4]
;sensors.c,100 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;sensors.c,101 :: 		Can_addIntToWritePacket(temp);
	MOV	[W14+0], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,102 :: 		Can_addIntToWritePacket(drs);
	MOV	[W14+2], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,103 :: 		Can_addIntToWritePacket(fuel);
	MOV	[W14+4], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,104 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sensors.c,105 :: 		Can_write(GCU_DEBUG_1_ID);
	MOV	#790, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors.c,106 :: 		}
L_end_sendSensorsDebug1:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _sendSensorsDebug1

_sendSensorsDebug2:
	LNK	#8

;sensors.c,108 :: 		void sendSensorsDebug2(void)
;sensors.c,110 :: 		unsigned int gear = 0;
	PUSH	W10
	PUSH	W11
;sensors.c,111 :: 		unsigned int clutch = 0;
;sensors.c,112 :: 		unsigned int hPump = 0;
;sensors.c,113 :: 		unsigned int fan = 0;
;sensors.c,114 :: 		gear = getGearSensor();
	CALL	_getGearSensor
	MOV	W0, [W14+0]
;sensors.c,115 :: 		clutch = getClutchSensor();
	CALL	_getClutchSensor
	MOV	W0, [W14+2]
;sensors.c,116 :: 		hPump = getHPumpSensor();
	CALL	_getHPumpSensor
	MOV	W0, [W14+4]
;sensors.c,117 :: 		fan = getFanSensor();
	CALL	_getFanSensor
	MOV	W0, [W14+6]
;sensors.c,118 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;sensors.c,119 :: 		Can_addIntToWritePacket(gear);
	MOV	[W14+0], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,120 :: 		Can_addIntToWritePacket(clutch);
	MOV	[W14+2], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,121 :: 		Can_addIntToWritePacket(hPump);
	MOV	[W14+4], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,122 :: 		Can_addIntToWritePacket(fan);
	MOV	[W14+6], W10
	CALL	_Can_addIntToWritePacket
;sensors.c,123 :: 		Can_write(GCU_DEBUG_2_ID);
	MOV	#791, W10
	MOV	#0, W11
	CALL	_Can_write
;sensors.c,124 :: 		}
L_end_sendSensorsDebug2:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _sendSensorsDebug2
