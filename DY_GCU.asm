
_GCU_isAlive:

;DY_GCU.c,33 :: 		void GCU_isAlive(void) {
;DY_GCU.c,34 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,35 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,36 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,37 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,38 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,39 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,41 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,45 :: 		void init(void) {
;DY_GCU.c,46 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,47 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,48 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,49 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,50 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,51 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,52 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,53 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,54 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,56 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,57 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,58 :: 		}
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

;DY_GCU.c,60 :: 		void main() {
;DY_GCU.c,61 :: 		init();
	CALL	_init
;DY_GCU.c,62 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,64 :: 		while (1)
L_main0:
;DY_GCU.c,68 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,70 :: 		}
	GOTO	L_main0
;DY_GCU.c,71 :: 		}
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

;DY_GCU.c,74 :: 		onTimer1Interrupt{
;DY_GCU.c,75 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,76 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,78 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,79 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,80 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,81 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,82 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,84 :: 		timer2_sensors_counter += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer2_sensors_counter), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,91 :: 		if (timer1_counter0 >= 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GE	L__timer1_interrupt35
	GOTO	L_timer1_interrupt2
L__timer1_interrupt35:
;DY_GCU.c,92 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt36
	GOTO	L_timer1_interrupt3
L__timer1_interrupt36:
;DY_GCU.c,93 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,95 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,96 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,97 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,98 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt37
	GOTO	L_timer1_interrupt4
L__timer1_interrupt37:
;DY_GCU.c,99 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,100 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,101 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,104 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt38
	GOTO	L_timer1_interrupt5
L__timer1_interrupt38:
;DY_GCU.c,105 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,107 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,108 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,110 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt39
	GOTO	L_timer1_interrupt6
L__timer1_interrupt39:
;DY_GCU.c,111 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,112 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,115 :: 		if (timer2_sensors_counter >= 10)
	MOV	_timer2_sensors_counter, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt40
	GOTO	L_timer1_interrupt7
L__timer1_interrupt40:
;DY_GCU.c,117 :: 		sendSensorsDebug1();
	CALL	_sendSensorsDebug1
;DY_GCU.c,118 :: 		sendSensorsDebug2();
	CALL	_sendSensorsDebug2
;DY_GCU.c,119 :: 		timer2_sensors_counter = 0;
	CLR	W0
	MOV	W0, _timer2_sensors_counter
;DY_GCU.c,120 :: 		}
L_timer1_interrupt7:
;DY_GCU.c,129 :: 		}
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

;DY_GCU.c,131 :: 		onCanInterrupt{
;DY_GCU.c,136 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,137 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,139 :: 		if (dataLen >= 2) {
	MOV	[W14+14], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt42
	GOTO	L_CAN_Interrupt8
L__CAN_Interrupt42:
;DY_GCU.c,140 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,141 :: 		}
L_CAN_Interrupt8:
;DY_GCU.c,142 :: 		if (dataLen >= 4) {
	MOV	[W14+14], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt43
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt43:
;DY_GCU.c,144 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,145 :: 		if (dataLen >= 6) {
	MOV	[W14+14], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt44
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt44:
;DY_GCU.c,147 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,148 :: 		if (dataLen >= 8) {
	MOV	[W14+14], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt45
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt45:
;DY_GCU.c,150 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,153 :: 		switch (id) {
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,154 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt14:
;DY_GCU.c,155 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,156 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,158 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt15:
;DY_GCU.c,160 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,161 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,163 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,165 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt16:
;DY_GCU.c,166 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,167 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,170 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt17:
;DY_GCU.c,172 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt46
	GOTO	L__CAN_Interrupt28
L__CAN_Interrupt46:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt47
	GOTO	L__CAN_Interrupt27
L__CAN_Interrupt47:
	GOTO	L__CAN_Interrupt25
L__CAN_Interrupt28:
L__CAN_Interrupt27:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt48
	GOTO	L__CAN_Interrupt29
L__CAN_Interrupt48:
	GOTO	L_CAN_Interrupt22
L__CAN_Interrupt25:
L__CAN_Interrupt29:
;DY_GCU.c,174 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #6, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,176 :: 		}
L_CAN_Interrupt22:
;DY_GCU.c,177 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,179 :: 		case EFI_HALL_ID:
L_CAN_Interrupt23:
;DY_GCU.c,181 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,183 :: 		default:
L_CAN_Interrupt24:
;DY_GCU.c,184 :: 		break;
	GOTO	L_CAN_Interrupt13
;DY_GCU.c,185 :: 		}
L_CAN_Interrupt12:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt49
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt49:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt50
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt50:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt51
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt51:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt52
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt52:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt53
	GOTO	L_CAN_Interrupt23
L__CAN_Interrupt53:
	GOTO	L_CAN_Interrupt24
L_CAN_Interrupt13:
;DY_GCU.c,186 :: 		}
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
