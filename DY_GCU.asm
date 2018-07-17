
_GCU_isAlive:

;DY_GCU.c,39 :: 		void GCU_isAlive(void) {
;DY_GCU.c,40 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,41 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,42 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,43 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,44 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,45 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,46 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,48 :: 		void init(void) {
;DY_GCU.c,49 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,50 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,51 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,52 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,53 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,54 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,55 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,56 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,57 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,61 :: 		autocross_init();
	CALL	_autocross_init
;DY_GCU.c,64 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,65 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,66 :: 		}
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

;DY_GCU.c,68 :: 		void main() {
;DY_GCU.c,69 :: 		init();
	CALL	_init
;DY_GCU.c,70 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,72 :: 		while (1)
L_main0:
;DY_GCU.c,76 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,78 :: 		}
	GOTO	L_main0
;DY_GCU.c,79 :: 		}
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

;DY_GCU.c,82 :: 		onTimer1Interrupt{
;DY_GCU.c,83 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,84 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,86 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,87 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,88 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,89 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,90 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,95 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt58
	GOTO	L_timer1_interrupt2
L__timer1_interrupt58:
;DY_GCU.c,96 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt59
	GOTO	L_timer1_interrupt3
L__timer1_interrupt59:
;DY_GCU.c,97 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,99 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,100 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,101 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,102 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt60
	GOTO	L_timer1_interrupt4
L__timer1_interrupt60:
;DY_GCU.c,103 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,104 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,105 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,108 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt61
	GOTO	L_timer1_interrupt5
L__timer1_interrupt61:
;DY_GCU.c,109 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,111 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,112 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,113 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt62
	GOTO	L_timer1_interrupt6
L__timer1_interrupt62:
;DY_GCU.c,114 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,115 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,119 :: 		timer1_autocross_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_autocross_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,120 :: 		if(timer1_autocross_counter == AUTOCROSS_WORK_RATE_ms){
	MOV	_timer1_autocross_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt63
	GOTO	L_timer1_interrupt7
L__timer1_interrupt63:
;DY_GCU.c,121 :: 		autocross_execute();
	CALL	_autocross_execute
;DY_GCU.c,122 :: 		timer1_autocross_counter = 0;
	CLR	W0
	MOV	W0, _timer1_autocross_counter
;DY_GCU.c,123 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,126 :: 		}
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

;DY_GCU.c,128 :: 		onCanInterrupt{
;DY_GCU.c,133 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,134 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,136 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt65
	GOTO	L_CAN_Interrupt8
L__CAN_Interrupt65:
;DY_GCU.c,137 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,138 :: 		}
L_CAN_Interrupt8:
;DY_GCU.c,139 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt66
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt66:
;DY_GCU.c,140 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
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
;DY_GCU.c,141 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,142 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt67
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt67:
;DY_GCU.c,144 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,145 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt68
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt68:
;DY_GCU.c,147 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,150 :: 		switch (id) {
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,151 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt14:
;DY_GCU.c,152 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,153 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,155 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt15:
;DY_GCU.c,157 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,158 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,160 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,162 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt16:
;DY_GCU.c,171 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,172 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,174 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt17:
;DY_GCU.c,176 :: 		autocross_updateExternValue(WHEEL_SPEED_AUTOCROSS, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_autocross_updateExternValue
;DY_GCU.c,178 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,181 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt18:
;DY_GCU.c,183 :: 		if(dataBuffer[0] > AUTOCROSS_CLUTCH_NOISE_LEVEL && autocrossFb > 0)
	ADD	W14, #8, W0
	MOV.B	[W0], W1
	MOV.B	#40, W0
	CP.B	W1, W0
	BRA GTU	L__CAN_Interrupt69
	GOTO	L__CAN_Interrupt45
L__CAN_Interrupt69:
	MOV	_autocrossFb, W0
	CP	W0, #0
	BRA GTU	L__CAN_Interrupt70
	GOTO	L__CAN_Interrupt44
L__CAN_Interrupt70:
L__CAN_Interrupt43:
;DY_GCU.c,185 :: 		autocross_stop();
	CALL	_autocross_stop
;DY_GCU.c,183 :: 		if(dataBuffer[0] > AUTOCROSS_CLUTCH_NOISE_LEVEL && autocrossFb > 0)
L__CAN_Interrupt45:
L__CAN_Interrupt44:
;DY_GCU.c,188 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt71
	GOTO	L__CAN_Interrupt47
L__CAN_Interrupt71:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt72
	GOTO	L__CAN_Interrupt46
L__CAN_Interrupt72:
	GOTO	L__CAN_Interrupt41
L__CAN_Interrupt47:
L__CAN_Interrupt46:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt73
	GOTO	L__CAN_Interrupt48
L__CAN_Interrupt73:
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt41:
L__CAN_Interrupt48:
;DY_GCU.c,190 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,192 :: 		}
L_CAN_Interrupt26:
;DY_GCU.c,193 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,195 :: 		case SW_AUX_ID:
L_CAN_Interrupt27:
;DY_GCU.c,197 :: 		if(autocross_currentState == OFF_AUTOCROSS && secondInt == 1)
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt74
	GOTO	L__CAN_Interrupt50
L__CAN_Interrupt74:
	MOV	[W14+2], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt75
	GOTO	L__CAN_Interrupt49
L__CAN_Interrupt75:
L__CAN_Interrupt40:
;DY_GCU.c,199 :: 		autocross_currentState = START_AUTOCROSS;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,200 :: 		}
	GOTO	L_CAN_Interrupt31
;DY_GCU.c,197 :: 		if(autocross_currentState == OFF_AUTOCROSS && secondInt == 1)
L__CAN_Interrupt50:
L__CAN_Interrupt49:
;DY_GCU.c,201 :: 		else if (autocross_currentState == READY_AUTOCROSS && secondInt == 2)
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt76
	GOTO	L__CAN_Interrupt52
L__CAN_Interrupt76:
	MOV	[W14+2], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt77
	GOTO	L__CAN_Interrupt51
L__CAN_Interrupt77:
L__CAN_Interrupt39:
;DY_GCU.c,203 :: 		autocross_currentState = START_RELEASE_AUTOCROSS;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,204 :: 		}
	GOTO	L_CAN_Interrupt35
;DY_GCU.c,201 :: 		else if (autocross_currentState == READY_AUTOCROSS && secondInt == 2)
L__CAN_Interrupt52:
L__CAN_Interrupt51:
;DY_GCU.c,205 :: 		else if(secondInt == 0)
	MOV	[W14+2], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt78
	GOTO	L_CAN_Interrupt36
L__CAN_Interrupt78:
;DY_GCU.c,207 :: 		autocross_Stop();
	CALL	_autocross_stop
;DY_GCU.c,208 :: 		}
L_CAN_Interrupt36:
L_CAN_Interrupt35:
L_CAN_Interrupt31:
;DY_GCU.c,210 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,212 :: 		case EFI_HALL_ID:
L_CAN_Interrupt37:
;DY_GCU.c,214 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,216 :: 		default:
L_CAN_Interrupt38:
;DY_GCU.c,217 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,218 :: 		}
L_CAN_Interrupt12:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt79
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt79:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt80
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt80:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt81
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt81:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt82
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt82:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt83
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt83:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt84
	GOTO	L_CAN_Interrupt27
L__CAN_Interrupt84:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt85
	GOTO	L_CAN_Interrupt37
L__CAN_Interrupt85:
	GOTO	L_CAN_Interrupt38
L_CAN_Interrupt13:
;DY_GCU.c,219 :: 		}
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
