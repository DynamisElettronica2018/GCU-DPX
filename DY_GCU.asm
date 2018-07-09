
_sendUpdatesSW:

;DY_GCU.c,64 :: 		void sendUpdatesSW(void)
;DY_GCU.c,66 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,68 :: 		Can_addIntToWritePacket(tractionFb);
	MOV	_tractionFb, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,71 :: 		Can_addIntToWritePacket(accelerationFb);
	MOV	_accelerationFb, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,79 :: 		Can_write(GCU_AUX_ID);
	MOV	#2033, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,81 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW

_GCU_isAlive:

;DY_GCU.c,83 :: 		void GCU_isAlive(void) {
;DY_GCU.c,84 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,85 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,86 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,87 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,88 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,89 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,91 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,95 :: 		void init(void) {
;DY_GCU.c,96 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,97 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,98 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,99 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,100 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,101 :: 		DRSMotor_init();
	CALL	_DrsMotor_init
;DY_GCU.c,102 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,103 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,104 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,105 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,106 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,112 :: 		aac_init();
	CALL	_aac_init
;DY_GCU.c,117 :: 		traction_init();
	CALL	_traction_init
;DY_GCU.c,126 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,127 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,128 :: 		}
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

;DY_GCU.c,132 :: 		void main() {
;DY_GCU.c,133 :: 		init();
	CALL	_init
;DY_GCU.c,134 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,136 :: 		while (1)
L_main0:
;DY_GCU.c,140 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,142 :: 		}
	GOTO	L_main0
;DY_GCU.c,143 :: 		}
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

;DY_GCU.c,146 :: 		onTimer1Interrupt{
;DY_GCU.c,147 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,148 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,150 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,151 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,152 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,153 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,154 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,159 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt58
	GOTO	L_timer1_interrupt2
L__timer1_interrupt58:
;DY_GCU.c,160 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt59
	GOTO	L_timer1_interrupt3
L__timer1_interrupt59:
;DY_GCU.c,161 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,163 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,164 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,165 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,166 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt60
	GOTO	L_timer1_interrupt4
L__timer1_interrupt60:
;DY_GCU.c,167 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,168 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,169 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,172 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt61
	GOTO	L_timer1_interrupt5
L__timer1_interrupt61:
;DY_GCU.c,173 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,175 :: 		sendTempSensor();
	CALL	_sendTempSensor
;DY_GCU.c,186 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,187 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,188 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt62
	GOTO	L_timer1_interrupt6
L__timer1_interrupt62:
;DY_GCU.c,191 :: 		aac_sendTimes();
	CALL	_aac_sendTimes
;DY_GCU.c,193 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,194 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,197 :: 		timer1_aac_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_aac_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,198 :: 		if(timer1_aac_counter == AAC_WORK_RATE_ms){
	MOV	_timer1_aac_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt63
	GOTO	L_timer1_interrupt7
L__timer1_interrupt63:
;DY_GCU.c,199 :: 		aac_execute();
	CALL	_aac_execute
;DY_GCU.c,200 :: 		timer1_aac_counter = 0;
	CLR	W0
	MOV	W0, _timer1_aac_counter
;DY_GCU.c,201 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,211 :: 		}
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

;DY_GCU.c,213 :: 		onCanInterrupt{
;DY_GCU.c,218 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,219 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,221 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt65
	GOTO	L_CAN_Interrupt8
L__CAN_Interrupt65:
;DY_GCU.c,222 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,223 :: 		}
L_CAN_Interrupt8:
;DY_GCU.c,224 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt66
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt66:
;DY_GCU.c,225 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
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
;DY_GCU.c,226 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,227 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt67
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt67:
;DY_GCU.c,229 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,230 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt68
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt68:
;DY_GCU.c,232 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,235 :: 		switch (id) {
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,236 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt14:
;DY_GCU.c,237 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,239 :: 		aac_updateExternValue(RPM, secondInt);
	MOV	[W14+2], W11
	CLR	W10
	CALL	_aac_updateExternValue
;DY_GCU.c,241 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,243 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt15:
;DY_GCU.c,245 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,246 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,248 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,264 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt16:
;DY_GCU.c,265 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,266 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,269 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt17:
;DY_GCU.c,271 :: 		aac_updateExternValue(WHEEL_SPEED, firstInt / 10);
	MOV	[W14+0], W0
	MOV	#10, W2
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, W11
	MOV.B	#1, W10
	CALL	_aac_updateExternValue
;DY_GCU.c,276 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,278 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt18:
;DY_GCU.c,280 :: 		if(dataBuffer[0] > AAC_CLUTCH_NOISE_LEVEL)
	ADD	W14, #8, W0
	MOV.B	[W0], W1
	MOV.B	#40, W0
	CP.B	W1, W0
	BRA GTU	L__CAN_Interrupt69
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt69:
;DY_GCU.c,282 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,289 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt70
	GOTO	L__CAN_Interrupt46
L__CAN_Interrupt70:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt71
	GOTO	L__CAN_Interrupt45
L__CAN_Interrupt71:
	GOTO	L__CAN_Interrupt43
L__CAN_Interrupt46:
L__CAN_Interrupt45:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt72
	GOTO	L__CAN_Interrupt47
L__CAN_Interrupt72:
	GOTO	L_CAN_Interrupt24
L__CAN_Interrupt43:
L__CAN_Interrupt47:
;DY_GCU.c,291 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,293 :: 		}
L_CAN_Interrupt24:
;DY_GCU.c,295 :: 		}
L_CAN_Interrupt19:
;DY_GCU.c,300 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,302 :: 		case SW_AUX_ID:
L_CAN_Interrupt25:
;DY_GCU.c,315 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,348 :: 		case EFI_HALL_ID:
L_CAN_Interrupt26:
;DY_GCU.c,350 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,352 :: 		case SW_ACCELERATION_GCU_ID:
L_CAN_Interrupt27:
;DY_GCU.c,355 :: 		if(aac_currentState == OFF && firstInt == 1                                 //FOR TESTING
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt73
	GOTO	L__CAN_Interrupt49
L__CAN_Interrupt73:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt74
	GOTO	L__CAN_Interrupt48
L__CAN_Interrupt74:
;DY_GCU.c,358 :: 		)
L__CAN_Interrupt42:
;DY_GCU.c,360 :: 		aac_currentState = START;   //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,361 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,362 :: 		}
	GOTO	L_CAN_Interrupt31
;DY_GCU.c,355 :: 		if(aac_currentState == OFF && firstInt == 1                                 //FOR TESTING
L__CAN_Interrupt49:
L__CAN_Interrupt48:
;DY_GCU.c,363 :: 		else if(aac_currentState == READY && firstInt == 2){
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt75
	GOTO	L__CAN_Interrupt51
L__CAN_Interrupt75:
	MOV	[W14+0], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt76
	GOTO	L__CAN_Interrupt50
L__CAN_Interrupt76:
L__CAN_Interrupt41:
;DY_GCU.c,364 :: 		aac_currentState = START_RELEASE; //comment to disable AAC
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,365 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,366 :: 		}
	GOTO	L_CAN_Interrupt35
;DY_GCU.c,363 :: 		else if(aac_currentState == READY && firstInt == 2){
L__CAN_Interrupt51:
L__CAN_Interrupt50:
;DY_GCU.c,368 :: 		else if(firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt77
	GOTO	L_CAN_Interrupt36
L__CAN_Interrupt77:
;DY_GCU.c,370 :: 		aac_stop();
	CALL	_aac_stop
;DY_GCU.c,371 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,372 :: 		}
L_CAN_Interrupt36:
L_CAN_Interrupt35:
L_CAN_Interrupt31:
;DY_GCU.c,374 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,376 :: 		case SW_AUX_ID:
L_CAN_Interrupt37:
;DY_GCU.c,395 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,397 :: 		case SW_TRACTION_CONTROL_GCU_ID:
L_CAN_Interrupt38:
;DY_GCU.c,400 :: 		tractionFb = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _tractionFb
;DY_GCU.c,402 :: 		traction_currentState = tractionFb * 100;
	MOV	#100, W3
	ADD	W14, #0, W2
	MUL.UU	W3, [W2], W0
	MOV	W0, _traction_currentState
;DY_GCU.c,403 :: 		Efi_setTraction(traction_currentState);
	MOV	W0, W10
	CALL	_Efi_setTraction
;DY_GCU.c,404 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,405 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,407 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,409 :: 		case SW_DRS_GCU_ID:
L_CAN_Interrupt39:
;DY_GCU.c,420 :: 		default:
L_CAN_Interrupt40:
;DY_GCU.c,421 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,422 :: 		}
L_CAN_Interrupt12:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt78
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt78:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt79
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt79:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt80
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt80:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt81
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt81:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt82
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt82:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt83
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt83:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt84
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt84:
	MOV	#514, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt85
	GOTO	L_CAN_Interrupt27
L__CAN_Interrupt85:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt86
	GOTO	L_CAN_Interrupt37
L__CAN_Interrupt86:
	MOV	#515, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt87
	GOTO	L_CAN_Interrupt38
L__CAN_Interrupt87:
	MOV	#517, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt88
	GOTO	L_CAN_Interrupt39
L__CAN_Interrupt88:
	GOTO	L_CAN_Interrupt40
L_CAN_Interrupt13:
;DY_GCU.c,423 :: 		}
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
