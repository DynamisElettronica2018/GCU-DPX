
_GCU_isAlive:

;DY_GCU.c,63 :: 		void GCU_isAlive(void) {
;DY_GCU.c,64 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,65 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,66 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,67 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,68 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,69 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,70 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,72 :: 		void init(void) {
;DY_GCU.c,73 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,74 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,75 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,76 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,77 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,78 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,79 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,80 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,81 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,84 :: 		traction_init();
	CALL	_traction_init
;DY_GCU.c,88 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,89 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,92 :: 		aac_init();
	CALL	_aac_init
;DY_GCU.c,95 :: 		DRSMotor_init();
	CALL	_DrsMotor_init
;DY_GCU.c,96 :: 		Drs_close();
	CALL	_Drs_close
;DY_GCU.c,100 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,101 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,103 :: 		}
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

;DY_GCU.c,106 :: 		void main() {
;DY_GCU.c,109 :: 		init();
	CALL	_init
;DY_GCU.c,110 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,112 :: 		while (1)
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
;DY_GCU.c,131 :: 		timer2_sensors_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer2_sensors_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,138 :: 		if (timer1_counter0 >= 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GE	L__timer1_interrupt81
	GOTO	L_timer1_interrupt2
L__timer1_interrupt81:
;DY_GCU.c,139 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt82
	GOTO	L_timer1_interrupt3
L__timer1_interrupt82:
;DY_GCU.c,140 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,142 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,143 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,144 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,145 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt83
	GOTO	L_timer1_interrupt4
L__timer1_interrupt83:
;DY_GCU.c,146 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,147 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,148 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,151 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt84
	GOTO	L_timer1_interrupt5
L__timer1_interrupt84:
;DY_GCU.c,152 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,155 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,156 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,158 :: 		if (timer1_counter3 >= 1000) {
	MOV	_timer1_counter3, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt85
	GOTO	L_timer1_interrupt6
L__timer1_interrupt85:
;DY_GCU.c,159 :: 		if (x == 0)
	MOV	_x, W0
	CP	W0, #0
	BRA Z	L__timer1_interrupt86
	GOTO	L_timer1_interrupt7
L__timer1_interrupt86:
;DY_GCU.c,165 :: 		x = 1;
	MOV	#1, W0
	MOV	W0, _x
;DY_GCU.c,166 :: 		}
	GOTO	L_timer1_interrupt8
L_timer1_interrupt7:
;DY_GCU.c,167 :: 		else if (x == 1)
	MOV	_x, W0
	CP	W0, #1
	BRA Z	L__timer1_interrupt87
	GOTO	L_timer1_interrupt9
L__timer1_interrupt87:
;DY_GCU.c,173 :: 		x = 0;
	CLR	W0
	MOV	W0, _x
;DY_GCU.c,174 :: 		}
L_timer1_interrupt9:
L_timer1_interrupt8:
;DY_GCU.c,175 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,176 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,179 :: 		timer1_aac_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_aac_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,180 :: 		if(timer1_aac_counter == AAC_WORK_RATE_ms)
	MOV	_timer1_aac_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt88
	GOTO	L_timer1_interrupt10
L__timer1_interrupt88:
;DY_GCU.c,182 :: 		aac_execute();
	CALL	_aac_execute
;DY_GCU.c,183 :: 		timer1_aac_counter = 0;
	CLR	W0
	MOV	W0, _timer1_aac_counter
;DY_GCU.c,184 :: 		}
L_timer1_interrupt10:
;DY_GCU.c,188 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt89
	GOTO	L_timer1_interrupt11
L__timer1_interrupt89:
;DY_GCU.c,189 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,190 :: 		}
L_timer1_interrupt11:
;DY_GCU.c,193 :: 		if (timer2_sensors_counter >= 10)
	MOV	_timer2_sensors_counter, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt90
	GOTO	L_timer1_interrupt12
L__timer1_interrupt90:
;DY_GCU.c,195 :: 		sendSensorsDebug1();
	CALL	_sendSensorsDebug1
;DY_GCU.c,196 :: 		sendSensorsDebug2();
	CALL	_sendSensorsDebug2
;DY_GCU.c,197 :: 		timer2_sensors_counter = 0;
	CLR	W0
	MOV	W0, _timer2_sensors_counter
;DY_GCU.c,198 :: 		}
L_timer1_interrupt12:
;DY_GCU.c,208 :: 		}
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

;DY_GCU.c,210 :: 		onCanInterrupt{
;DY_GCU.c,215 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,216 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,218 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt92
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt92:
;DY_GCU.c,219 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,220 :: 		}
L_CAN_Interrupt13:
;DY_GCU.c,221 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt93
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt93:
;DY_GCU.c,222 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
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
;DY_GCU.c,223 :: 		}
L_CAN_Interrupt14:
;DY_GCU.c,224 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt94
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt94:
;DY_GCU.c,226 :: 		}
L_CAN_Interrupt15:
;DY_GCU.c,227 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt95
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt95:
;DY_GCU.c,229 :: 		}
L_CAN_Interrupt16:
;DY_GCU.c,231 :: 		switch (id) {
	GOTO	L_CAN_Interrupt17
;DY_GCU.c,232 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt19:
;DY_GCU.c,233 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,235 :: 		aac_updateExternValue(RPM, secondInt);
	MOV	[W14+2], W11
	CLR	W10
	CALL	_aac_updateExternValue
;DY_GCU.c,237 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,239 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt20:
;DY_GCU.c,240 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,241 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,242 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,244 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt21:
;DY_GCU.c,245 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,246 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,259 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt27:
;DY_GCU.c,261 :: 		aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_aac_updateExternValue
;DY_GCU.c,263 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,265 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt28:
;DY_GCU.c,267 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL && accelerationFb > 0)
	ADD	W14, #8, W0
	MOV.B	[W0], W0
	CP.B	W0, #30
	BRA GTU	L__CAN_Interrupt96
	GOTO	L__CAN_Interrupt69
L__CAN_Interrupt96:
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt97
	GOTO	L__CAN_Interrupt68
L__CAN_Interrupt97:
L__CAN_Interrupt64:
;DY_GCU.c,269 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt98
	GOTO	L_CAN_Interrupt32
L__CAN_Interrupt98:
;DY_GCU.c,271 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,272 :: 		}
L_CAN_Interrupt32:
;DY_GCU.c,274 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt99
	GOTO	L__CAN_Interrupt66
L__CAN_Interrupt99:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt100
	GOTO	L__CAN_Interrupt65
L__CAN_Interrupt100:
	GOTO	L__CAN_Interrupt62
L__CAN_Interrupt66:
L__CAN_Interrupt65:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt101
	GOTO	L__CAN_Interrupt67
L__CAN_Interrupt101:
	GOTO	L_CAN_Interrupt37
L__CAN_Interrupt62:
L__CAN_Interrupt67:
;DY_GCU.c,277 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,279 :: 		clutchPulled = 1;
	MOV	#lo_addr(_clutchPulled), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,280 :: 		}
L_CAN_Interrupt37:
;DY_GCU.c,267 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL && accelerationFb > 0)
L__CAN_Interrupt69:
L__CAN_Interrupt68:
;DY_GCU.c,284 :: 		if (clutchPulled == 0 && accelerationFb == 0)
	MOV	#lo_addr(_clutchPulled), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt102
	GOTO	L__CAN_Interrupt71
L__CAN_Interrupt102:
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt103
	GOTO	L__CAN_Interrupt70
L__CAN_Interrupt103:
L__CAN_Interrupt61:
;DY_GCU.c,286 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,284 :: 		if (clutchPulled == 0 && accelerationFb == 0)
L__CAN_Interrupt71:
L__CAN_Interrupt70:
;DY_GCU.c,288 :: 		clutchPulled = 0;
	MOV	#lo_addr(_clutchPulled), W1
	CLR	W0
	MOV.B	W0, [W1]
;DY_GCU.c,290 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,292 :: 		case EFI_HALL_ID:
L_CAN_Interrupt41:
;DY_GCU.c,294 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,297 :: 		case SW_ACCELERATION_GCU_ID:
L_CAN_Interrupt42:
;DY_GCU.c,299 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt104
	GOTO	L__CAN_Interrupt73
L__CAN_Interrupt104:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt105
	GOTO	L__CAN_Interrupt72
L__CAN_Interrupt105:
L__CAN_Interrupt60:
;DY_GCU.c,303 :: 		aac_currentState = START;   //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,305 :: 		}
	GOTO	L_CAN_Interrupt46
;DY_GCU.c,299 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
L__CAN_Interrupt73:
L__CAN_Interrupt72:
;DY_GCU.c,306 :: 		else if(aac_currentState == READY && firstInt == 2)
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt106
	GOTO	L__CAN_Interrupt75
L__CAN_Interrupt106:
	MOV	[W14+0], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt107
	GOTO	L__CAN_Interrupt74
L__CAN_Interrupt107:
L__CAN_Interrupt59:
;DY_GCU.c,308 :: 		aac_currentState = START_RELEASE; //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,310 :: 		}
	GOTO	L_CAN_Interrupt50
;DY_GCU.c,306 :: 		else if(aac_currentState == READY && firstInt == 2)
L__CAN_Interrupt75:
L__CAN_Interrupt74:
;DY_GCU.c,312 :: 		else if (firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt108
	GOTO	L_CAN_Interrupt51
L__CAN_Interrupt108:
;DY_GCU.c,314 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt109
	GOTO	L_CAN_Interrupt52
L__CAN_Interrupt109:
;DY_GCU.c,316 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,317 :: 		Clutch_release();
	CALL	_Clutch_release
;DY_GCU.c,318 :: 		}
L_CAN_Interrupt52:
;DY_GCU.c,319 :: 		}
L_CAN_Interrupt51:
L_CAN_Interrupt50:
L_CAN_Interrupt46:
;DY_GCU.c,320 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,324 :: 		case SW_TRACTION_CONTROL_GCU_ID:
L_CAN_Interrupt53:
;DY_GCU.c,326 :: 		tractionFb = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _tractionFb
;DY_GCU.c,328 :: 		traction_currentState = tractionFb * 100;
	MOV	#100, W3
	ADD	W14, #0, W2
	MUL.UU	W3, [W2], W0
	MOV	W0, _traction_currentState
;DY_GCU.c,329 :: 		setTraction(TRACTION_CODE, traction_currentState);
	MOV	W0, W11
	MOV	#3, W10
	CALL	_setTraction
;DY_GCU.c,332 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,336 :: 		case SW_DRS_GCU_ID:
L_CAN_Interrupt54:
;DY_GCU.c,337 :: 		if(firstInt == 1)
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt110
	GOTO	L_CAN_Interrupt55
L__CAN_Interrupt110:
;DY_GCU.c,340 :: 		Drs_open();
	CALL	_Drs_open
;DY_GCU.c,342 :: 		}
	GOTO	L_CAN_Interrupt56
L_CAN_Interrupt55:
;DY_GCU.c,343 :: 		else if(firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt111
	GOTO	L_CAN_Interrupt57
L__CAN_Interrupt111:
;DY_GCU.c,345 :: 		Drs_close();
	CALL	_Drs_close
;DY_GCU.c,348 :: 		}
L_CAN_Interrupt57:
L_CAN_Interrupt56:
;DY_GCU.c,349 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,352 :: 		default:
L_CAN_Interrupt58:
;DY_GCU.c,353 :: 		break;
	GOTO	L_CAN_Interrupt18
;DY_GCU.c,354 :: 		}
L_CAN_Interrupt17:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt112
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt112:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt113
	GOTO	L_CAN_Interrupt20
L__CAN_Interrupt113:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt114
	GOTO	L_CAN_Interrupt21
L__CAN_Interrupt114:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt115
	GOTO	L_CAN_Interrupt27
L__CAN_Interrupt115:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt116
	GOTO	L_CAN_Interrupt28
L__CAN_Interrupt116:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt117
	GOTO	L_CAN_Interrupt41
L__CAN_Interrupt117:
	MOV	#514, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt118
	GOTO	L_CAN_Interrupt42
L__CAN_Interrupt118:
	MOV	#515, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt119
	GOTO	L_CAN_Interrupt53
L__CAN_Interrupt119:
	MOV	#517, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt120
	GOTO	L_CAN_Interrupt54
L__CAN_Interrupt120:
	GOTO	L_CAN_Interrupt58
L_CAN_Interrupt18:
;DY_GCU.c,355 :: 		}
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
