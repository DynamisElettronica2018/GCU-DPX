
_GCU_isAlive:

;DY_GCU.c,53 :: 		void GCU_isAlive(void) {
;DY_GCU.c,54 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,55 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,56 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,57 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,58 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,59 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,61 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,65 :: 		void init(void) {
;DY_GCU.c,66 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,67 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,68 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,69 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,70 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,71 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,72 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,73 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,74 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,85 :: 		autocross_init();
	CALL	_autocross_init
;DY_GCU.c,89 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,90 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,99 :: 		}
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

;DY_GCU.c,101 :: 		void main() {
;DY_GCU.c,102 :: 		init();
	CALL	_init
;DY_GCU.c,103 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,105 :: 		while (1)
L_main0:
;DY_GCU.c,109 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,111 :: 		}
	GOTO	L_main0
;DY_GCU.c,112 :: 		}
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

;DY_GCU.c,115 :: 		onTimer1Interrupt{
;DY_GCU.c,116 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,117 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,119 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,120 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,121 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,122 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,123 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,128 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt50
	GOTO	L_timer1_interrupt2
L__timer1_interrupt50:
;DY_GCU.c,129 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt51
	GOTO	L_timer1_interrupt3
L__timer1_interrupt51:
;DY_GCU.c,130 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,132 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,133 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,134 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,135 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt52
	GOTO	L_timer1_interrupt4
L__timer1_interrupt52:
;DY_GCU.c,136 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,137 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,138 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,141 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt53
	GOTO	L_timer1_interrupt5
L__timer1_interrupt53:
;DY_GCU.c,142 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,144 :: 		sendTempSensor();
	CALL	_sendTempSensor
;DY_GCU.c,146 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,147 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,148 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt54
	GOTO	L_timer1_interrupt6
L__timer1_interrupt54:
;DY_GCU.c,153 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,154 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,165 :: 		timer1_autocross_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_autocross_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,166 :: 		if(timer1_autocross_counter == AUTOCROSS_WORK_RATE_ms){
	MOV	_timer1_autocross_counter, W0
	CP	W0, #25
	BRA Z	L__timer1_interrupt55
	GOTO	L_timer1_interrupt7
L__timer1_interrupt55:
;DY_GCU.c,167 :: 		autocross_execute();
	CALL	_autocross_execute
;DY_GCU.c,168 :: 		timer1_autocross_counter = 0;
	CLR	W0
	MOV	W0, _timer1_autocross_counter
;DY_GCU.c,169 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,171 :: 		}
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

;DY_GCU.c,173 :: 		onCanInterrupt{
;DY_GCU.c,178 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,179 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,181 :: 		if (dataLen >= 2) {
	MOV	[W14+16], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt57
	GOTO	L_CAN_Interrupt8
L__CAN_Interrupt57:
;DY_GCU.c,182 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,183 :: 		}
L_CAN_Interrupt8:
;DY_GCU.c,184 :: 		if (dataLen >= 4) {
	MOV	[W14+16], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt58
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt58:
;DY_GCU.c,185 :: 		secondInt = (unsigned int) ((dataBuffer[2] << 8) | (dataBuffer[3] & 0xFF));
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
;DY_GCU.c,186 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,187 :: 		if (dataLen >= 6) {
	MOV	[W14+16], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt59
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt59:
;DY_GCU.c,189 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,190 :: 		if (dataLen >= 8) {
	MOV	[W14+16], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt60
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt60:
;DY_GCU.c,192 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,195 :: 		switch (id) {
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,196 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt14:
;DY_GCU.c,197 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,198 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,200 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt15:
;DY_GCU.c,202 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,203 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,205 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,221 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt16:
;DY_GCU.c,222 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,223 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,235 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt17:
;DY_GCU.c,240 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt61
	GOTO	L__CAN_Interrupt39
L__CAN_Interrupt61:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt62
	GOTO	L__CAN_Interrupt38
L__CAN_Interrupt62:
	GOTO	L__CAN_Interrupt36
L__CAN_Interrupt39:
L__CAN_Interrupt38:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt63
	GOTO	L__CAN_Interrupt40
L__CAN_Interrupt63:
	GOTO	L_CAN_Interrupt22
L__CAN_Interrupt36:
L__CAN_Interrupt40:
;DY_GCU.c,242 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #8, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,244 :: 		}
L_CAN_Interrupt22:
;DY_GCU.c,248 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,250 :: 		case SW_AUX_ID:
L_CAN_Interrupt23:
;DY_GCU.c,252 :: 		if(autocross_currentState == OFF && secondInt == 1)
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__CAN_Interrupt64
	GOTO	L__CAN_Interrupt42
L__CAN_Interrupt64:
	MOV	[W14+2], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt65
	GOTO	L__CAN_Interrupt41
L__CAN_Interrupt65:
L__CAN_Interrupt35:
;DY_GCU.c,254 :: 		autocross_currentState = START;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;DY_GCU.c,255 :: 		}
	GOTO	L_CAN_Interrupt27
;DY_GCU.c,252 :: 		if(autocross_currentState == OFF && secondInt == 1)
L__CAN_Interrupt42:
L__CAN_Interrupt41:
;DY_GCU.c,256 :: 		else if (autocross_currentState == READY && secondInt == 2)
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__CAN_Interrupt66
	GOTO	L__CAN_Interrupt44
L__CAN_Interrupt66:
	MOV	[W14+2], W0
	CP	W0, #2
	BRA Z	L__CAN_Interrupt67
	GOTO	L__CAN_Interrupt43
L__CAN_Interrupt67:
L__CAN_Interrupt34:
;DY_GCU.c,258 :: 		autocross_currentState = START_RELEASE;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;DY_GCU.c,259 :: 		}
	GOTO	L_CAN_Interrupt31
;DY_GCU.c,256 :: 		else if (autocross_currentState == READY && secondInt == 2)
L__CAN_Interrupt44:
L__CAN_Interrupt43:
;DY_GCU.c,261 :: 		autocross_Stop();
	CALL	_autocross_stop
L_CAN_Interrupt31:
L_CAN_Interrupt27:
;DY_GCU.c,263 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,290 :: 		case EFI_HALL_ID:
L_CAN_Interrupt32:
;DY_GCU.c,292 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,315 :: 		default:
L_CAN_Interrupt33:
;DY_GCU.c,316 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,317 :: 		}
L_CAN_Interrupt12:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt68
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt68:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt69
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt69:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt70
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt70:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt71
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt71:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt72
	GOTO	L_CAN_Interrupt23
L__CAN_Interrupt72:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #4, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt73
	GOTO	L_CAN_Interrupt32
L__CAN_Interrupt73:
	GOTO	L_CAN_Interrupt33
L_CAN_Interrupt13:
;DY_GCU.c,318 :: 		}
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
