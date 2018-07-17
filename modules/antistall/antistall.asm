
_antistall_init:

;antistall.c,18 :: 		void antistall_init(void)
;antistall.c,20 :: 		antistall_currentState = OFF_ANTISTALL;
	MOV	#lo_addr(_antistall_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;antistall.c,21 :: 		antistall_loadDefaultParams();
	CALL	_antistall_loadDefaultParams
;antistall.c,22 :: 		}
L_end_antistall_init:
	RETURN
; end of _antistall_init

_antistall_execute:

;antistall.c,24 :: 		void antistall_execute(void)
;antistall.c,26 :: 		switch (antistall_currentState)
	PUSH	W10
	GOTO	L_antistall_execute0
;antistall.c,28 :: 		case START_ANTISTALL:
L_antistall_execute2:
;antistall.c,29 :: 		antistall_currentState = PULLING_ANTISTALL;
	MOV	#lo_addr(_antistall_currentState), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;antistall.c,30 :: 		return;
	GOTO	L_end_antistall_execute
;antistall.c,31 :: 		case PULLING_ANTISTALL:
L_antistall_execute3:
;antistall.c,32 :: 		antistall_clutchValue = antistall_parameters[CLUTCH_PULL];
	MOV	_antistall_parameters+4, W0
	MOV	W0, _antistall_clutchValue
;antistall.c,33 :: 		Clutch_set(antistall_clutchValue);
	MOV	_antistall_parameters+4, W10
	CALL	_Clutch_set
;antistall.c,34 :: 		return;
	GOTO	L_end_antistall_execute
;antistall.c,35 :: 		case STOPPING_ANTISTALL:
L_antistall_execute4:
;antistall.c,36 :: 		antistall_currentState = OFF_ANTISTALL;
	MOV	#lo_addr(_antistall_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;antistall.c,37 :: 		Clutch_set(0);
	CLR	W10
	CALL	_Clutch_set
;antistall.c,38 :: 		return;
	GOTO	L_end_antistall_execute
;antistall.c,39 :: 		default:
L_antistall_execute5:
;antistall.c,40 :: 		return;
	GOTO	L_end_antistall_execute
;antistall.c,41 :: 		}
L_antistall_execute0:
	MOV	#lo_addr(_antistall_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA NZ	L__antistall_execute19
	GOTO	L_antistall_execute2
L__antistall_execute19:
	MOV	#lo_addr(_antistall_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA NZ	L__antistall_execute20
	GOTO	L_antistall_execute3
L__antistall_execute20:
	MOV	#lo_addr(_antistall_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA NZ	L__antistall_execute21
	GOTO	L_antistall_execute4
L__antistall_execute21:
	GOTO	L_antistall_execute5
;antistall.c,42 :: 		}
L_end_antistall_execute:
	POP	W10
	RETURN
; end of _antistall_execute

_antistall_checkPlausibility:

;antistall.c,44 :: 		void antistall_checkPlausibility(void)
;antistall.c,47 :: 		&& antistall_externValues[WHEEL_SPEED] < antistall_parameters[SPEED_LIMIT_ANTISTALL])
	PUSH	W10
	MOV	_antistall_externValues, W1
	MOV	#lo_addr(_antistall_parameters), W0
	CP	W1, [W0]
	BRA LT	L__antistall_checkPlausibility23
	GOTO	L__antistall_checkPlausibility16
L__antistall_checkPlausibility23:
	MOV	_antistall_externValues+2, W1
	MOV	#lo_addr(_antistall_parameters+2), W0
	CP	W1, [W0]
	BRA LT	L__antistall_checkPlausibility24
	GOTO	L__antistall_checkPlausibility15
L__antistall_checkPlausibility24:
L__antistall_checkPlausibility14:
;antistall.c,50 :: 		antistall_currentState = START_ANTISTALL;
	MOV	#lo_addr(_antistall_currentState), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;antistall.c,51 :: 		antistallFb = 1;
	MOV	#1, W0
	MOV	W0, _antistallFb
;antistall.c,52 :: 		sendUpdatesSW(ANTISTALL_CODE);
	MOV	#5, W10
	CALL	_sendUpdatesSW
;antistall.c,47 :: 		&& antistall_externValues[WHEEL_SPEED] < antistall_parameters[SPEED_LIMIT_ANTISTALL])
L__antistall_checkPlausibility16:
L__antistall_checkPlausibility15:
;antistall.c,54 :: 		}
L_end_antistall_checkPlausibility:
	POP	W10
	RETURN
; end of _antistall_checkPlausibility

_antistall_loadDefaultParams:

;antistall.c,56 :: 		void antistall_loadDefaultParams(void){
;antistall.c,59 :: 		antistall_parameters[RPM_LIMIT_ANTISTALL]         = DEF_RPM_LIMIT_ANTISTALL;
	MOV	#3700, W0
	MOV	W0, _antistall_parameters
;antistall.c,60 :: 		antistall_parameters[SPEED_LIMIT_ANTISTALL] = DEF_SPEED_LIMIT_ANTISTALL;
	MOV	#10, W0
	MOV	W0, _antistall_parameters+2
;antistall.c,61 :: 		antistall_parameters[CLUTCH_PULL]                        = DEF_CLUTCH_PULL;
	MOV	#100, W0
	MOV	W0, _antistall_parameters+4
;antistall.c,63 :: 		}
L_end_antistall_loadDefaultParams:
	RETURN
; end of _antistall_loadDefaultParams

_antistall_updateParam:

;antistall.c,65 :: 		void antistall_updateParam(const antistall_params id, const int value){
;antistall.c,66 :: 		if(id < ANTISTALL_NUM_PARAMS)
	CP.B	W10, #3
	BRA LTU	L__antistall_updateParam27
	GOTO	L_antistall_updateParam9
L__antistall_updateParam27:
;antistall.c,67 :: 		antistall_parameters[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_antistall_parameters), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_antistall_updateParam9:
;antistall.c,68 :: 		}
L_end_antistall_updateParam:
	RETURN
; end of _antistall_updateParam

_antistall_stop:

;antistall.c,70 :: 		void antistall_stop(void){
;antistall.c,71 :: 		if(antistall_currentState != OFF_ANTISTALL)
	PUSH	W10
	MOV	#lo_addr(_antistall_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__antistall_stop29
	GOTO	L_antistall_stop10
L__antistall_stop29:
;antistall.c,73 :: 		antistall_currentState = STOPPING_ANTISTALL;
	MOV	#lo_addr(_antistall_currentState), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;antistall.c,74 :: 		antistallFb = 0;
	CLR	W0
	MOV	W0, _antistallFb
;antistall.c,75 :: 		sendUpdatesSW(ANTISTALL_CODE);
	MOV	#5, W10
	CALL	_sendUpdatesSW
;antistall.c,76 :: 		}
L_antistall_stop10:
;antistall.c,77 :: 		}
L_end_antistall_stop:
	POP	W10
	RETURN
; end of _antistall_stop

_antistall_updateExternValue:

;antistall.c,79 :: 		void antistall_updateExternValue(const antistall_values id, const int value){
;antistall.c,80 :: 		if(id < ANTISTALL_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__antistall_updateExternValue31
	GOTO	L_antistall_updateExternValue11
L__antistall_updateExternValue31:
;antistall.c,81 :: 		antistall_externValues[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_antistall_externValues), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_antistall_updateExternValue11:
;antistall.c,82 :: 		}
L_end_antistall_updateExternValue:
	RETURN
; end of _antistall_updateExternValue

_antistall_getParam:

;antistall.c,84 :: 		int antistall_getParam(const antistall_params id){
;antistall.c,85 :: 		if(id < ANTISTALL_NUM_PARAMS)
	CP.B	W10, #3
	BRA LTU	L__antistall_getParam33
	GOTO	L_antistall_getParam12
L__antistall_getParam33:
;antistall.c,86 :: 		return antistall_parameters[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_antistall_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_antistall_getParam
L_antistall_getParam12:
;antistall.c,87 :: 		return -1;
	MOV	#65535, W0
;antistall.c,88 :: 		}
L_end_antistall_getParam:
	RETURN
; end of _antistall_getParam

_antistall_getExternValue:

;antistall.c,90 :: 		int antistall_getExternValue(const antistall_params id){
;antistall.c,91 :: 		if(id < ANTISTALL_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__antistall_getExternValue35
	GOTO	L_antistall_getExternValue13
L__antistall_getExternValue35:
;antistall.c,92 :: 		return antistall_externValues[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_antistall_externValues), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_antistall_getExternValue
L_antistall_getExternValue13:
;antistall.c,93 :: 		return -1;
	MOV	#65535, W0
;antistall.c,94 :: 		}
L_end_antistall_getExternValue:
	RETURN
; end of _antistall_getExternValue
