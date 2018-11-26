
_GCU_isAlive:

;DY_GCU.c,64 :: 		void GCU_isAlive(void) {
;DY_GCU.c,65 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,66 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,67 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,68 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,69 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,70 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,71 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,73 :: 		void init(void) {
;DY_GCU.c,74 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,75 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,76 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,77 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,78 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,79 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,80 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,81 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,82 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,85 :: 		traction_init();
	CALL	_traction_init
;DY_GCU.c,89 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,90 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,93 :: 		aac_init();
	CALL	_aac_init
;DY_GCU.c,96 :: 		DRSMotor_init();
	CALL	_DrsMotor_init
;DY_GCU.c,97 :: 		Drs_initVoltReg();
	CALL	_Drs_initVoltReg
;DY_GCU.c,98 :: 		Drs_close();
	CALL	_Drs_close
;DY_GCU.c,101 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,102 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,104 :: 		}
L_end_init:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _init

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;DY_GCU.c,107 :: 		void main() {
;DY_GCU.c,110 :: 		init();
	CALL	_init
;DY_GCU.c,111 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,113 :: 		while (1)
L_main0:
;DY_GCU.c,116 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,118 :: 		}
	GOTO	L_main0
;DY_GCU.c,119 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_timer1_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;DY_GCU.c,122 :: 		onTimer1Interrupt{
;DY_GCU.c,123 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,124 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,125 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,126 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,127 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,128 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,129 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,130 :: 		timer1_drsCounter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_drsCounter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,139 :: 		if (timer1_counter0 >= 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GE	L__timer1_interrupt95
	GOTO	L_timer1_interrupt2
L__timer1_interrupt95:
;DY_GCU.c,140 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt96
	GOTO	L_timer1_interrupt3
L__timer1_interrupt96:
;DY_GCU.c,141 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,143 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,144 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,145 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,146 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt97
	GOTO	L_timer1_interrupt4
L__timer1_interrupt97:
;DY_GCU.c,147 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,148 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,149 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,152 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt98
	GOTO	L_timer1_interrupt5
L__timer1_interrupt98:
;DY_GCU.c,153 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,156 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,157 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,159 :: 		if (timer1_drsCounter >= 1000)
	MOV	_timer1_drsCounter, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GEU	L__timer1_interrupt99
	GOTO	L_timer1_interrupt6
L__timer1_interrupt99:
;DY_GCU.c,161 :: 		if(drs_currentvalue == 0)
	MOV	_drs_currentValue, W0
	CP	W0, #0
	BRA Z	L__timer1_interrupt100
	GOTO	L_timer1_interrupt7
L__timer1_interrupt100:
;DY_GCU.c,163 :: 		Drs_turnOffVoltReg();
	CALL	_Drs_turnOffVoltReg
;DY_GCU.c,164 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,166 :: 		timer1_drsCounter = 0;
	CLR	W0
	MOV	W0, _timer1_drsCounter
;DY_GCU.c,167 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,171 :: 		timer1_aac_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_aac_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,172 :: 		if(timer1_aac_counter == AAC_WORK_RATE_ms)
	MOV	_timer1_aac_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt101
	GOTO	L_timer1_interrupt8
L__timer1_interrupt101:
;DY_GCU.c,174 :: 		aac_execute();
	CALL	_aac_execute
;DY_GCU.c,175 :: 		timer1_aac_counter = 0;
	CLR	W0
	MOV	W0, _timer1_aac_counter
;DY_GCU.c,176 :: 		}
L_timer1_interrupt8:
;DY_GCU.c,180 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt102
	GOTO	L_timer1_interrupt9
L__timer1_interrupt102:
;DY_GCU.c,181 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,182 :: 		}
L_timer1_interrupt9:
;DY_GCU.c,200 :: 		}
L_end_timer1_interrupt:
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _timer1_interrupt

_CAN_Interrupt:
	LNK	#20
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;DY_GCU.c,202 :: 		onCanInterrupt{
;DY_GCU.c,207 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	ADD	W14, #18, W3
	ADD	W14, #16, W2
	ADD	W14, #8, W1
	ADD	W14, #4, W0
	MOV	W3, W13
	MOV	W2, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_Can_read
;DY_GCU.c,208 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,210 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt104
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt104:
;DY_GCU.c,211 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
	ADD	W14, #8, W1
	MOV.B	[W1], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #1, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #0, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,212 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,213 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt105
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt105:
;DY_GCU.c,214 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
	ADD	W14, #8, W1
	ADD	W1, #2, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #3, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #2, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,215 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,216 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt106
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt106:
;DY_GCU.c,218 :: 		}
L_CAN_Interrupt12:
;DY_GCU.c,219 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt107
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt107:
;DY_GCU.c,221 :: 		}
L_CAN_Interrupt13:
;DY_GCU.c,223 :: 		switch (id) {
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,224 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt16:
;DY_GCU.c,225 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,227 :: 		aac_updateExternValue(RPM, secondInt);
	MOV	[W14+2], W11
	CLR	W10
	CALL	_aac_updateExternValue
;DY_GCU.c,229 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,231 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt17:
;DY_GCU.c,232 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,233 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,234 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,236 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt18:
;DY_GCU.c,239 :: 		if (Clutch_get() != 100
	CALL	_Clutch_get
;DY_GCU.c,242 :: 		|| firstInt == GEAR_COMMAND_DOWN)
	MOV.B	#100, W1
	CP.B	W0, W1
	BRA NZ	L__CAN_Interrupt108
	GOTO	L__CAN_Interrupt75
L__CAN_Interrupt108:
;DY_GCU.c,241 :: 		|| firstInt == GEAR_COMMAND_NEUTRAL_UP
	MOV	#100, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA NZ	L__CAN_Interrupt109
	GOTO	L__CAN_Interrupt73
L__CAN_Interrupt109:
	MOV	#50, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA NZ	L__CAN_Interrupt110
	GOTO	L__CAN_Interrupt72
L__CAN_Interrupt110:
;DY_GCU.c,242 :: 		|| firstInt == GEAR_COMMAND_DOWN)
	MOV	#200, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA NZ	L__CAN_Interrupt111
	GOTO	L__CAN_Interrupt71
L__CAN_Interrupt111:
	GOTO	L_CAN_Interrupt23
;DY_GCU.c,241 :: 		|| firstInt == GEAR_COMMAND_NEUTRAL_UP
L__CAN_Interrupt73:
L__CAN_Interrupt72:
;DY_GCU.c,242 :: 		|| firstInt == GEAR_COMMAND_DOWN)
L__CAN_Interrupt71:
;DY_GCU.c,243 :: 		&& accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt112
	GOTO	L__CAN_Interrupt74
L__CAN_Interrupt112:
L__CAN_Interrupt69:
;DY_GCU.c,244 :: 		aac_stop();
	CALL	_aac_stop
L_CAN_Interrupt23:
;DY_GCU.c,242 :: 		|| firstInt == GEAR_COMMAND_DOWN)
L__CAN_Interrupt75:
;DY_GCU.c,243 :: 		&& accelerationFb > 0)
L__CAN_Interrupt74:
;DY_GCU.c,246 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,247 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,249 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt24:
;DY_GCU.c,251 :: 		aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_aac_updateExternValue
;DY_GCU.c,253 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,255 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt25:
;DY_GCU.c,257 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL && accelerationFb > 0)
	ADD	W14, #8, W0
	MOV.B	[W0], W0
	CP.B	W0, #30
	BRA GTU	L__CAN_Interrupt113
	GOTO	L__CAN_Interrupt80
L__CAN_Interrupt113:
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt114
	GOTO	L__CAN_Interrupt79
L__CAN_Interrupt114:
L__CAN_Interrupt68:
;DY_GCU.c,259 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt115
	GOTO	L_CAN_Interrupt29
L__CAN_Interrupt115:
;DY_GCU.c,261 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,262 :: 		}
L_CAN_Interrupt29:
;DY_GCU.c,264 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt116
	GOTO	L__CAN_Interrupt77
L__CAN_Interrupt116:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt117
	GOTO	L__CAN_Interrupt76
L__CAN_Interrupt117:
	GOTO	L__CAN_Interrupt66
L__CAN_Interrupt77:
L__CAN_Interrupt76:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt118
	GOTO	L__CAN_Interrupt78
L__CAN_Interrupt118:
	GOTO	L_CAN_Interrupt34
L__CAN_Interrupt66:
L__CAN_Interrupt78:
;DY_GCU.c,267 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,269 :: 		clutchPulled = 1;
	MOV	#lo_addr(_clutchPulled), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,270 :: 		}
L_CAN_Interrupt34:
;DY_GCU.c,257 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL && accelerationFb > 0)
L__CAN_Interrupt80:
L__CAN_Interrupt79:
;DY_GCU.c,275 :: 		if (clutchPulled == 0 && accelerationFb == 0)
	MOV	#lo_addr(_clutchPulled), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt119
	GOTO	L__CAN_Interrupt85
L__CAN_Interrupt119:
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt120
	GOTO	L__CAN_Interrupt84
L__CAN_Interrupt120:
L__CAN_Interrupt65:
;DY_GCU.c,278 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt121
	GOTO	L__CAN_Interrupt82
L__CAN_Interrupt121:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt122
	GOTO	L__CAN_Interrupt81
L__CAN_Interrupt122:
	GOTO	L__CAN_Interrupt63
L__CAN_Interrupt82:
L__CAN_Interrupt81:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt123
	GOTO	L__CAN_Interrupt83
L__CAN_Interrupt123:
	GOTO	L_CAN_Interrupt42
L__CAN_Interrupt63:
L__CAN_Interrupt83:
;DY_GCU.c,280 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,281 :: 		}
L_CAN_Interrupt42:
;DY_GCU.c,275 :: 		if (clutchPulled == 0 && accelerationFb == 0)
L__CAN_Interrupt85:
L__CAN_Interrupt84:
;DY_GCU.c,285 :: 		clutchPulled = 0;
	MOV	#lo_addr(_clutchPulled), W1
	CLR	W0
	MOV.B	W0, [W1]
;DY_GCU.c,287 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,289 :: 		case EFI_HALL_ID:
L_CAN_Interrupt43:
;DY_GCU.c,291 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,294 :: 		case SW_ACCELERATION_GCU_ID:
L_CAN_Interrupt44:
;DY_GCU.c,296 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt124
	GOTO	L__CAN_Interrupt87
L__CAN_Interrupt124:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt125
	GOTO	L__CAN_Interrupt86
L__CAN_Interrupt125:
L__CAN_Interrupt62:
;DY_GCU.c,300 :: 		aac_currentState = START;   //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,302 :: 		}
	GOTO	L_CAN_Interrupt48
;DY_GCU.c,296 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
L__CAN_Interrupt87:
L__CAN_Interrupt86:
;DY_GCU.c,303 :: 		else if(aac_currentState == READY && firstInt == 2)
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt126
	GOTO	L__CAN_Interrupt89
L__CAN_Interrupt126:
	MOV	[W14+0], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt127
	GOTO	L__CAN_Interrupt88
L__CAN_Interrupt127:
L__CAN_Interrupt61:
;DY_GCU.c,305 :: 		aac_currentState = START_RELEASE; //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,307 :: 		}
	GOTO	L_CAN_Interrupt52
;DY_GCU.c,303 :: 		else if(aac_currentState == READY && firstInt == 2)
L__CAN_Interrupt89:
L__CAN_Interrupt88:
;DY_GCU.c,309 :: 		else if (firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt128
	GOTO	L_CAN_Interrupt53
L__CAN_Interrupt128:
;DY_GCU.c,311 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt129
	GOTO	L_CAN_Interrupt54
L__CAN_Interrupt129:
;DY_GCU.c,313 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,314 :: 		Clutch_release();
	CALL	_Clutch_release
;DY_GCU.c,315 :: 		}
L_CAN_Interrupt54:
;DY_GCU.c,316 :: 		}
L_CAN_Interrupt53:
L_CAN_Interrupt52:
L_CAN_Interrupt48:
;DY_GCU.c,317 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,321 :: 		case SW_TRACTION_CONTROL_GCU_ID:
L_CAN_Interrupt55:
;DY_GCU.c,323 :: 		tractionFb = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _tractionFb
;DY_GCU.c,325 :: 		traction_currentState = tractionFb * 100;
	MOV	#100, W3
	ADD	W14, #0, W2
	MUL.UU	W3, [W2], W0
	MOV	W0, _traction_currentState
;DY_GCU.c,326 :: 		setTraction(TRACTION_CODE, traction_currentState);
	MOV	W0, W11
	MOV	#3, W10
	CALL	_setTraction
;DY_GCU.c,329 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,333 :: 		case SW_DRS_GCU_ID:
L_CAN_Interrupt56:
;DY_GCU.c,334 :: 		if(firstInt == 1)
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt130
	GOTO	L_CAN_Interrupt57
L__CAN_Interrupt130:
;DY_GCU.c,337 :: 		Drs_open();
	CALL	_Drs_open
;DY_GCU.c,339 :: 		}
	GOTO	L_CAN_Interrupt58
L_CAN_Interrupt57:
;DY_GCU.c,340 :: 		else if(firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt131
	GOTO	L_CAN_Interrupt59
L__CAN_Interrupt131:
;DY_GCU.c,342 :: 		Drs_close();
	CALL	_Drs_close
;DY_GCU.c,345 :: 		}
L_CAN_Interrupt59:
L_CAN_Interrupt58:
;DY_GCU.c,346 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,349 :: 		default:
L_CAN_Interrupt60:
;DY_GCU.c,350 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,351 :: 		}
L_CAN_Interrupt14:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt132
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt132:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt133
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt133:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt134
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt134:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt135
	GOTO	L_CAN_Interrupt24
L__CAN_Interrupt135:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt136
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt136:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt137
	GOTO	L_CAN_Interrupt43
L__CAN_Interrupt137:
	MOV	#514, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt138
	GOTO	L_CAN_Interrupt44
L__CAN_Interrupt138:
	MOV	#515, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt139
	GOTO	L_CAN_Interrupt55
L__CAN_Interrupt139:
	MOV	#517, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt140
	GOTO	L_CAN_Interrupt56
L__CAN_Interrupt140:
	GOTO	L_CAN_Interrupt60
L_CAN_Interrupt15:
;DY_GCU.c,352 :: 		}
L_end_CAN_Interrupt:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	ULNK
	RETFIE
; end of _CAN_Interrupt
