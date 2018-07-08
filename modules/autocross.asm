
_autocross_init:

;autocross.c,18 :: 		void autocross_init(void){
;autocross.c,19 :: 		autocross_currentState = OFF;
	MOV	#lo_addr(_autocross_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;autocross.c,20 :: 		autocross_loadDefaultParams();
	CALL	_autocross_loadDefaultParams
;autocross.c,21 :: 		}
L_end_autocross_init:
	RETURN
; end of _autocross_init

_autocross_execute:
	LNK	#8

;autocross.c,23 :: 		void autocross_execute(void){
;autocross.c,24 :: 		switch (autocross_currentState) {
	PUSH	W10
	PUSH	W11
	PUSH	W12
	GOTO	L_autocross_execute0
;autocross.c,25 :: 		case START:
L_autocross_execute2:
;autocross.c,26 :: 		Efi_setRPMLimiter();
	CALL	_Efi_setRPMLimiter
;autocross.c,28 :: 		Can_writeByte(SW_AUX_ID, MEX_READY);
	MOV.B	#1, W12
	MOV	#2032, W10
	MOV	#0, W11
	CALL	_Can_writeByte
;autocross.c,29 :: 		autocross_currentState = READY;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;autocross.c,30 :: 		autocross_clutchValue = 100;
	MOV	#0, W0
	MOV	#17096, W1
	MOV	W0, _autocross_clutchValue
	MOV	W1, _autocross_clutchValue+2
;autocross.c,31 :: 		Clutch_set((unsigned int)autocross_clutchValue);
	MOV	#0, W0
	MOV	#17096, W1
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;autocross.c,32 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,33 :: 		case READY:
L_autocross_execute3:
;autocross.c,34 :: 		Clutch_set(100);
	MOV.B	#100, W10
	CALL	_Clutch_set
;autocross.c,35 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,36 :: 		case START_RELEASE:
L_autocross_execute4:
;autocross.c,37 :: 		autocross_clutchValue = autocross_parameters[RAMP_START];
	MOV	_autocross_parameters, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _autocross_clutchValue
	MOV	W1, _autocross_clutchValue+2
;autocross.c,38 :: 		Clutch_set(autocross_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;autocross.c,39 :: 		autocross_dtRelease = autocross_parameters[RAMP_TIME] / AUTOCROSS_WORK_RATE_ms;
	MOV	_autocross_parameters+4, W0
	MOV	#25, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _autocross_dtRelease
;autocross.c,40 :: 		autocross_clutchStep = ((float)(autocross_parameters[RAMP_START] - autocross_parameters[RAMP_END]) * AUTOCROSS_WORK_RATE_ms) / (float)autocross_parameters[RAMP_TIME];
	MOV	_autocross_parameters, W1
	MOV	#lo_addr(_autocross_parameters+2), W0
	SUB	W1, [W0], W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16840, W3
	CALL	__Mul_FP
	MOV	W0, [W14+4]
	MOV	W1, [W14+6]
	MOV	_autocross_parameters+4, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	[W14+4], W0
	MOV	[W14+6], W1
	PUSH.D	W2
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Div_FP
	POP.D	W2
	MOV	W0, _autocross_clutchStep
	MOV	W1, _autocross_clutchStep+2
;autocross.c,41 :: 		autocross_currentState = RELEASING;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;autocross.c,42 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,43 :: 		case RELEASING:
L_autocross_execute5:
;autocross.c,45 :: 		autocross_clutchValue = autocross_clutchValue - autocross_clutchStep;
	MOV	_autocross_clutchValue, W0
	MOV	_autocross_clutchValue+2, W1
	MOV	_autocross_clutchStep, W2
	MOV	_autocross_clutchStep+2, W3
	CALL	__Sub_FP
	MOV	W0, _autocross_clutchValue
	MOV	W1, _autocross_clutchValue+2
;autocross.c,46 :: 		Clutch_set((unsigned char)autocross_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;autocross.c,47 :: 		autocross_dtRelease--;
	MOV	#1, W1
	MOV	#lo_addr(_autocross_dtRelease), W0
	SUBR	W1, [W0], [W0]
;autocross.c,48 :: 		if(autocross_dtRelease <= 0 || Clutch_get() <= autocross_parameters[RAMP_END]){
	MOV	_autocross_dtRelease, W0
	CP	W0, #0
	BRA GT	L__autocross_execute38
	GOTO	L__autocross_execute30
L__autocross_execute38:
	CALL	_Clutch_get
	ZE	W0, W1
	MOV	#lo_addr(_autocross_parameters+2), W0
	CP	W1, [W0]
	BRA GT	L__autocross_execute39
	GOTO	L__autocross_execute29
L__autocross_execute39:
	GOTO	L_autocross_execute8
L__autocross_execute30:
L__autocross_execute29:
;autocross.c,49 :: 		Clutch_set(0);
	CLR	W10
	CALL	_Clutch_set
;autocross.c,50 :: 		Efi_unsetRPMLimiter();
	CALL	_Efi_unsetRPMLimiter
;autocross.c,51 :: 		autocross_currentState = RUNNING;                 //For gearshift  Use alternatively to autocross_stop
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#5, W0
	MOV.B	W0, [W1]
;autocross.c,54 :: 		}
L_autocross_execute8:
;autocross.c,55 :: 		Buzzer_bip();
	CALL	_Buzzer_Bip
;autocross.c,56 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,57 :: 		case RUNNING:
L_autocross_execute9:
;autocross.c,59 :: 		if(gearShift_currentGear == 4){
	MOV	_gearShift_currentGear, W0
	CP	W0, #4
	BRA Z	L__autocross_execute40
	GOTO	L_autocross_execute10
L__autocross_execute40:
;autocross.c,60 :: 		autocross_stop();
	CALL	_autocross_stop
;autocross.c,61 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,62 :: 		}
L_autocross_execute10:
;autocross.c,64 :: 		if(autocross_externValues[RPM] >= autocross_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
	MOV	_gearShift_currentGear, W0
	ADD	W0, #3, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
;autocross.c,65 :: 		&& autocross_externValues[WHEEL_SPEED] >= autocross_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
	MOV	#lo_addr(_autocross_externValues), W0
	CP	W1, [W0]
	BRA LE	L__autocross_execute41
	GOTO	L__autocross_execute32
L__autocross_execute41:
	MOV	_gearShift_currentGear, W0
	ADD	W0, #6, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_autocross_externValues+2), W0
	CP	W1, [W0]
	BRA LE	L__autocross_execute42
	GOTO	L__autocross_execute31
L__autocross_execute42:
L__autocross_execute27:
;autocross.c,66 :: 		GearShift_up();
	CALL	_GearShift_up
;autocross.c,65 :: 		&& autocross_externValues[WHEEL_SPEED] >= autocross_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
L__autocross_execute32:
L__autocross_execute31:
;autocross.c,68 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,69 :: 		case STOPPING:
L_autocross_execute14:
;autocross.c,70 :: 		autocross_currentState = OFF;
	MOV	#lo_addr(_autocross_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;autocross.c,71 :: 		Can_writeByte(SW_AUX_ID, MEX_OFF);
	MOV.B	#3, W12
	MOV	#2032, W10
	MOV	#0, W11
	CALL	_Can_writeByte
;autocross.c,72 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,74 :: 		default: return;
L_autocross_execute15:
	GOTO	L_end_autocross_execute
;autocross.c,75 :: 		}
L_autocross_execute0:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA NZ	L__autocross_execute43
	GOTO	L_autocross_execute2
L__autocross_execute43:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA NZ	L__autocross_execute44
	GOTO	L_autocross_execute3
L__autocross_execute44:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA NZ	L__autocross_execute45
	GOTO	L_autocross_execute4
L__autocross_execute45:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA NZ	L__autocross_execute46
	GOTO	L_autocross_execute5
L__autocross_execute46:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #5
	BRA NZ	L__autocross_execute47
	GOTO	L_autocross_execute9
L__autocross_execute47:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #6
	BRA NZ	L__autocross_execute48
	GOTO	L_autocross_execute14
L__autocross_execute48:
	GOTO	L_autocross_execute15
;autocross.c,76 :: 		}
L_end_autocross_execute:
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _autocross_execute

_autocross_sendOneTime:

;autocross.c,78 :: 		void autocross_sendOneTime(time_id pos){
;autocross.c,79 :: 		autocross_timesCounter = pos;
	ZE	W10, W0
	MOV	W0, _autocross_timesCounter
;autocross.c,80 :: 		}
L_end_autocross_sendOneTime:
	RETURN
; end of _autocross_sendOneTime

_autocross_sendTimes:

;autocross.c,82 :: 		void autocross_sendTimes(void)
;autocross.c,84 :: 		if(autocross_timesCounter >= 0){
	PUSH	W10
	PUSH	W11
	MOV	_autocross_timesCounter, W0
	CP	W0, #0
	BRA GE	L__autocross_sendTimes51
	GOTO	L_autocross_sendTimes16
L__autocross_sendTimes51:
;autocross.c,85 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;autocross.c,86 :: 		Can_addIntToWritePacket(CODE_SET_AUTOCROSS);
	MOV	#2, W10
	CALL	_Can_addIntToWritePacket
;autocross.c,87 :: 		Can_addIntToWritePacket(autocross_timesCounter);
	MOV	_autocross_timesCounter, W10
	CALL	_Can_addIntToWritePacket
;autocross.c,88 :: 		Can_addIntToWritePacket(autocross_parameters[autocross_timesCounter]);
	MOV	_autocross_timesCounter, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W10
	CALL	_Can_addIntToWritePacket
;autocross.c,89 :: 		if(Can_write(GCU_GEAR_TIMING_TELEMETRY_ID) < 0)
	MOV	#1805, W10
	MOV	#0, W11
	CALL	_Can_write
	CP	W0, #0
	BRA LTU	L__autocross_sendTimes52
	GOTO	L_autocross_sendTimes17
L__autocross_sendTimes52:
;autocross.c,90 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
L_autocross_sendTimes17:
;autocross.c,91 :: 		autocross_timesCounter -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_autocross_timesCounter), W0
	SUBR	W1, [W0], [W0]
;autocross.c,92 :: 		if(!autocross_sendingAll || autocross_timesCounter < 0){
	MOV	#lo_addr(_autocross_sendingAll), W0
	CP0.B	[W0]
	BRA NZ	L__autocross_sendTimes53
	GOTO	L__autocross_sendTimes35
L__autocross_sendTimes53:
	MOV	_autocross_timesCounter, W0
	CP	W0, #0
	BRA GE	L__autocross_sendTimes54
	GOTO	L__autocross_sendTimes34
L__autocross_sendTimes54:
	GOTO	L_autocross_sendTimes20
L__autocross_sendTimes35:
L__autocross_sendTimes34:
;autocross.c,93 :: 		autocross_sendingAll = FALSE;
	MOV	#lo_addr(_autocross_sendingAll), W1
	CLR	W0
	MOV.B	W0, [W1]
;autocross.c,94 :: 		autocross_timesCounter = -1;
	MOV	#65535, W0
	MOV	W0, _autocross_timesCounter
;autocross.c,95 :: 		}
L_autocross_sendTimes20:
;autocross.c,96 :: 		}
L_autocross_sendTimes16:
;autocross.c,97 :: 		}
L_end_autocross_sendTimes:
	POP	W11
	POP	W10
	RETURN
; end of _autocross_sendTimes

_autocross_sendAllTimes:

;autocross.c,99 :: 		void autocross_sendAllTimes(void)
;autocross.c,101 :: 		if(!autocross_sendingAll){
	MOV	#lo_addr(_autocross_sendingAll), W0
	CP0.B	[W0]
	BRA Z	L__autocross_sendAllTimes56
	GOTO	L_autocross_sendAllTimes21
L__autocross_sendAllTimes56:
;autocross.c,102 :: 		autocross_timesCounter = AUTOCROSS_NUM_PARAMS;
	MOV	#9, W0
	MOV	W0, _autocross_timesCounter
;autocross.c,103 :: 		autocross_sendingAll = TRUE;
	MOV	#lo_addr(_autocross_sendingAll), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;autocross.c,104 :: 		}
L_autocross_sendAllTimes21:
;autocross.c,105 :: 		}
L_end_autocross_sendAllTimes:
	RETURN
; end of _autocross_sendAllTimes

_autocross_loadDefaultParams:

;autocross.c,107 :: 		void autocross_loadDefaultParams(void){
;autocross.c,110 :: 		autocross_parameters[RAMP_START]      = DEF_RAMP_START;
	MOV	#70, W0
	MOV	W0, _autocross_parameters
;autocross.c,111 :: 		autocross_parameters[RAMP_END]        = DEF_RAMP_END;
	CLR	W0
	MOV	W0, _autocross_parameters+2
;autocross.c,112 :: 		autocross_parameters[RAMP_TIME]       = DEF_RAMP_TIME;
	MOV	#250, W0
	MOV	W0, _autocross_parameters+4
;autocross.c,113 :: 		autocross_parameters[RPM_LIMIT_1_2]   = DEF_RPM_LIMIT_1_2;
	MOV	#11300, W0
	MOV	W0, _autocross_parameters+6
;autocross.c,114 :: 		autocross_parameters[RPM_LIMIT_2_3]   = DEF_RPM_LIMIT_2_3;
	MOV	#11300, W0
	MOV	W0, _autocross_parameters+8
;autocross.c,115 :: 		autocross_parameters[RPM_LIMIT_3_4]   = DEF_RPM_LIMIT_3_4;
	MOV	#11300, W0
	MOV	W0, _autocross_parameters+10
;autocross.c,116 :: 		autocross_parameters[SPEED_LIMIT_1_2] = DEF_SPEED_LIMIT_1_2;
	MOV	#47, W0
	MOV	W0, _autocross_parameters+12
;autocross.c,117 :: 		autocross_parameters[SPEED_LIMIT_2_3] = DEF_SPEED_LIMIT_2_3;
	MOV	#65, W0
	MOV	W0, _autocross_parameters+14
;autocross.c,118 :: 		autocross_parameters[SPEED_LIMIT_3_4] = DEF_SPEED_LIMIT_3_4;
	MOV	#80, W0
	MOV	W0, _autocross_parameters+16
;autocross.c,120 :: 		}
L_end_autocross_loadDefaultParams:
	RETURN
; end of _autocross_loadDefaultParams

_autocross_updateParam:

;autocross.c,122 :: 		void autocross_updateParam(const autocross_params id, const int value){
;autocross.c,123 :: 		if(id < AUTOCROSS_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__autocross_updateParam59
	GOTO	L_autocross_updateParam22
L__autocross_updateParam59:
;autocross.c,124 :: 		autocross_parameters[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_autocross_updateParam22:
;autocross.c,125 :: 		}
L_end_autocross_updateParam:
	RETURN
; end of _autocross_updateParam

_autocross_stop:

;autocross.c,127 :: 		void autocross_stop(void){
;autocross.c,128 :: 		if(autocross_currentState != OFF)
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__autocross_stop61
	GOTO	L_autocross_stop23
L__autocross_stop61:
;autocross.c,129 :: 		autocross_currentState = STOPPING;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#6, W0
	MOV.B	W0, [W1]
L_autocross_stop23:
;autocross.c,130 :: 		}
L_end_autocross_stop:
	RETURN
; end of _autocross_stop

_autocross_updateExternValue:

;autocross.c,132 :: 		void autocross_updateExternValue(const autocross_values id, const int value){
;autocross.c,133 :: 		if(id < AUTOCROSS_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__autocross_updateExternValue63
	GOTO	L_autocross_updateExternValue24
L__autocross_updateExternValue63:
;autocross.c,134 :: 		autocross_externValues[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_externValues), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_autocross_updateExternValue24:
;autocross.c,135 :: 		}
L_end_autocross_updateExternValue:
	RETURN
; end of _autocross_updateExternValue

_autocross_getParam:

;autocross.c,137 :: 		int autocross_getParam(const autocross_params id){
;autocross.c,138 :: 		if(id < AUTOCROSS_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__autocross_getParam65
	GOTO	L_autocross_getParam25
L__autocross_getParam65:
;autocross.c,139 :: 		return autocross_parameters[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_autocross_getParam
L_autocross_getParam25:
;autocross.c,140 :: 		return -1;
	MOV	#65535, W0
;autocross.c,141 :: 		}
L_end_autocross_getParam:
	RETURN
; end of _autocross_getParam

_autocross_getExternValue:

;autocross.c,143 :: 		int autocross_getExternValue(const autocross_params id){
;autocross.c,144 :: 		if(id < AUTOCROSS_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__autocross_getExternValue67
	GOTO	L_autocross_getExternValue26
L__autocross_getExternValue67:
;autocross.c,145 :: 		return autocross_externValues[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_externValues), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_autocross_getExternValue
L_autocross_getExternValue26:
;autocross.c,146 :: 		return -1;
	MOV	#65535, W0
;autocross.c,147 :: 		}
L_end_autocross_getExternValue:
	RETURN
; end of _autocross_getExternValue