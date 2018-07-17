
_GCU_isAlive:

;DY_GCU.c,48 :: 		void GCU_isAlive(void) {
;DY_GCU.c,49 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,50 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,51 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,52 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,53 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,54 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,55 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,57 :: 		void init(void) {
;DY_GCU.c,58 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,59 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,60 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,61 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,62 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,63 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,64 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,65 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,66 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,70 :: 		aac_init();
	CALL	_aac_init
;DY_GCU.c,73 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,74 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,76 :: 		}
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

;DY_GCU.c,79 :: 		void main() {
;DY_GCU.c,80 :: 		init();
	CALL	_init
;DY_GCU.c,81 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,83 :: 		while (1)
L_main0:
;DY_GCU.c,87 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,89 :: 		}
	GOTO	L_main0
;DY_GCU.c,90 :: 		}
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

;DY_GCU.c,93 :: 		onTimer1Interrupt{
;DY_GCU.c,94 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,95 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,96 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,97 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,98 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,99 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,100 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,105 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt66
	GOTO	L_timer1_interrupt2
L__timer1_interrupt66:
;DY_GCU.c,106 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt67
	GOTO	L_timer1_interrupt3
L__timer1_interrupt67:
;DY_GCU.c,107 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,109 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,110 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,111 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,112 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt68
	GOTO	L_timer1_interrupt4
L__timer1_interrupt68:
;DY_GCU.c,113 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,114 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,115 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,118 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt69
	GOTO	L_timer1_interrupt5
L__timer1_interrupt69:
;DY_GCU.c,119 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,122 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,123 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,124 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt70
	GOTO	L_timer1_interrupt6
L__timer1_interrupt70:
;DY_GCU.c,129 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,130 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,133 :: 		timer1_aac_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_aac_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,134 :: 		if(timer1_aac_counter == AAC_WORK_RATE_ms){
	MOV	_timer1_aac_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt71
	GOTO	L_timer1_interrupt7
L__timer1_interrupt71:
;DY_GCU.c,135 :: 		aac_execute();
	CALL	_aac_execute
;DY_GCU.c,136 :: 		timer1_aac_counter = 0;
	CLR	W0
	MOV	W0, _timer1_aac_counter
;DY_GCU.c,137 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,140 :: 		}
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

;DY_GCU.c,142 :: 		onCanInterrupt{
;DY_GCU.c,147 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,148 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,150 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt73
	GOTO	L_CAN_Interrupt8
L__CAN_Interrupt73:
;DY_GCU.c,151 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,152 :: 		}
L_CAN_Interrupt8:
;DY_GCU.c,153 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt74
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt74:
;DY_GCU.c,154 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
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
;DY_GCU.c,155 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,156 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt75
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt75:
;DY_GCU.c,158 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,159 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt76
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt76:
;DY_GCU.c,161 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,163 :: 		switch (id) {
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,164 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt14:
;DY_GCU.c,165 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,167 :: 		aac_updateExternValue(RPM, secondInt);
	MOV	[W14+2], W11
	CLR	W10
	CALL	_aac_updateExternValue
;DY_GCU.c,169 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,171 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt15:
;DY_GCU.c,172 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,173 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,174 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,176 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt16:
;DY_GCU.c,178 :: 		if (Clutch_get() != 100
	CALL	_Clutch_get
;DY_GCU.c,181 :: 		|| firstInt == GEAR_COMMAND_DOWN)
	MOV.B	#100, W1
	CP.B	W0, W1
	BRA NZ	L__CAN_Interrupt77
	GOTO	L__CAN_Interrupt53
L__CAN_Interrupt77:
;DY_GCU.c,180 :: 		|| firstInt == GEAR_COMMAND_NEUTRAL_UP
	MOV	#100, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA NZ	L__CAN_Interrupt78
	GOTO	L__CAN_Interrupt51
L__CAN_Interrupt78:
	MOV	#50, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA NZ	L__CAN_Interrupt79
	GOTO	L__CAN_Interrupt50
L__CAN_Interrupt79:
;DY_GCU.c,181 :: 		|| firstInt == GEAR_COMMAND_DOWN)
	MOV	#200, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA NZ	L__CAN_Interrupt80
	GOTO	L__CAN_Interrupt49
L__CAN_Interrupt80:
	GOTO	L_CAN_Interrupt21
;DY_GCU.c,180 :: 		|| firstInt == GEAR_COMMAND_NEUTRAL_UP
L__CAN_Interrupt51:
L__CAN_Interrupt50:
;DY_GCU.c,181 :: 		|| firstInt == GEAR_COMMAND_DOWN)
L__CAN_Interrupt49:
;DY_GCU.c,182 :: 		&& accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt81
	GOTO	L__CAN_Interrupt52
L__CAN_Interrupt81:
L__CAN_Interrupt47:
;DY_GCU.c,183 :: 		aac_stop();
	CALL	_aac_stop
L_CAN_Interrupt21:
;DY_GCU.c,181 :: 		|| firstInt == GEAR_COMMAND_DOWN)
L__CAN_Interrupt53:
;DY_GCU.c,182 :: 		&& accelerationFb > 0)
L__CAN_Interrupt52:
;DY_GCU.c,185 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,186 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,188 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt22:
;DY_GCU.c,190 :: 		aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_aac_updateExternValue
;DY_GCU.c,192 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,204 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt23:
;DY_GCU.c,206 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL)
	ADD	W14, #8, W0
	MOV.B	[W0], W1
	MOV.B	#40, W0
	CP.B	W1, W0
	BRA GTU	L__CAN_Interrupt82
	GOTO	L_CAN_Interrupt24
L__CAN_Interrupt82:
;DY_GCU.c,208 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt83
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt83:
;DY_GCU.c,210 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,211 :: 		}
L_CAN_Interrupt25:
;DY_GCU.c,214 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt84
	GOTO	L__CAN_Interrupt55
L__CAN_Interrupt84:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt85
	GOTO	L__CAN_Interrupt54
L__CAN_Interrupt85:
	GOTO	L__CAN_Interrupt45
L__CAN_Interrupt55:
L__CAN_Interrupt54:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt86
	GOTO	L__CAN_Interrupt56
L__CAN_Interrupt86:
	GOTO	L_CAN_Interrupt30
L__CAN_Interrupt45:
L__CAN_Interrupt56:
;DY_GCU.c,217 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,219 :: 		}
L_CAN_Interrupt30:
;DY_GCU.c,221 :: 		}
L_CAN_Interrupt24:
;DY_GCU.c,223 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,225 :: 		case EFI_HALL_ID:
L_CAN_Interrupt31:
;DY_GCU.c,227 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,230 :: 		case SW_ACCELERATION_GCU_ID:
L_CAN_Interrupt32:
;DY_GCU.c,233 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt87
	GOTO	L__CAN_Interrupt58
L__CAN_Interrupt87:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt88
	GOTO	L__CAN_Interrupt57
L__CAN_Interrupt88:
L__CAN_Interrupt44:
;DY_GCU.c,237 :: 		aac_currentState = START;   //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,238 :: 		Buzzer_bip(); //for testing
	CALL	_Buzzer_Bip
;DY_GCU.c,239 :: 		}
	GOTO	L_CAN_Interrupt36
;DY_GCU.c,233 :: 		if(aac_currentState == OFF && firstInt == 1)                                 //FOR TESTING
L__CAN_Interrupt58:
L__CAN_Interrupt57:
;DY_GCU.c,240 :: 		else if(aac_currentState == READY && firstInt == 2)
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt89
	GOTO	L__CAN_Interrupt60
L__CAN_Interrupt89:
	MOV	[W14+0], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt90
	GOTO	L__CAN_Interrupt59
L__CAN_Interrupt90:
L__CAN_Interrupt43:
;DY_GCU.c,242 :: 		aac_currentState = START_RELEASE; //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,243 :: 		Buzzer_bip(); //for testing
	CALL	_Buzzer_Bip
;DY_GCU.c,244 :: 		}
	GOTO	L_CAN_Interrupt40
;DY_GCU.c,240 :: 		else if(aac_currentState == READY && firstInt == 2)
L__CAN_Interrupt60:
L__CAN_Interrupt59:
;DY_GCU.c,248 :: 		if (accelerationFb > 0)
	MOV	_accelerationFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt91
	GOTO	L_CAN_Interrupt41
L__CAN_Interrupt91:
;DY_GCU.c,249 :: 		aac_stop();
	CALL	_aac_stop
L_CAN_Interrupt41:
;DY_GCU.c,250 :: 		}
L_CAN_Interrupt40:
L_CAN_Interrupt36:
;DY_GCU.c,252 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,253 :: 		default:
L_CAN_Interrupt42:
;DY_GCU.c,254 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,255 :: 		}
L_CAN_Interrupt12:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt92
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt92:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt93
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt93:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt94
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt94:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt95
	GOTO	L_CAN_Interrupt22
L__CAN_Interrupt95:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt96
	GOTO	L_CAN_Interrupt23
L__CAN_Interrupt96:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt97
	GOTO	L_CAN_Interrupt31
L__CAN_Interrupt97:
	MOV	#514, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt98
	GOTO	L_CAN_Interrupt32
L__CAN_Interrupt98:
	GOTO	L_CAN_Interrupt42
L_CAN_Interrupt13:
;DY_GCU.c,256 :: 		}
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
