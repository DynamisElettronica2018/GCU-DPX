
_autocross_init:

;autocross.c,19 :: 		void autocross_init(void){
;autocross.c,20 :: 		autocross_currentState = OFF_AUTOCROSS;
	MOV	#lo_addr(_autocross_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;autocross.c,21 :: 		autocross_loadDefaultParams();
	CALL	_autocross_loadDefaultParams
;autocross.c,22 :: 		}
L_end_autocross_init:
	RETURN
; end of _autocross_init

_autocross_execute:
	LNK	#8

;autocross.c,24 :: 		void autocross_execute(void){
;autocross.c,25 :: 		switch (autocross_currentState) {
	PUSH	W10
	GOTO	L_autocross_execute0
;autocross.c,26 :: 		case START_AUTOCROSS:
L_autocross_execute2:
;autocross.c,27 :: 		Efi_setRPMLimiter();
	CALL	_Efi_setRPMLimiter
;autocross.c,28 :: 		autocrossFb = 1;
	MOV	#1, W0
	MOV	W0, _autocrossFb
;autocross.c,30 :: 		autocross_currentState = READY_AUTOCROSS;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;autocross.c,31 :: 		autocross_clutchValue = 100;
	MOV	#0, W0
	MOV	#17096, W1
	MOV	W0, _autocross_clutchValue
	MOV	W1, _autocross_clutchValue+2
;autocross.c,32 :: 		Clutch_set((unsigned int)autocross_clutchValue);
	MOV	#0, W0
	MOV	#17096, W1
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;autocross.c,33 :: 		autocrossFb = 1;
	MOV	#1, W0
	MOV	W0, _autocrossFb
;autocross.c,34 :: 		sendUpdatesSW(AUTOX_CODE);
	MOV	#2, W10
	CALL	_sendUpdatesSW
;autocross.c,35 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,36 :: 		case READY_AUTOCROSS:
L_autocross_execute3:
;autocross.c,37 :: 		Clutch_set(100);
	MOV.B	#100, W10
	CALL	_Clutch_set
;autocross.c,38 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,39 :: 		case START_RELEASE_AUTOCROSS:
L_autocross_execute4:
;autocross.c,40 :: 		autocrossFb = 2;
	MOV	#2, W0
	MOV	W0, _autocrossFb
;autocross.c,41 :: 		autocross_clutchValue = autocross_parameters[RAMP_START_AUTOCROSS];
	MOV	_autocross_parameters, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _autocross_clutchValue
	MOV	W1, _autocross_clutchValue+2
;autocross.c,42 :: 		Clutch_set(autocross_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;autocross.c,43 :: 		autocross_dtRelease = autocross_parameters[RAMP_TIME_AUTOCROSS] / AUTOCROSS_WORK_RATE_ms;
	MOV	_autocross_parameters+4, W0
	MOV	#25, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _autocross_dtRelease
;autocross.c,44 :: 		autocross_clutchStep = ((float)(autocross_parameters[RAMP_START_AUTOCROSS] - autocross_parameters[RAMP_END_AUTOCROSS]) * AUTOCROSS_WORK_RATE_ms) / (float)autocross_parameters[RAMP_TIME_AUTOCROSS];
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
;autocross.c,45 :: 		autocross_currentState = RELEASING_AUTOCROSS;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;autocross.c,46 :: 		autocrossFb = 2;
	MOV	#2, W0
	MOV	W0, _autocrossFb
;autocross.c,47 :: 		sendUpdatesSW(AUTOX_CODE);
	MOV	#2, W10
	CALL	_sendUpdatesSW
;autocross.c,48 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,49 :: 		case RELEASING_AUTOCROSS:
L_autocross_execute5:
;autocross.c,51 :: 		autocross_clutchValue = autocross_clutchValue - autocross_clutchStep;
	MOV	_autocross_clutchValue, W0
	MOV	_autocross_clutchValue+2, W1
	MOV	_autocross_clutchStep, W2
	MOV	_autocross_clutchStep+2, W3
	CALL	__Sub_FP
	MOV	W0, _autocross_clutchValue
	MOV	W1, _autocross_clutchValue+2
;autocross.c,52 :: 		Clutch_set((unsigned char)autocross_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;autocross.c,53 :: 		autocross_dtRelease--;
	MOV	#1, W1
	MOV	#lo_addr(_autocross_dtRelease), W0
	SUBR	W1, [W0], [W0]
;autocross.c,54 :: 		if(autocross_dtRelease <= 0 || Clutch_get() <= autocross_parameters[RAMP_END_AUTOCROSS]){
	MOV	_autocross_dtRelease, W0
	CP	W0, #0
	BRA GT	L__autocross_execute29
	GOTO	L__autocross_execute24
L__autocross_execute29:
	CALL	_Clutch_get
	ZE	W0, W1
	MOV	#lo_addr(_autocross_parameters+2), W0
	CP	W1, [W0]
	BRA GT	L__autocross_execute30
	GOTO	L__autocross_execute23
L__autocross_execute30:
	GOTO	L_autocross_execute8
L__autocross_execute24:
L__autocross_execute23:
;autocross.c,55 :: 		Clutch_set(0);
	CLR	W10
	CALL	_Clutch_set
;autocross.c,56 :: 		Efi_unsetRPMLimiter();
	CALL	_Efi_unsetRPMLimiter
;autocross.c,57 :: 		autocross_currentState = RUNNING_AUTOCROSS;                 //For gearshift  Use alternatively to autocross_stop
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#5, W0
	MOV.B	W0, [W1]
;autocross.c,60 :: 		}
L_autocross_execute8:
;autocross.c,61 :: 		Buzzer_bip();
	CALL	_Buzzer_Bip
;autocross.c,62 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,63 :: 		case RUNNING_AUTOCROSS:
L_autocross_execute9:
;autocross.c,65 :: 		if(gearShift_currentGear == 2){         //autocross finisce dopo aver inserito la seconda marcia in automatico
	MOV	_gearShift_currentGear, W0
	CP	W0, #2
	BRA Z	L__autocross_execute31
	GOTO	L_autocross_execute10
L__autocross_execute31:
;autocross.c,66 :: 		autocross_stop();
	CALL	_autocross_stop
;autocross.c,67 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,68 :: 		}
L_autocross_execute10:
;autocross.c,70 :: 		if(autocross_externValues[RPM_AUTOCROSS] >= autocross_parameters[RPM_LIMIT_1_2_AUTOCROSS + gearShift_currentGear - 1]
	MOV	_gearShift_currentGear, W0
	ADD	W0, #3, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
;autocross.c,71 :: 		&& autocross_externValues[WHEEL_SPEED_AUTOCROSS] >= autocross_parameters[SPEED_LIMIT_1_2_AUTOCROSS + gearShift_currentGear - 1]){
	MOV	#lo_addr(_autocross_externValues), W0
	CP	W1, [W0]
	BRA LE	L__autocross_execute32
	GOTO	L__autocross_execute26
L__autocross_execute32:
	MOV	_gearShift_currentGear, W0
	ADD	W0, #7, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_autocross_externValues+2), W0
	CP	W1, [W0]
	BRA LE	L__autocross_execute33
	GOTO	L__autocross_execute25
L__autocross_execute33:
L__autocross_execute21:
;autocross.c,72 :: 		GearShift_up();
	CALL	_GearShift_up
;autocross.c,71 :: 		&& autocross_externValues[WHEEL_SPEED_AUTOCROSS] >= autocross_parameters[SPEED_LIMIT_1_2_AUTOCROSS + gearShift_currentGear - 1]){
L__autocross_execute26:
L__autocross_execute25:
;autocross.c,74 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,75 :: 		case STOPPING_AUTOCROSS:
L_autocross_execute14:
;autocross.c,76 :: 		autocross_currentState = OFF_AUTOCROSS;
	MOV	#lo_addr(_autocross_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;autocross.c,77 :: 		return;
	GOTO	L_end_autocross_execute
;autocross.c,79 :: 		default: return;
L_autocross_execute15:
	GOTO	L_end_autocross_execute
;autocross.c,80 :: 		}
L_autocross_execute0:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA NZ	L__autocross_execute34
	GOTO	L_autocross_execute2
L__autocross_execute34:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA NZ	L__autocross_execute35
	GOTO	L_autocross_execute3
L__autocross_execute35:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA NZ	L__autocross_execute36
	GOTO	L_autocross_execute4
L__autocross_execute36:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA NZ	L__autocross_execute37
	GOTO	L_autocross_execute5
L__autocross_execute37:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #5
	BRA NZ	L__autocross_execute38
	GOTO	L_autocross_execute9
L__autocross_execute38:
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #6
	BRA NZ	L__autocross_execute39
	GOTO	L_autocross_execute14
L__autocross_execute39:
	GOTO	L_autocross_execute15
;autocross.c,81 :: 		}
L_end_autocross_execute:
	POP	W10
	ULNK
	RETURN
; end of _autocross_execute

_autocross_loadDefaultParams:

;autocross.c,84 :: 		void autocross_loadDefaultParams(void){
;autocross.c,87 :: 		autocross_parameters[RAMP_START_AUTOCROSS]      = DEF_RAMP_START_AUTOCROSS;
	MOV	#70, W0
	MOV	W0, _autocross_parameters
;autocross.c,88 :: 		autocross_parameters[RAMP_END_AUTOCROSS]        = DEF_RAMP_END_AUTOCROSS;
	CLR	W0
	MOV	W0, _autocross_parameters+2
;autocross.c,89 :: 		autocross_parameters[RAMP_TIME_AUTOCROSS]       = DEF_RAMP_TIME_AUTOCROSS;
	MOV	#250, W0
	MOV	W0, _autocross_parameters+4
;autocross.c,90 :: 		autocross_parameters[RPM_LIMIT_1_2_AUTOCROSS]   = DEF_RPM_LIMIT_1_2_AUTOCROSS;
	MOV	#11300, W0
	MOV	W0, _autocross_parameters+6
;autocross.c,91 :: 		autocross_parameters[RPM_LIMIT_2_3_AUTOCROSS]   = DEF_RPM_LIMIT_2_3_AUTOCROSS;
	MOV	#11300, W0
	MOV	W0, _autocross_parameters+8
;autocross.c,92 :: 		autocross_parameters[RPM_LIMIT_3_4_AUTOCROSS]   = DEF_RPM_LIMIT_3_4_AUTOCROSS;
	MOV	#11300, W0
	MOV	W0, _autocross_parameters+10
;autocross.c,93 :: 		autocross_parameters[SPEED_LIMIT_1_2_AUTOCROSS] = DEF_SPEED_LIMIT_1_2_AUTOCROSS;
	MOV	#47, W0
	MOV	W0, _autocross_parameters+14
;autocross.c,94 :: 		autocross_parameters[SPEED_LIMIT_2_3_AUTOCROSS] = DEF_SPEED_LIMIT_2_3_AUTOCROSS;
	MOV	#65, W0
	MOV	W0, _autocross_parameters+16
;autocross.c,95 :: 		autocross_parameters[SPEED_LIMIT_3_4_AUTOCROSS] = DEF_SPEED_LIMIT_3_4_AUTOCROSS;
	MOV	#80, W0
	MOV	W0, _autocross_parameters+18
;autocross.c,97 :: 		}
L_end_autocross_loadDefaultParams:
	RETURN
; end of _autocross_loadDefaultParams

_autocross_updateParam:

;autocross.c,99 :: 		void autocross_updateParam(const autocross_params id, const int value){
;autocross.c,100 :: 		if(id < AUTOCROSS_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__autocross_updateParam42
	GOTO	L_autocross_updateParam16
L__autocross_updateParam42:
;autocross.c,101 :: 		autocross_parameters[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_autocross_updateParam16:
;autocross.c,102 :: 		}
L_end_autocross_updateParam:
	RETURN
; end of _autocross_updateParam

_autocross_stop:

;autocross.c,104 :: 		void autocross_stop(void){
;autocross.c,105 :: 		if(autocross_currentState != OFF_AUTOCROSS)
	PUSH	W10
	MOV	#lo_addr(_autocross_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__autocross_stop44
	GOTO	L_autocross_stop17
L__autocross_stop44:
;autocross.c,107 :: 		autocross_currentState = STOPPING_AUTOCROSS;
	MOV	#lo_addr(_autocross_currentState), W1
	MOV.B	#6, W0
	MOV.B	W0, [W1]
;autocross.c,108 :: 		autocrossFb = 0;
	CLR	W0
	MOV	W0, _autocrossFb
;autocross.c,109 :: 		sendUpdatesSW(AUTOX_CODE);
	MOV	#2, W10
	CALL	_sendUpdatesSW
;autocross.c,110 :: 		}
L_autocross_stop17:
;autocross.c,111 :: 		}
L_end_autocross_stop:
	POP	W10
	RETURN
; end of _autocross_stop

_autocross_updateExternValue:

;autocross.c,113 :: 		void autocross_updateExternValue(const autocross_values id, const int value){
;autocross.c,114 :: 		if(id < AUTOCROSS_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__autocross_updateExternValue46
	GOTO	L_autocross_updateExternValue18
L__autocross_updateExternValue46:
;autocross.c,115 :: 		autocross_externValues[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_externValues), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_autocross_updateExternValue18:
;autocross.c,116 :: 		}
L_end_autocross_updateExternValue:
	RETURN
; end of _autocross_updateExternValue

_autocross_getParam:

;autocross.c,118 :: 		int autocross_getParam(const autocross_params id){
;autocross.c,119 :: 		if(id < AUTOCROSS_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__autocross_getParam48
	GOTO	L_autocross_getParam19
L__autocross_getParam48:
;autocross.c,120 :: 		return autocross_parameters[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_autocross_getParam
L_autocross_getParam19:
;autocross.c,121 :: 		return -1;
	MOV	#65535, W0
;autocross.c,122 :: 		}
L_end_autocross_getParam:
	RETURN
; end of _autocross_getParam

_autocross_getExternValue:

;autocross.c,124 :: 		int autocross_getExternValue(const autocross_params id){
;autocross.c,125 :: 		if(id < AUTOCROSS_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__autocross_getExternValue50
	GOTO	L_autocross_getExternValue20
L__autocross_getExternValue50:
;autocross.c,126 :: 		return autocross_externValues[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_autocross_externValues), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_autocross_getExternValue
L_autocross_getExternValue20:
;autocross.c,127 :: 		return -1;
	MOV	#65535, W0
;autocross.c,128 :: 		}
L_end_autocross_getExternValue:
	RETURN
; end of _autocross_getExternValue
