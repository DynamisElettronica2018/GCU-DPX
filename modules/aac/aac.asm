
_getAccelerationFb:

;aac.c,20 :: 		unsigned int getAccelerationFb()
;aac.c,22 :: 		return accelerationFb;
	MOV	_accelerationFb, W0
;aac.c,23 :: 		}
L_end_getAccelerationFb:
	RETURN
; end of _getAccelerationFb

_aac_init:

;aac.c,26 :: 		void aac_init(void){
;aac.c,27 :: 		aac_currentState = OFF;
	MOV	#lo_addr(_aac_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;aac.c,28 :: 		aac_loadDefaultParams();
	CALL	_aac_loadDefaultParams
;aac.c,29 :: 		}
L_end_aac_init:
	RETURN
; end of _aac_init

_aac_execute:
	LNK	#8

;aac.c,31 :: 		void aac_execute(void){
;aac.c,32 :: 		switch (aac_currentState) {
	PUSH	W10
	GOTO	L_aac_execute0
;aac.c,33 :: 		case START:
L_aac_execute2:
;aac.c,35 :: 		Efi_setBlip();
	CALL	_Efi_setBlip
;aac.c,37 :: 		aac_clutchValue = 100;
	MOV	#0, W0
	MOV	#17096, W1
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,38 :: 		Clutch_set((unsigned int)aac_clutchValue);
	MOV	#0, W0
	MOV	#17096, W1
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,39 :: 		aac_currentState = READY;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;aac.c,40 :: 		accelerationFb = 1;
	MOV	#1, W0
	MOV	W0, _accelerationFb
;aac.c,41 :: 		sendUpdatesSW(ACC_CODE);
	MOV	#1, W10
	CALL	_sendUpdatesSW
;aac.c,42 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,43 :: 		case READY:
L_aac_execute3:
;aac.c,44 :: 		Clutch_set(100);
	MOV.B	#100, W10
	CALL	_Clutch_set
;aac.c,45 :: 		Drs_open();
	CALL	_Drs_open
;aac.c,46 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,47 :: 		case START_RELEASE:
L_aac_execute4:
;aac.c,48 :: 		aac_clutchValue = aac_parameters[RAMP_START];
	MOV	_aac_parameters, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,49 :: 		Clutch_set(aac_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,50 :: 		aac_dtRelease = aac_parameters[RAMP_TIME] / AAC_WORK_RATE_ms;
	MOV	_aac_parameters+4, W0
	MOV	#25, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _aac_dtRelease
;aac.c,51 :: 		aac_clutchStep = ((float)(aac_parameters[RAMP_START] - aac_parameters[RAMP_END]) * AAC_WORK_RATE_ms) / (float)aac_parameters[RAMP_TIME];
	MOV	_aac_parameters, W1
	MOV	#lo_addr(_aac_parameters+2), W0
	SUB	W1, [W0], W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16840, W3
	CALL	__Mul_FP
	MOV	W0, [W14+4]
	MOV	W1, [W14+6]
	MOV	_aac_parameters+4, W0
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
	MOV	W0, _aac_clutchStep
	MOV	W1, _aac_clutchStep+2
;aac.c,52 :: 		aac_currentState = RELEASING;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;aac.c,53 :: 		accelerationFb = 2;
	MOV	#2, W0
	MOV	W0, _accelerationFb
;aac.c,54 :: 		sendUpdatesSW(ACC_CODE);
	MOV	#1, W10
	CALL	_sendUpdatesSW
;aac.c,55 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,56 :: 		case RELEASING:
L_aac_execute5:
;aac.c,58 :: 		aac_clutchValue = aac_clutchValue - aac_clutchStep;
	MOV	_aac_clutchValue, W0
	MOV	_aac_clutchValue+2, W1
	MOV	_aac_clutchStep, W2
	MOV	_aac_clutchStep+2, W3
	CALL	__Sub_FP
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,59 :: 		Clutch_set((unsigned char)aac_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,60 :: 		aac_dtRelease--;
	MOV	#1, W1
	MOV	#lo_addr(_aac_dtRelease), W0
	SUBR	W1, [W0], [W0]
;aac.c,61 :: 		if(aac_dtRelease <= 0 || Clutch_get() <= aac_parameters[RAMP_END]){
	MOV	_aac_dtRelease, W0
	CP	W0, #0
	BRA GT	L__aac_execute29
	GOTO	L__aac_execute23
L__aac_execute29:
	CALL	_Clutch_get
	ZE	W0, W1
	MOV	#lo_addr(_aac_parameters+2), W0
	CP	W1, [W0]
	BRA GT	L__aac_execute30
	GOTO	L__aac_execute22
L__aac_execute30:
	GOTO	L_aac_execute8
L__aac_execute23:
L__aac_execute22:
;aac.c,62 :: 		Clutch_set(0);
	CLR	W10
	CALL	_Clutch_set
;aac.c,63 :: 		Efi_unsetRPMLimiter();
	CALL	_Efi_unsetRPMLimiter
;aac.c,64 :: 		aac_currentState = RUNNING;                 //For gearshift  Use alternatively to aac_stop
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#5, W0
	MOV.B	W0, [W1]
;aac.c,67 :: 		}
L_aac_execute8:
;aac.c,68 :: 		Buzzer_bip();
	CALL	_Buzzer_Bip
;aac.c,69 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,70 :: 		case RUNNING:
L_aac_execute9:
;aac.c,72 :: 		if(gearShift_currentGear == 3){
	MOV	_gearShift_currentGear, W0
	CP	W0, #3
	BRA Z	L__aac_execute31
	GOTO	L_aac_execute10
L__aac_execute31:
;aac.c,73 :: 		aac_stop();
	CALL	_aac_stop
;aac.c,74 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,75 :: 		}
L_aac_execute10:
;aac.c,77 :: 		if(aac_externValues[RPM] >= aac_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
	MOV	_gearShift_currentGear, W0
	ADD	W0, #3, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
;aac.c,78 :: 		&& aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
	MOV	#lo_addr(_aac_externValues), W0
	CP	W1, [W0]
	BRA LE	L__aac_execute32
	GOTO	L__aac_execute25
L__aac_execute32:
	MOV	_gearShift_currentGear, W0
	ADD	W0, #7, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_aac_externValues+2), W0
	CP	W1, [W0]
	BRA LE	L__aac_execute33
	GOTO	L__aac_execute24
L__aac_execute33:
L__aac_execute20:
;aac.c,79 :: 		GearShift_up();
	CALL	_GearShift_up
;aac.c,78 :: 		&& aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
L__aac_execute25:
L__aac_execute24:
;aac.c,81 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,82 :: 		case STOPPING:
L_aac_execute14:
;aac.c,83 :: 		aac_currentState = OFF;
	MOV	#lo_addr(_aac_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;aac.c,85 :: 		Efi_unsetBlip();
	CALL	_Efi_unsetBlip
;aac.c,86 :: 		Drs_close();
	CALL	_Drs_close
;aac.c,87 :: 		accelerationFb = 0;
	CLR	W0
	MOV	W0, _accelerationFb
;aac.c,88 :: 		sendUpdatesSW(ACC_CODE);
	MOV	#1, W10
	CALL	_sendUpdatesSW
;aac.c,89 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,91 :: 		default: return;
L_aac_execute15:
	GOTO	L_end_aac_execute
;aac.c,92 :: 		}
L_aac_execute0:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA NZ	L__aac_execute34
	GOTO	L_aac_execute2
L__aac_execute34:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA NZ	L__aac_execute35
	GOTO	L_aac_execute3
L__aac_execute35:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA NZ	L__aac_execute36
	GOTO	L_aac_execute4
L__aac_execute36:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA NZ	L__aac_execute37
	GOTO	L_aac_execute5
L__aac_execute37:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #5
	BRA NZ	L__aac_execute38
	GOTO	L_aac_execute9
L__aac_execute38:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #6
	BRA NZ	L__aac_execute39
	GOTO	L_aac_execute14
L__aac_execute39:
	GOTO	L_aac_execute15
;aac.c,93 :: 		}
L_end_aac_execute:
	POP	W10
	ULNK
	RETURN
; end of _aac_execute

_aac_loadDefaultParams:

;aac.c,125 :: 		void aac_loadDefaultParams(void){
;aac.c,128 :: 		aac_parameters[RAMP_START]      = DEF_RAMP_START;
	MOV	#50, W0
	MOV	W0, _aac_parameters
;aac.c,129 :: 		aac_parameters[RAMP_END]        = DEF_RAMP_END;
	CLR	W0
	MOV	W0, _aac_parameters+2
;aac.c,130 :: 		aac_parameters[RAMP_TIME]       = DEF_RAMP_TIME;
	MOV	#250, W0
	MOV	W0, _aac_parameters+4
;aac.c,131 :: 		aac_parameters[RPM_LIMIT_1_2]   = DEF_RPM_LIMIT_1_2;
	MOV	#11000, W0
	MOV	W0, _aac_parameters+6
;aac.c,132 :: 		aac_parameters[RPM_LIMIT_2_3]   = DEF_RPM_LIMIT_2_3;
	MOV	#11000, W0
	MOV	W0, _aac_parameters+8
;aac.c,133 :: 		aac_parameters[RPM_LIMIT_3_4]   = DEF_RPM_LIMIT_3_4;
	MOV	#11000, W0
	MOV	W0, _aac_parameters+10
;aac.c,134 :: 		aac_parameters[RPM_LIMIT_4_5]   = DEF_RPM_LIMIT_4_5;
	MOV	#11000, W0
	MOV	W0, _aac_parameters+12
;aac.c,135 :: 		aac_parameters[SPEED_LIMIT_1_2] = DEF_SPEED_LIMIT_1_2;
	MOV	#46, W0
	MOV	W0, _aac_parameters+14
;aac.c,136 :: 		aac_parameters[SPEED_LIMIT_2_3] = DEF_SPEED_LIMIT_2_3;
	MOV	#61, W0
	MOV	W0, _aac_parameters+16
;aac.c,137 :: 		aac_parameters[SPEED_LIMIT_3_4] = DEF_SPEED_LIMIT_3_4;
	MOV	#77, W0
	MOV	W0, _aac_parameters+18
;aac.c,138 :: 		aac_parameters[SPEED_LIMIT_4_5] = DEF_SPEED_LIMIT_4_5;
	MOV	#113, W0
	MOV	W0, _aac_parameters+20
;aac.c,140 :: 		}
L_end_aac_loadDefaultParams:
	RETURN
; end of _aac_loadDefaultParams

_aac_stop:

;aac.c,148 :: 		void aac_stop(void){
;aac.c,149 :: 		if(aac_currentState != OFF)
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__aac_stop42
	GOTO	L_aac_stop16
L__aac_stop42:
;aac.c,150 :: 		aac_currentState = STOPPING;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#6, W0
	MOV.B	W0, [W1]
L_aac_stop16:
;aac.c,151 :: 		}
L_end_aac_stop:
	RETURN
; end of _aac_stop

_aac_updateExternValue:

;aac.c,153 :: 		void aac_updateExternValue(const aac_values id, const int value){
;aac.c,154 :: 		if(id < AAC_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__aac_updateExternValue44
	GOTO	L_aac_updateExternValue17
L__aac_updateExternValue44:
;aac.c,155 :: 		aac_externValues[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_externValues), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_aac_updateExternValue17:
;aac.c,156 :: 		}
L_end_aac_updateExternValue:
	RETURN
; end of _aac_updateExternValue

_aac_getParam:

;aac.c,158 :: 		int aac_getParam(const aac_params id){
;aac.c,159 :: 		if(id < AAC_NUM_PARAMS)
	CP.B	W10, #11
	BRA LTU	L__aac_getParam46
	GOTO	L_aac_getParam18
L__aac_getParam46:
;aac.c,160 :: 		return aac_parameters[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_aac_getParam
L_aac_getParam18:
;aac.c,161 :: 		return -1;
	MOV	#65535, W0
;aac.c,162 :: 		}
L_end_aac_getParam:
	RETURN
; end of _aac_getParam

_aac_getExternValue:

;aac.c,164 :: 		int aac_getExternValue(const aac_params id){
;aac.c,165 :: 		if(id < AAC_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__aac_getExternValue48
	GOTO	L_aac_getExternValue19
L__aac_getExternValue48:
;aac.c,166 :: 		return aac_externValues[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_externValues), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_aac_getExternValue
L_aac_getExternValue19:
;aac.c,167 :: 		return -1;
	MOV	#65535, W0
;aac.c,168 :: 		}
L_end_aac_getExternValue:
	RETURN
; end of _aac_getExternValue
