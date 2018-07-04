
_GCU_isAlive:

	CALL	_Can_resetWritePacket
	MOV	#99, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	CALL	_Clutch_get
	ZE	W0, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	CLR	W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	CLR	W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#784, W0
	MOV	#0, W1
	PUSH.D	W0
	CALL	_Can_write
	SUB	#4, W15
L_end_GCU_isAlive:
	RETURN
; end of _GCU_isAlive

_init:

	CALL	_dSignalLed_init
	CALL	_Can_init
	CALL	_EngineControl_init
	CALL	_GearMotor_init
	CALL	_ClutchMotor_init
	CALL	_Efi_init
	CALL	_GearShift_init
	CALL	_StopLight_init
	CALL	_Buzzer_init
	MOV	#4719, W0
	MOV	#14979, W1
	PUSH.D	W0
	MOV	#1, W0
	PUSH	W0
	CALL	_setTimer
	SUB	#6, W15
	MOV	#4, W0
	PUSH	W0
	MOV	#1, W0
	PUSH	W0
	CALL	_setInterruptPriority
	SUB	#4, W15
L_end_init:
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

	CALL	_init
	CALL	_Buzzer_Bip
L_main0:
	MOV	#102, W8
	MOV	#47563, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
	MOV.B	#1, W1
	MOV	#lo_addr(_bello), W0
	ADD.B	W1, [W0], [W0]
	GOTO	L_main0
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

	BCLR	IFS0bits, #3
	CALL	_GearShift_msTick
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter0), W0
	ADD	W1, [W0], [W0]
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter1), W0
	ADD	W1, [W0], [W0]
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter2), W0
	ADD	W1, [W0], [W0]
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter3), W0
	ADD	W1, [W0], [W0]
	MOV	#1, W1
	MOV	#lo_addr(_timer1_counter4), W0
	ADD	W1, [W0], [W0]
	MOV	_timer1_counter0, W0
	CP	W0, #25
	BRA GT	L__timer1_interrupt34
	GOTO	L_timer1_interrupt4
L__timer1_interrupt34:
	CALL	_EngineControl_isStarting
	CP0.B	W0
	BRA Z	L__timer1_interrupt35
	GOTO	L_timer1_interrupt5
L__timer1_interrupt35:
	CALL	_EngineControl_stop
L_timer1_interrupt5:
	CLR	W0
	MOV	W0, _timer1_counter0
L_timer1_interrupt4:
	MOV	_timer1_counter1, W0
	CP	W0, #20
	BRA GE	L__timer1_interrupt36
	GOTO	L_timer1_interrupt6
L__timer1_interrupt36:
	CALL	_GCU_isAlive
	CLR	W0
	MOV	W0, _timer1_counter1
L_timer1_interrupt6:
	MOV	_timer1_counter2, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA GE	L__timer1_interrupt37
	GOTO	L_timer1_interrupt7
L__timer1_interrupt37:
	CLR	W0
	PUSH	W0
	CALL	_dSignalLed_switch
	SUB	#2, W15
	CALL	_sendTempSensor
	CLR	W0
	MOV	W0, _timer1_counter2
L_timer1_interrupt7:
	MOV	_timer1_counter3, W0
	CP	W0, #10
	BRA GE	L__timer1_interrupt38
	GOTO	L_timer1_interrupt8
L__timer1_interrupt38:
	CLR	W0
	MOV	W0, _timer1_counter3
L_timer1_interrupt8:
	MOV	#100, W1
	MOV	#lo_addr(_timer1_counter4), W0
	CP	W1, [W0]
	BRA LE	L__timer1_interrupt39
	GOTO	L_timer1_interrupt9
L__timer1_interrupt39:
	CALL	_Can_resetWritePacket
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#790, W0
	MOV	#0, W1
	PUSH.D	W0
	CALL	_Can_write
	SUB	#4, W15
	CALL	_Can_resetWritePacket
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#20, W0
	PUSH	W0
	CALL	_Can_addIntToWritePacket
	SUB	#2, W15
	MOV	#791, W0
	MOV	#0, W1
	PUSH.D	W0
	CALL	_Can_write
	SUB	#4, W15
	CLR	W0
	MOV	W0, _timer1_counter4
L_timer1_interrupt9:
L_end_timer1_interrupt:
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

	ADD	W14, #16, W0
	PUSH	W0
	ADD	W14, #14, W0
	PUSH	W0
	ADD	W14, #6, W0
	PUSH	W0
	ADD	W14, #2, W0
	PUSH	W0
	CALL	_Can_read
	SUB	#8, W15
	CALL	_Can_clearInterrupt
	MOV	[W14+14], W0
	CP	W0, #2
	BRA GEU	L__CAN_Interrupt41
	GOTO	L_CAN_Interrupt10
L__CAN_Interrupt41:
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
L_CAN_Interrupt10:
	MOV	[W14+14], W0
	CP	W0, #4
	BRA GEU	L__CAN_Interrupt42
	GOTO	L_CAN_Interrupt11
L__CAN_Interrupt42:
L_CAN_Interrupt11:
	MOV	[W14+14], W0
	CP	W0, #6
	BRA GEU	L__CAN_Interrupt43
	GOTO	L_CAN_Interrupt12
L__CAN_Interrupt43:
L_CAN_Interrupt12:
	MOV	[W14+14], W0
	CP	W0, #8
	BRA GEU	L__CAN_Interrupt44
	GOTO	L_CAN_Interrupt13
L__CAN_Interrupt44:
L_CAN_Interrupt13:
	GOTO	L_CAN_Interrupt14
L_CAN_Interrupt16:
	ADD	W14, #0, W0
	PUSH	[W0]
	CALL	_GearShift_setCurrentGear
	SUB	#2, W15
	GOTO	L_CAN_Interrupt15
L_CAN_Interrupt17:
	CALL	_EngineControl_resetStartCheck
	CALL	_EngineControl_start
	CALL	_Buzzer_Bip
	GOTO	L_CAN_Interrupt15
L_CAN_Interrupt18:
	ADD	W14, #0, W0
	PUSH	[W0]
	CALL	_GearShift_injectCommand
	SUB	#2, W15
	GOTO	L_CAN_Interrupt15
L_CAN_Interrupt19:
	MOV	#lo_addr(_gearShift_isShiftingDown), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt45
	GOTO	L__CAN_Interrupt28
L__CAN_Interrupt45:
	MOV	#lo_addr(_gearShift_isSettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt46
	GOTO	L__CAN_Interrupt28
L__CAN_Interrupt46:
	GOTO	L__CAN_Interrupt27
L__CAN_Interrupt28:
	MOV	#lo_addr(_gearShift_isUnsettingNeutral), W0
	CP0.B	[W0]
	BRA Z	L__CAN_Interrupt47
	GOTO	L__CAN_Interrupt27
L__CAN_Interrupt47:
	GOTO	L_CAN_Interrupt24
L__CAN_Interrupt27:
	ADD	W14, #6, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	PUSH	W0
	CALL	_Clutch_setBiased
	SUB	#2, W15
L_CAN_Interrupt24:
	GOTO	L_CAN_Interrupt15
L_CAN_Interrupt25:
	GOTO	L_CAN_Interrupt15
L_CAN_Interrupt26:
	GOTO	L_CAN_Interrupt15
L_CAN_Interrupt14:
	MOV	#773, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt48
	GOTO	L_CAN_Interrupt16
L__CAN_Interrupt48:
	MOV	#516, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt49
	GOTO	L_CAN_Interrupt17
L__CAN_Interrupt49:
	MOV	#512, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt50
	GOTO	L_CAN_Interrupt18
L__CAN_Interrupt50:
	MOV	#513, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt51
	GOTO	L_CAN_Interrupt19
L__CAN_Interrupt51:
	MOV	#772, W1
	MOV	#0, W2
	ADD	W14, #2, W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__CAN_Interrupt52
	GOTO	L_CAN_Interrupt25
L__CAN_Interrupt52:
	GOTO	L_CAN_Interrupt26
L_CAN_Interrupt15:
L_end_CAN_Interrupt:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	ULNK
	RETFIE
; end of _CAN_Interrupt
