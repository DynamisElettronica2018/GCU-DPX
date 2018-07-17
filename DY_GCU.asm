
_sendUpdatesSW:

;DY_GCU.c,67 :: 		void sendUpdatesSW(void)
;DY_GCU.c,69 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,71 :: 		Can_addIntToWritePacket(tractionFb);
	MOV	_tractionFb, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,83 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,86 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,88 :: 		Can_write(GCU_DEBUG_2_ID);
	MOV	#791, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,90 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW

_sendSensors2:

;DY_GCU.c,93 :: 		void sendSensors2(void)
;DY_GCU.c,96 :: 		tempSens = getTempSensor();
	PUSH	W10
	PUSH	W11
	CALL	_getTempSensor
	MOV	W0, _tempSens
;DY_GCU.c,97 :: 		gearSens = getGearSensor();
	CALL	_getGearSensor
	MOV	W0, _gearSens
;DY_GCU.c,98 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;DY_GCU.c,99 :: 		Can_addIntToWritePacket(tempSens);
	MOV	_tempSens, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,100 :: 		Can_addIntToWritePAcket(gearSens);
	MOV	_gearSens, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,101 :: 		Can_write(GCU_DEBUG_1_ID);
	MOV	#790, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,102 :: 		}
L_end_sendSensors2:
	POP	W11
	POP	W10
	RETURN
; end of _sendSensors2

_GCU_isAlive:

;DY_GCU.c,105 :: 		void GCU_isAlive(void) {
;DY_GCU.c,106 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;DY_GCU.c,107 :: 		Can_addIntToWritePacket((unsigned int)CAN_COMMAND_GCU_IS_ALIVE);
	MOV	#99, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,108 :: 		Can_addIntToWritePacket((unsigned int)(Clutch_get() | 0 ));
	CALL	_Clutch_get
	ZE	W0, W0
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,109 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,110 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;DY_GCU.c,111 :: 		Can_write(GCU_CLUTCH_FB_SW_ID);
	MOV	#784, W10
	MOV	#0, W11
	CALL	_Can_write
;DY_GCU.c,113 :: 		}
L_end_GCU_isAlive:
	POP	W11
	POP	W10
	RETURN
; end of _GCU_isAlive

_init:

;DY_GCU.c,117 :: 		void init(void) {
;DY_GCU.c,118 :: 		EngineControl_init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_EngineControl_init
;DY_GCU.c,119 :: 		dSignalLed_init();
	CALL	_dSignalLed_init
;DY_GCU.c,120 :: 		Can_init();
	CALL	_Can_init
;DY_GCU.c,121 :: 		GearMotor_init();
	CALL	_GearMotor_init
;DY_GCU.c,122 :: 		ClutchMotor_init();
	CALL	_ClutchMotor_init
;DY_GCU.c,123 :: 		DRSMotor_init();
	CALL	_DrsMotor_init
;DY_GCU.c,124 :: 		Efi_init();
	CALL	_Efi_init
;DY_GCU.c,125 :: 		GearShift_init();
	CALL	_GearShift_init
;DY_GCU.c,126 :: 		StopLight_init();
	CALL	_StopLight_init
;DY_GCU.c,127 :: 		Buzzer_init();
	CALL	_Buzzer_init
;DY_GCU.c,128 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,134 :: 		traction_init();
	CALL	_traction_init
;DY_GCU.c,141 :: 		setTimer(TIMER1_DEVICE, 0.001);
	MOV	#4719, W11
	MOV	#14979, W12
	MOV.B	#1, W10
	CALL	_setTimer
;DY_GCU.c,142 :: 		setInterruptPriority(TIMER1_DEVICE, MEDIUM_PRIORITY);
	MOV.B	#4, W11
	MOV.B	#1, W10
	CALL	_setInterruptPriority
;DY_GCU.c,143 :: 		}
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

;DY_GCU.c,147 :: 		void main() {
;DY_GCU.c,148 :: 		init();
	CALL	_init
;DY_GCU.c,149 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,152 :: 		while (1)
L_main0:
;DY_GCU.c,156 :: 		bello += 1;
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
;DY_GCU.c,158 :: 		}
	GOTO	L_main0
;DY_GCU.c,159 :: 		}
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

;DY_GCU.c,162 :: 		onTimer1Interrupt{
;DY_GCU.c,163 :: 		clearTimer1();
	PUSH	W10
	BCLR	IFS0bits, #3
;DY_GCU.c,164 :: 		GearShift_msTick();
	CALL	_GearShift_msTick
;DY_GCU.c,166 :: 		timer1_counter0 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,167 :: 		timer1_counter1 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,168 :: 		timer1_counter2 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,169 :: 		timer1_counter3 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,170 :: 		timer1_counter4 += 1;
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
;DY_GCU.c,175 :: 		if (timer1_counter0 > 25) {
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt42
	GOTO	L_timer1_interrupt2
L__timer1_interrupt42:
;DY_GCU.c,176 :: 		if (!EngineControl_isStarting()) {
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt43
	GOTO	L_timer1_interrupt3
L__timer1_interrupt43:
;DY_GCU.c,177 :: 		EngineControl_stop();
	CALL	_EngineControl_stop
;DY_GCU.c,179 :: 		}
L_timer1_interrupt3:
;DY_GCU.c,180 :: 		timer1_counter0 = 0;
	CLR	W0
	MOV	W0, _timer1_counter0
;DY_GCU.c,181 :: 		}
L_timer1_interrupt2:
;DY_GCU.c,182 :: 		if (timer1_counter1 >= 20) {
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt44
	GOTO	L_timer1_interrupt4
L__timer1_interrupt44:
;DY_GCU.c,183 :: 		GCU_isAlive();
	CALL	_GCU_isAlive
;DY_GCU.c,184 :: 		timer1_counter1 = 0;
	CLR	W0
	MOV	W0, _timer1_counter1
;DY_GCU.c,185 :: 		}
L_timer1_interrupt4:
;DY_GCU.c,188 :: 		if (timer1_counter2 >= 1000) {
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt45
	GOTO	L_timer1_interrupt5
L__timer1_interrupt45:
;DY_GCU.c,189 :: 		dSignalLed_switch(DSIGNAL_LED_RG14);
	CLR	W10
	CALL	_dSignalLed_switch
;DY_GCU.c,201 :: 		timer1_counter2 = 0;
	CLR	W0
	MOV	W0, _timer1_counter2
;DY_GCU.c,202 :: 		}
L_timer1_interrupt5:
;DY_GCU.c,203 :: 		if (timer1_counter3 >= 10) {
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt46
	GOTO	L_timer1_interrupt6
L__timer1_interrupt46:
;DY_GCU.c,209 :: 		sendSensors2();
	CALL	_sendSensors2
;DY_GCU.c,212 :: 		timer1_counter3 = 0;
	CLR	W0
	MOV	W0, _timer1_counter3
;DY_GCU.c,214 :: 		}
L_timer1_interrupt6:
;DY_GCU.c,231 :: 		}
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

;DY_GCU.c,233 :: 		onCanInterrupt{
;DY_GCU.c,238 :: 		Can_read(&id, dataBuffer, &dataLen, &flags);
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
;DY_GCU.c,239 :: 		Can_clearInterrupt();
	CALL	_Can_clearInterrupt
;DY_GCU.c,241 :: 		if (dataLen >= 2) {
	MOV	[W14+14], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt48
	GOTO	L_CAN_Interrupt7
L__CAN_Interrupt48:
;DY_GCU.c,242 :: 		firstInt = (unsigned int) ((dataBuffer[0] << 8) | (dataBuffer[1] & 0xFF));
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
;DY_GCU.c,243 :: 		}
L_CAN_Interrupt7:
;DY_GCU.c,244 :: 		if (dataLen >= 4) {
	MOV	[W14+14], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt49
	GOTO	L_CAN_Interrupt8
L__CAN_Interrupt49:
;DY_GCU.c,246 :: 		}
L_CAN_Interrupt8:
;DY_GCU.c,247 :: 		if (dataLen >= 6) {
	MOV	[W14+14], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt50
	GOTO	L_CAN_Interrupt9
L__CAN_Interrupt50:
;DY_GCU.c,249 :: 		}
L_CAN_Interrupt9:
;DY_GCU.c,250 :: 		if (dataLen >= 8) {
	MOV	[W14+14], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt51
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt51:
;DY_GCU.c,252 :: 		}
L_CAN_Interrupt10:
;DY_GCU.c,255 :: 		switch (id) {
	GOTO	L_CAN_Interrupt11
;DY_GCU.c,256 :: 		case EFI_GEAR_RPM_TPS_APPS_ID:
L_CAN_Interrupt13:
;DY_GCU.c,257 :: 		GearShift_setCurrentGear(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_setCurrentGear
;DY_GCU.c,261 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,263 :: 		case SW_FIRE_GCU_ID:
L_CAN_Interrupt14:
;DY_GCU.c,265 :: 		EngineControl_resetStartCheck();           //resetCheckCounter = 0
	CALL	_EngineControl_resetStartCheck
;DY_GCU.c,266 :: 		EngineControl_start();                     //debug on LED D2 board
	CALL	_EngineControl_start
;DY_GCU.c,268 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,284 :: 		case SW_GEARSHIFT_ID:
L_CAN_Interrupt15:
;DY_GCU.c,292 :: 		GearShift_injectCommand(firstInt);
	MOV	[W14+0], W10
	CALL	_GearShift_injectCommand
;DY_GCU.c,293 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,296 :: 		case EFI_TRACTION_CONTROL_ID:
L_CAN_Interrupt16:
;DY_GCU.c,303 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,305 :: 		case SW_CLUTCH_TARGET_GCU_ID:
L_CAN_Interrupt17:
;DY_GCU.c,324 :: 		if ((!gearShift_isShiftingDown && !gearShift_isSettingNeutral) || gearShift_isUnsettingNeutral)
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt52
	GOTO	L__CAN_Interrupt33
L__CAN_Interrupt52:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt53
	GOTO	L__CAN_Interrupt32
L__CAN_Interrupt53:
	GOTO	L__CAN_Interrupt30
L__CAN_Interrupt33:
L__CAN_Interrupt32:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt54
	GOTO	L__CAN_Interrupt34
L__CAN_Interrupt54:
	GOTO	L_CAN_Interrupt22
L__CAN_Interrupt30:
L__CAN_Interrupt34:
;DY_GCU.c,327 :: 		Clutch_setBiased(dataBuffer[0]);
	ADD	W14, #6, W0
	MOV.B	[W0], W10
	CALL	_Clutch_setBiased
;DY_GCU.c,329 :: 		}
L_CAN_Interrupt22:
;DY_GCU.c,336 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,338 :: 		case SW_AUX_ID:
L_CAN_Interrupt23:
;DY_GCU.c,355 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,388 :: 		case EFI_HALL_ID:
L_CAN_Interrupt24:
;DY_GCU.c,390 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,392 :: 		case SW_ACCELERATION_GCU_ID:
L_CAN_Interrupt25:
;DY_GCU.c,420 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,422 :: 		case SW_AUX_ID:
L_CAN_Interrupt26:
;DY_GCU.c,446 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,448 :: 		case SW_TRACTION_CONTROL_GCU_ID:
L_CAN_Interrupt27:
;DY_GCU.c,451 :: 		tractionFb = firstInt;
	MOV	[W14+0], W0
	MOV	W0, _tractionFb
;DY_GCU.c,453 :: 		traction_currentState = tractionFb * 100;
	MOV	#100, W3
	ADD	W14, #0, W2
	MUL.UU	W3, [W2], W0
	MOV	W0, _traction_currentState
;DY_GCU.c,454 :: 		Efi_setTraction(traction_currentState);
	MOV	W0, W10
	CALL	_Efi_setTraction
;DY_GCU.c,455 :: 		sendUpdatesSW();
	CALL	_sendUpdatesSW
;DY_GCU.c,456 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
;DY_GCU.c,458 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,460 :: 		case SW_DRS_GCU_ID:
L_CAN_Interrupt28:
;DY_GCU.c,471 :: 		default:
L_CAN_Interrupt29:
;DY_GCU.c,472 :: 		break;
	GOTO	L_CAN_Interrupt12
;DY_GCU.c,473 :: 		}
L_CAN_Interrupt11:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt55
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt55:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt56
	GOTO	L_CAN_Interrupt14
L__CAN_Interrupt56:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt57
	GOTO	L_CAN_Interrupt15
L__CAN_Interrupt57:
	MOV	#774, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt58
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt58:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt59
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt59:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt60
	GOTO	L_CAN_Interrupt23
L__CAN_Interrupt60:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt61
	GOTO	L_CAN_Interrupt24
L__CAN_Interrupt61:
	MOV	#514, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt62
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt62:
	MOV	#2032, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt63
	GOTO	L_CAN_Interrupt26
L__CAN_Interrupt63:
	MOV	#515, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt64
	GOTO	L_CAN_Interrupt27
L__CAN_Interrupt64:
	MOV	#517, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt65
	GOTO	L_CAN_Interrupt28
L__CAN_Interrupt65:
	GOTO	L_CAN_Interrupt29
L_CAN_Interrupt12:
;DY_GCU.c,474 :: 		}
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
