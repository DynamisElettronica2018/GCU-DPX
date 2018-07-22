
_GCU_isAlive:

;DY_GCU.c,61 :: 		void GCU_isAlive(void) {
;DY_GCU.c,62 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,63 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,64 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,65 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,66 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,67 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,68 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,70 :: 		void init(void) {
;DY_GCU.c,71 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,72 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,73 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,74 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,75 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,76 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,77 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,78 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,79 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,82 :: 		traction_init();
	CALL	_traction_init
;DY_GCU.c,86 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,87 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,90 :: 		aac_init();
	CALL	_aac_init
;DY_GCU.c,93 :: 		DRSMotor_init();
	CALL	_DrsMotor_init
;DY_GCU.c,94 :: 		Drs_close();
	CALL	_Drs_close
;DY_GCU.c,97 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,98 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,100 :: 		}
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

;DY_GCU.c,103 :: 		void main() {
;DY_GCU.c,104 :: 		init();
	CALL	_init
;DY_GCU.c,105 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,107 :: 		while (1)
L_main0:
;DY_GCU.c,111 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,113 :: 		}
	GOTO	L_main0
;DY_GCU.c,114 :: 		}
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

;DY_GCU.c,117 :: 		onTimer1Interrupt{
;DY_GCU.c,118 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,119 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,120 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,121 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,122 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,123 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,124 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,129 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt79
	GOTO	L_timer1_interrupt2
L__timer1_interrupt79:
;DY_GCU.c,130 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt80
	GOTO	L_timer1_interrupt3
L__timer1_interrupt80:
;DY_GCU.c,131 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,133 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,134 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,135 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,136 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt81
	GOTO	L_timer1_interrupt4
L__timer1_interrupt81:
;DY_GCU.c,137 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,138 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,139 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,142 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt82
	GOTO	L_timer1_interrupt5
L__timer1_interrupt82:
;DY_GCU.c,143 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,146 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,147 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,148 :: 		if (timer1_counter3 >= 1000) {
	MOV	_timer1_counter3, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt83
	GOTO	L_timer1_interrupt6
L__timer1_interrupt83:
;DY_GCU.c,149 :: 		if (x == 0)
	MOV	_x, W0
	CP	W0, #0
	BRA Z	L__timer1_interrupt84
	GOTO	L_timer1_interrupt7
L__timer1_interrupt84:
;DY_GCU.c,155 :: 		x = 1;
	MOV	#1, W0
	MOV	W0, _x
;DY_GCU.c,156 :: 		}
	GOTO	L_timer1_interrupt8
L_timer1_interrupt7:
;DY_GCU.c,157 :: 		else if (x == 1)
	MOV	_x, W0
	CP	W0, #1
	BRA Z	L__timer1_interrupt85
	GOTO	L_timer1_interrupt9
L__timer1_interrupt85:
;DY_GCU.c,163 :: 		x = 0;
	CLR	W0
	MOV	W0, _x
;DY_GCU.c,164 :: 		}
L_timer1_interrupt9:
L_timer1_interrupt8:
;DY_GCU.c,165 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,166 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,169 :: 		timer1_aac_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_aac_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,170 :: 		if(timer1_aac_counter == AAC_WORK_RATE_ms)
	MOV	_timer1_aac_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt86
	GOTO	L_timer1_interrupt10
L__timer1_interrupt86:
;DY_GCU.c,172 :: 		aac_execute();
	CALL	_aac_execute
;DY_GCU.c,173 :: 		timer1_aac_counter = 0;
	CLR	W0
	MOV	W0, _timer1_aac_counter
;DY_GCU.c,174 :: 		}
L_timer1_interrupt10:
;DY_GCU.c,176 :: 		}
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

;DY_GCU.c,178 :: 		onCanInterrupt{
;DY_GCU.c,183 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,184 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,186 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt88
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt88:
;DY_GCU.c,187 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,188 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,189 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt89
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt89:
;DY_GCU.c,190 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
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
;DY_GCU.c,191 :: 		}
L_CAN_Interrupt12:
;DY_GCU.c,192 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt90
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt90:
;DY_GCU.c,194 :: 		}
L_CAN_Interrupt13:
;DY_GCU.c,195 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt91
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt91:
;DY_GCU.c,197 :: 		}
L_CAN_Interrupt14:
;DY_GCU.c,199 :: 		switch (id) {
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,200 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt17:
;DY_GCU.c,201 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,203 :: 		aac_updateExternValue(RPM, secondInt);
	MOV	[W14+2], W11
	CLR	W10
	CALL	_aac_updateExternValue
;DY_GCU.c,205 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,207 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt18:
;DY_GCU.c,208 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,209 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,210 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,212 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt19:
;DY_GCU.c,213 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,214 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,227 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt25:
;DY_GCU.c,229 :: 		aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_aac_updateExternValue
;DY_GCU.c,231 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,233 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt26:
;DY_GCU.c,235 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL && accelerationFb > 0)
	ADD	W14, #8, W0
	MOV.B	[W0], W0
	CP.B	W0, #30
	BRA GTU	L__CAN_Interrupt92
	GOTO	L__CAN_Interrupt67
L__CAN_Interrupt92:
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt93
	GOTO	L__CAN_Interrupt66
L__CAN_Interrupt93:
L__CAN_Interrupt62:
;DY_GCU.c,237 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt94
	GOTO	L_CAN_Interrupt30
L__CAN_Interrupt94:
;DY_GCU.c,239 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,240 :: 		}
L_CAN_Interrupt30:
;DY_GCU.c,242 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt95
	GOTO	L__CAN_Interrupt64
L__CAN_Interrupt95:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt96
	GOTO	L__CAN_Interrupt63
L__CAN_Interrupt96:
	GOTO	L__CAN_Interrupt60
L__CAN_Interrupt64:
L__CAN_Interrupt63:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt97
	GOTO	L__CAN_Interrupt65
L__CAN_Interrupt97:
	GOTO	L_CAN_Interrupt35
L__CAN_Interrupt60:
L__CAN_Interrupt65:
;DY_GCU.c,245 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,247 :: 		clutchPulled = 1;
	MOV	#lo_addr(_clutchPulled), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,248 :: 		}
L_CAN_Interrupt35:
;DY_GCU.c,235 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL && accelerationFb > 0)
L__CAN_Interrupt67:
L__CAN_Interrupt66:
;DY_GCU.c,252 :: 		if (clutchPulled == 0 && accelerationFb == 0)
	MOV	#lo_addr(_clutchPulled), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt98
	GOTO	L__CAN_Interrupt69
L__CAN_Interrupt98:
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt99
	GOTO	L__CAN_Interrupt68
L__CAN_Interrupt99:
L__CAN_Interrupt59:
;DY_GCU.c,254 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,252 :: 		if (clutchPulled == 0 && accelerationFb == 0)
L__CAN_Interrupt69:
L__CAN_Interrupt68:
;DY_GCU.c,256 :: 		clutchPulled = 0;
	MOV	#lo_addr(_clutchPulled), W1
	CLR	W0
	MOV.B	W0, [W1]
;DY_GCU.c,258 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,260 :: 		case EFI_HALL_ID:
L_CAN_Interrupt39:
;DY_GCU.c,262 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,264 :: 		case SW_ACCELERATION_GCU_ID:
L_CAN_Interrupt40:
;DY_GCU.c,267 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt100
	GOTO	L__CAN_Interrupt71
L__CAN_Interrupt100:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt101
	GOTO	L__CAN_Interrupt70
L__CAN_Interrupt101:
L__CAN_Interrupt58:
;DY_GCU.c,271 :: 		aac_currentState = START;   //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,273 :: 		}
	GOTO	L_CAN_Interrupt44
;DY_GCU.c,267 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
L__CAN_Interrupt71:
L__CAN_Interrupt70:
;DY_GCU.c,274 :: 		else if(aac_currentState == READY && firstInt == 2)
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt102
	GOTO	L__CAN_Interrupt73
L__CAN_Interrupt102:
	MOV	[W14+0], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt103
	GOTO	L__CAN_Interrupt72
L__CAN_Interrupt103:
L__CAN_Interrupt57:
;DY_GCU.c,276 :: 		aac_currentState = START_RELEASE; //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,278 :: 		}
	GOTO	L_CAN_Interrupt48
;DY_GCU.c,274 :: 		else if(aac_currentState == READY && firstInt == 2)
L__CAN_Interrupt73:
L__CAN_Interrupt72:
;DY_GCU.c,280 :: 		else if (firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt104
	GOTO	L_CAN_Interrupt49
L__CAN_Interrupt104:
;DY_GCU.c,282 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt105
	GOTO	L_CAN_Interrupt50
L__CAN_Interrupt105:
;DY_GCU.c,284 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,285 :: 		Clutch_release();
	CALL	_Clutch_release
;DY_GCU.c,286 :: 		}
L_CAN_Interrupt50:
;DY_GCU.c,288 :: 		}
L_CAN_Interrupt49:
L_CAN_Interrupt48:
L_CAN_Interrupt44:
;DY_GCU.c,291 :: 		case SW_TRACTION_CONTROL_GCU_ID:
L_CAN_Interrupt51:
;DY_GCU.c,293 :: 		tractionFb = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _tractionFb
;DY_GCU.c,295 :: 		traction_currentState = tractionFb * 100;
	MOV	#100, W3
	ADD	W14, #0, W2
	MUL.UU	W3, [W2], W0
	MOV	W0, _traction_currentState
;DY_GCU.c,296 :: 		setTraction(TRACTION_CODE, traction_currentState);
	MOV	W0, W11
	MOV	#3, W10
	CALL	_setTraction
;DY_GCU.c,299 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,303 :: 		case SW_DRS_GCU_ID:
L_CAN_Interrupt52:
;DY_GCU.c,304 :: 		if(firstInt == 1)
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt106
	GOTO	L_CAN_Interrupt53
L__CAN_Interrupt106:
;DY_GCU.c,306 :: 		Drs_open();
	CALL	_Drs_open
;DY_GCU.c,308 :: 		}
	GOTO	L_CAN_Interrupt54
L_CAN_Interrupt53:
;DY_GCU.c,309 :: 		else if(firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt107
	GOTO	L_CAN_Interrupt55
L__CAN_Interrupt107:
;DY_GCU.c,311 :: 		Drs_close();
	CALL	_Drs_close
;DY_GCU.c,313 :: 		}
L_CAN_Interrupt55:
L_CAN_Interrupt54:
;DY_GCU.c,314 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,317 :: 		default:
L_CAN_Interrupt56:
;DY_GCU.c,318 :: 		break;
	GOTO	L_CAN_Interrupt16
;DY_GCU.c,319 :: 		}
L_CAN_Interrupt15:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt108
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt108:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt109
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt109:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt110
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt110:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt111
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt111:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt112
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt112:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt113
	GOTO	L_CAN_Interrupt39
L__CAN_Interrupt113:
	MOV	#514, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt114
	GOTO	L_CAN_Interrupt40
L__CAN_Interrupt114:
	MOV	#515, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt115
	GOTO	L_CAN_Interrupt51
L__CAN_Interrupt115:
	MOV	#517, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt116
	GOTO	L_CAN_Interrupt52
L__CAN_Interrupt116:
	GOTO	L_CAN_Interrupt56
L_CAN_Interrupt16:
;DY_GCU.c,320 :: 		}
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
