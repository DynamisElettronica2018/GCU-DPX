
_GCU_isAlive:

;DY_GCU.c,44 :: 		void GCU_isAlive(void) {
;DY_GCU.c,45 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,46 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,47 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,48 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,49 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,50 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,52 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,56 :: 		void init(void) {
;DY_GCU.c,57 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,58 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,59 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,60 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,61 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,62 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,63 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,64 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,65 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,66 :: 		DRSMotor_init();
	CALL	_DrsMotor_init
;DY_GCU.c,75 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,76 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,85 :: 		}
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

;DY_GCU.c,87 :: 		void main() {
;DY_GCU.c,88 :: 		init();
	CALL	_init
;DY_GCU.c,89 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,91 :: 		while (1)
L_main0:
;DY_GCU.c,94 :: 		Delay_ms(1000);
	MOV	#102, W8
	MOV	#47563, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
;DY_GCU.c,95 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,97 :: 		}
	GOTO	L_main0
;DY_GCU.c,98 :: 		}
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

;DY_GCU.c,101 :: 		onTimer1Interrupt{
;DY_GCU.c,102 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,103 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,105 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,106 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,107 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,108 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,109 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,114 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt36
	GOTO	L_timer1_interrupt4
L__timer1_interrupt36:
;DY_GCU.c,115 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt37
	GOTO	L_timer1_interrupt5
L__timer1_interrupt37:
;DY_GCU.c,116 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,118 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,119 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,120 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,121 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt38
	GOTO	L_timer1_interrupt6
L__timer1_interrupt38:
;DY_GCU.c,122 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,123 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,124 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,127 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt39
	GOTO	L_timer1_interrupt7
L__timer1_interrupt39:
;DY_GCU.c,128 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,130 :: 		sendTempSensor();
	CALL	_sendTempSensor
;DY_GCU.c,132 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,133 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,134 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt40
	GOTO	L_timer1_interrupt8
L__timer1_interrupt40:
;DY_GCU.c,139 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,140 :: 		}
L_timer1_interrupt8:
;DY_GCU.c,150 :: 		}
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
	LNK	#18
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;DY_GCU.c,152 :: 		onCanInterrupt{
;DY_GCU.c,157 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	ADD	W14, #16, W3
	ADD	W14, #14, W2
	ADD	W14, #6, W1
	ADD	W14, #2, W0
	MOV	W3, W13
	MOV	W2, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_Can_read
;DY_GCU.c,158 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,160 :: 		if (dataLen >= 2) {
	MOV	[W14+14], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt42
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt42:
;DY_GCU.c,161 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
	ADD	W14, #6, W1
	MOV.B	[W1], W0
	ZE	W0, W0
	SL	W0, #8, W2
	ADD	W1, #1, W0
	ZE	[W0], W1
	MOV	#255, W0
	AND	W1, W0, W1
	ADD	W14, #0, W0
	IOR	W2, W1, [W0]
;DY_GCU.c,162 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,163 :: 		if (dataLen >= 4) {
	MOV	[W14+14], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt43
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt43:
;DY_GCU.c,165 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,166 :: 		if (dataLen >= 6) {
	MOV	[W14+14], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt44
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt44:
;DY_GCU.c,168 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,169 :: 		if (dataLen >= 8) {
	MOV	[W14+14], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt45
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt45:
;DY_GCU.c,171 :: 		}
L_CAN_Interrupt12:
;DY_GCU.c,174 :: 		switch (id) {
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,175 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt15:
;DY_GCU.c,176 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,177 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,179 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt16:
;DY_GCU.c,181 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,182 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,184 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,200 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt17:
;DY_GCU.c,201 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,202 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,214 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt18:
;DY_GCU.c,219 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt46
	GOTO	L__CAN_Interrupt29
L__CAN_Interrupt46:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt47
	GOTO	L__CAN_Interrupt28
L__CAN_Interrupt47:
	GOTO	L__CAN_Interrupt26
L__CAN_Interrupt29:
L__CAN_Interrupt28:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt48
	GOTO	L__CAN_Interrupt30
L__CAN_Interrupt48:
	GOTO	L_CAN_Interrupt23
L__CAN_Interrupt26:
L__CAN_Interrupt30:
;DY_GCU.c,221 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #6, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,223 :: 		}
L_CAN_Interrupt23:
;DY_GCU.c,227 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,254 :: 		case EFI_HALL_ID:
L_CAN_Interrupt24:
;DY_GCU.c,256 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,279 :: 		default:
L_CAN_Interrupt25:
;DY_GCU.c,280 :: 		break;
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,281 :: 		}
L_CAN_Interrupt13:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt49
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt49:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt50
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt50:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt51
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt51:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt52
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt52:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt53
	GOTO	L_CAN_Interrupt24
L__CAN_Interrupt53:
	GOTO	L_CAN_Interrupt25
L_CAN_Interrupt14:
;DY_GCU.c,282 :: 		}
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
