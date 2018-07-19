
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
;DY_GCU.c,55 :: 		DRSMotor_init();
	CALL	_DrsMotor_init
;DY_GCU.c,57 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,58 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,59 :: 		}
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

;DY_GCU.c,61 :: 		void main() {
;DY_GCU.c,62 :: 		init();
	CALL	_init
;DY_GCU.c,63 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,65 :: 		while (1)
L_main0:
;DY_GCU.c,69 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,71 :: 		}
	GOTO	L_main0
;DY_GCU.c,72 :: 		}
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

;DY_GCU.c,75 :: 		onTimer1Interrupt{
;DY_GCU.c,76 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,77 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,79 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,80 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,81 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,82 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,83 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,88 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt41
	GOTO	L_timer1_interrupt2
L__timer1_interrupt41:
;DY_GCU.c,89 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt42
	GOTO	L_timer1_interrupt3
L__timer1_interrupt42:
;DY_GCU.c,90 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,92 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,93 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,94 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,95 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt43
	GOTO	L_timer1_interrupt4
L__timer1_interrupt43:
;DY_GCU.c,96 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,97 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,98 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,101 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt44
	GOTO	L_timer1_interrupt5
L__timer1_interrupt44:
;DY_GCU.c,102 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,104 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,105 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,106 :: 		if (timer1_counter3 >= 1000) {
	MOV	_timer1_counter3, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt45
	GOTO	L_timer1_interrupt6
L__timer1_interrupt45:
;DY_GCU.c,107 :: 		if (x == 0)
	MOV	_x, W0
	CP	W0, #0
	BRA Z	L__timer1_interrupt46
	GOTO	L_timer1_interrupt7
L__timer1_interrupt46:
;DY_GCU.c,113 :: 		x = 1;
	MOV	#1, W0
	MOV	W0, _x
;DY_GCU.c,114 :: 		}
	GOTO	L_timer1_interrupt8
L_timer1_interrupt7:
;DY_GCU.c,115 :: 		else if (x == 1)
	MOV	_x, W0
	CP	W0, #1
	BRA Z	L__timer1_interrupt47
	GOTO	L_timer1_interrupt9
L__timer1_interrupt47:
;DY_GCU.c,121 :: 		x = 0;
	CLR	W0
	MOV	W0, _x
;DY_GCU.c,122 :: 		}
L_timer1_interrupt9:
L_timer1_interrupt8:
;DY_GCU.c,123 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,124 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,127 :: 		}
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

;DY_GCU.c,129 :: 		onCanInterrupt{
;DY_GCU.c,134 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,135 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,137 :: 		if (dataLen >= 2) {
	MOV	[W14+14], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt49
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt49:
;DY_GCU.c,138 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,139 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,140 :: 		if (dataLen >= 4) {
	MOV	[W14+14], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt50
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt50:
;DY_GCU.c,142 :: 		}
L_CAN_Interrupt11:
;DY_GCU.c,143 :: 		if (dataLen >= 6) {
	MOV	[W14+14], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt51
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt51:
;DY_GCU.c,145 :: 		}
L_CAN_Interrupt12:
;DY_GCU.c,146 :: 		if (dataLen >= 8) {
	MOV	[W14+14], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt52
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt52:
;DY_GCU.c,148 :: 		}
L_CAN_Interrupt13:
;DY_GCU.c,151 :: 		switch (id) {
	GOTO	L_CAN_Interrupt14
;DY_GCU.c,152 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt16:
;DY_GCU.c,153 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,154 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,156 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt17:
;DY_GCU.c,158 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,159 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,161 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,163 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt18:
;DY_GCU.c,164 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,165 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,168 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt19:
;DY_GCU.c,170 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral) {
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt53
	GOTO	L__CAN_Interrupt34
L__CAN_Interrupt53:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt54
	GOTO	L__CAN_Interrupt33
L__CAN_Interrupt54:
	GOTO	L__CAN_Interrupt31
L__CAN_Interrupt34:
L__CAN_Interrupt33:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt55
	GOTO	L__CAN_Interrupt35
L__CAN_Interrupt55:
	GOTO	L_CAN_Interrupt24
L__CAN_Interrupt31:
L__CAN_Interrupt35:
;DY_GCU.c,172 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #6, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,174 :: 		}
L_CAN_Interrupt24:
;DY_GCU.c,175 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,177 :: 		case EFI_HALL_ID:
L_CAN_Interrupt25:
;DY_GCU.c,179 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,181 :: 		case SW_DRS_GCU_ID:
L_CAN_Interrupt26:
;DY_GCU.c,183 :: 		if(firstInt == 1)
	MOV	[W14+0], W0
	CP	W0, #1
	BRA Z	L__CAN_Interrupt56
	GOTO	L_CAN_Interrupt27
L__CAN_Interrupt56:
;DY_GCU.c,185 :: 		Drs_open();
	CALL	_Drs_open
;DY_GCU.c,186 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,187 :: 		}
	GOTO	L_CAN_Interrupt28
L_CAN_Interrupt27:
;DY_GCU.c,188 :: 		else if(firstInt == 0)
	MOV	[W14+0], W0
	CP	W0, #0
	BRA Z	L__CAN_Interrupt57
	GOTO	L_CAN_Interrupt29
L__CAN_Interrupt57:
;DY_GCU.c,190 :: 		Drs_close();
	CALL	_Drs_close
;DY_GCU.c,191 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,192 :: 		}
L_CAN_Interrupt29:
L_CAN_Interrupt28:
;DY_GCU.c,195 :: 		default:
L_CAN_Interrupt30:
;DY_GCU.c,196 :: 		break;
	GOTO	L_CAN_Interrupt15
;DY_GCU.c,197 :: 		}
L_CAN_Interrupt14:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt58
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt58:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt59
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt59:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt60
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt60:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt61
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt61:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt62
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt62:
	MOV	#517, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt63
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt63:
	GOTO	L_CAN_Interrupt30
L_CAN_Interrupt15:
;DY_GCU.c,198 :: 		}
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
