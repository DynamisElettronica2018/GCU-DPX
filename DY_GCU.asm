
_sendUpdatesSW:

;DY_GCU.c,58 :: 		void sendUpdatesSW(void)
;DY_GCU.c,60 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,61 :: 		Can_addIntToWritePacket(tractionFb);
	MOV	_tractionFb, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,62 :: 		Can_addIntToWritePacket(accelerationFb);
	MOV	_accelerationFb, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,63 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,64 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,65 :: 		Can_write(GCU_AUX_ID);
	MOV	#2033, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,67 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW

_GCU_isAlive:

;DY_GCU.c,69 :: 		void GCU_isAlive(void) {
;DY_GCU.c,70 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,71 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,72 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,73 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,74 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,75 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,77 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,81 :: 		void init(void) {
;DY_GCU.c,82 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,83 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,84 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,85 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,86 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,87 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,88 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,89 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,90 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,91 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,97 :: 		aac_init();
	CALL	_aac_init
;DY_GCU.c,102 :: 		traction_init();
	CALL	_traction_init
;DY_GCU.c,107 :: 		autocross_init();
	CALL	_autocross_init
;DY_GCU.c,111 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,112 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,113 :: 		}
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

;DY_GCU.c,117 :: 		void main() {
;DY_GCU.c,118 :: 		init();
	CALL	_init
;DY_GCU.c,119 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,121 :: 		while (1)
L_main0:
;DY_GCU.c,125 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,127 :: 		}
	GOTO	L_main0
;DY_GCU.c,128 :: 		}
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

;DY_GCU.c,131 :: 		onTimer1Interrupt{
;DY_GCU.c,132 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,133 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,135 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,136 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,137 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,138 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,139 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,144 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt73
	GOTO	L_timer1_interrupt2
L__timer1_interrupt73:
;DY_GCU.c,145 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt74
	GOTO	L_timer1_interrupt3
L__timer1_interrupt74:
;DY_GCU.c,146 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,148 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,149 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,150 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,151 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt75
	GOTO	L_timer1_interrupt4
L__timer1_interrupt75:
;DY_GCU.c,152 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,153 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,154 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,157 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt76
	GOTO	L_timer1_interrupt5
L__timer1_interrupt76:
;DY_GCU.c,158 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,160 :: 		sendTempSensor();
	CALL	_sendTempSensor
;DY_GCU.c,171 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,172 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,173 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt77
	GOTO	L_timer1_interrupt6
L__timer1_interrupt77:
;DY_GCU.c,176 :: 		aac_sendTimes();
	CALL	_aac_sendTimes
;DY_GCU.c,178 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,179 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,182 :: 		timer1_aac_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_aac_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,183 :: 		if(timer1_aac_counter == AAC_WORK_RATE_ms){
	MOV	_timer1_aac_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt78
	GOTO	L_timer1_interrupt7
L__timer1_interrupt78:
;DY_GCU.c,184 :: 		aac_execute();
	CALL	_aac_execute
;DY_GCU.c,185 :: 		timer1_aac_counter = 0;
	CLR	W0
	MOV	W0, _timer1_aac_counter
;DY_GCU.c,186 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,190 :: 		timer1_autocross_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_autocross_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,191 :: 		if(timer1_autocross_counter == AUTOCROSS_WORK_RATE_ms){
	MOV	_timer1_autocross_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt79
	GOTO	L_timer1_interrupt8
L__timer1_interrupt79:
;DY_GCU.c,192 :: 		autocross_execute();
	CALL	_autocross_execute
;DY_GCU.c,193 :: 		timer1_autocross_counter = 0;
	CLR	W0
	MOV	W0, _timer1_autocross_counter
;DY_GCU.c,194 :: 		}
L_timer1_interrupt8:
;DY_GCU.c,196 :: 		}
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

;DY_GCU.c,198 :: 		onCanInterrupt{
;DY_GCU.c,203 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,204 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,206 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt81
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt81:
;DY_GCU.c,207 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,208 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,209 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt82
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt82:
;DY_GCU.c,210 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
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
;DY_GCU.c,211 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,212 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt83
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt83:
;DY_GCU.c,214 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,215 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt84
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt84:
;DY_GCU.c,217 :: 		}
L_CAN_Interrupt12:
;DY_GCU.c,220 :: 		switch (id) {
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,221 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt15:
;DY_GCU.c,222 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,224 :: 		aac_updateExternValue(RPM, secondInt);
	MOV	[W14+2], W11
	CLR	W10
	CALL	_aac_updateExternValue
;DY_GCU.c,226 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,228 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt16:
;DY_GCU.c,230 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,231 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,233 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,249 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt17:
;DY_GCU.c,250 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,251 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,254 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt18:
;DY_GCU.c,256 :: 		aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_aac_updateExternValue
;DY_GCU.c,259 :: 		autocross_updateExternValue(WHEEL_SPEED, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_autocross_updateExternValue
;DY_GCU.c,261 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,263 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt19:
;DY_GCU.c,265 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL)
	ADD	W14, #8, W0
	MOV.B	[W0], W0
	CP.B	W0, #10
	BRA GTU	L__CAN_Interrupt85
	GOTO	L_CAN_Interrupt20
L__CAN_Interrupt85:
;DY_GCU.c,267 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,270 :: 		if(dataBuffer[0] > AUTOCROSS_CLUTCH_NOISE_LEVEL)
	ADD	W14, #8, W0
	MOV.B	[W0], W0
	CP.B	W0, #10
	BRA GTU	L__CAN_Interrupt86
	GOTO	L_CAN_Interrupt21
L__CAN_Interrupt86:
;DY_GCU.c,272 :: 		autocross_stop();
	CALL	_autocross_stop
;DY_GCU.c,274 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt87
	GOTO	L__CAN_Interrupt57
L__CAN_Interrupt87:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt88
	GOTO	L__CAN_Interrupt56
L__CAN_Interrupt88:
	GOTO	L__CAN_Interrupt54
L__CAN_Interrupt57:
L__CAN_Interrupt56:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt89
	GOTO	L__CAN_Interrupt58
L__CAN_Interrupt89:
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt54:
L__CAN_Interrupt58:
;DY_GCU.c,276 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,278 :: 		}
L_CAN_Interrupt26:
;DY_GCU.c,280 :: 		}
L_CAN_Interrupt21:
;DY_GCU.c,283 :: 		}
L_CAN_Interrupt20:
;DY_GCU.c,285 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,287 :: 		case SW_AUX_ID:
L_CAN_Interrupt27:
;DY_GCU.c,289 :: 		if(autocross_currentState == OFF && secondInt == 1)
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt90
	GOTO	L__CAN_Interrupt60
L__CAN_Interrupt90:
	MOV	[W14+2], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt91
	GOTO	L__CAN_Interrupt59
L__CAN_Interrupt91:
L__CAN_Interrupt53:
;DY_GCU.c,291 :: 		autocross_currentState = START;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,292 :: 		}
	GOTO	L_CAN_Interrupt31
;DY_GCU.c,289 :: 		if(autocross_currentState == OFF && secondInt == 1)
L__CAN_Interrupt60:
L__CAN_Interrupt59:
;DY_GCU.c,293 :: 		else if (autocross_currentState == READY && secondInt == 2)
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt92
	GOTO	L__CAN_Interrupt62
L__CAN_Interrupt92:
	MOV	[W14+2], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt93
	GOTO	L__CAN_Interrupt61
L__CAN_Interrupt93:
L__CAN_Interrupt52:
;DY_GCU.c,295 :: 		autocross_currentState = START_RELEASE;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,296 :: 		}
	GOTO	L_CAN_Interrupt35
;DY_GCU.c,293 :: 		else if (autocross_currentState == READY && secondInt == 2)
L__CAN_Interrupt62:
L__CAN_Interrupt61:
;DY_GCU.c,298 :: 		autocross_Stop();
	CALL	_autocross_stop
L_CAN_Interrupt35:
L_CAN_Interrupt31:
;DY_GCU.c,300 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,333 :: 		case EFI_HALL_ID:
L_CAN_Interrupt36:
;DY_GCU.c,335 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,337 :: 		case SW_ACCELERATION_GCU_ID:
L_CAN_Interrupt37:
;DY_GCU.c,340 :: 		if(aac_currentState == OFF && firstInt == 1                                 //FOR TESTING
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt94
	GOTO	L__CAN_Interrupt64
L__CAN_Interrupt94:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt95
	GOTO	L__CAN_Interrupt63
L__CAN_Interrupt95:
;DY_GCU.c,343 :: 		)
L__CAN_Interrupt51:
;DY_GCU.c,345 :: 		aac_currentState = START;   //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,346 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,347 :: 		}
	GOTO	L_CAN_Interrupt41
;DY_GCU.c,340 :: 		if(aac_currentState == OFF && firstInt == 1                                 //FOR TESTING
L__CAN_Interrupt64:
L__CAN_Interrupt63:
;DY_GCU.c,348 :: 		else if(aac_currentState == READY && firstInt == 2){
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt96
	GOTO	L__CAN_Interrupt66
L__CAN_Interrupt96:
	MOV	[W14+0], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt97
	GOTO	L__CAN_Interrupt65
L__CAN_Interrupt97:
L__CAN_Interrupt50:
;DY_GCU.c,349 :: 		aac_currentState = START_RELEASE; //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,350 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,351 :: 		}
	GOTO	L_CAN_Interrupt45
;DY_GCU.c,348 :: 		else if(aac_currentState == READY && firstInt == 2){
L__CAN_Interrupt66:
L__CAN_Interrupt65:
;DY_GCU.c,353 :: 		else if(firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt98
	GOTO	L_CAN_Interrupt46
L__CAN_Interrupt98:
;DY_GCU.c,355 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,356 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,357 :: 		}
L_CAN_Interrupt46:
L_CAN_Interrupt45:
L_CAN_Interrupt41:
;DY_GCU.c,359 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,361 :: 		case SW_AUX_ID:
L_CAN_Interrupt47:
;DY_GCU.c,380 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,382 :: 		case SW_TRACTION_CONTROL_GCU_ID:
L_CAN_Interrupt48:
;DY_GCU.c,385 :: 		tractionFb = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _tractionFb
;DY_GCU.c,387 :: 		traction_currentState = tractionFb * 100;
	MOV	#100, W3
	ADD	W14, #0, W2
	MUL.UU	W3, [W2], W0
	MOV	W0, _traction_currentState
;DY_GCU.c,388 :: 		Efi_setTraction(traction_currentState);
	MOV	W0, W10
	CALL	_Efi_setTraction
;DY_GCU.c,389 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,390 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,392 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,395 :: 		default:
L_CAN_Interrupt49:
;DY_GCU.c,396 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,397 :: 		}
L_CAN_Interrupt13:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt99
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt99:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt100
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt100:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt101
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt101:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt102
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt102:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt103
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt103:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt104
	GOTO	L_CAN_Interrupt27
L__CAN_Interrupt104:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt105
	GOTO	L_CAN_Interrupt36
L__CAN_Interrupt105:
	MOV	#514, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt106
	GOTO	L_CAN_Interrupt37
L__CAN_Interrupt106:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt107
	GOTO	L_CAN_Interrupt47
L__CAN_Interrupt107:
	MOV	#515, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt108
	GOTO	L_CAN_Interrupt48
L__CAN_Interrupt108:
	GOTO	L_CAN_Interrupt49
L_CAN_Interrupt14:
;DY_GCU.c,398 :: 		}
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
