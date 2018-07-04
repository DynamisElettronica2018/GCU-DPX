
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
	PUSH	W11
	PUSH	W12
	GOTO	L_aac_execute0
;aac.c,33 :: 		case START:
L_aac_execute2:
;aac.c,34 :: 		Efi_setRPMLimiter();   //controllare efi com e limite rpm
	CALL	_Efi_setRPMLimiter
;aac.c,36 :: 		aac_currentState = READY;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;aac.c,37 :: 		accelerationFb = 1;
	MOV	#1, W0
	MOV	W0, _accelerationFb
;aac.c,38 :: 		aac_clutchValue = 100;
	MOV	#0, W0
	MOV	#17096, W1
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,39 :: 		Clutch_set((unsigned int)aac_clutchValue);
	MOV	#0, W0
	MOV	#17096, W1
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,40 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;aac.c,41 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;aac.c,42 :: 		Can_addIntToWritePacket(getAccelerationFb());
	CALL	_getAccelerationFb
	MOV	W0, W10
	CALL	_Can_addIntToWritePacket
;aac.c,43 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;aac.c,44 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;aac.c,45 :: 		Can_write(GCU_AUX_ID);
	MOV	#2033, W10
	MOV	#0, W11
	CALL	_Can_write
;aac.c,46 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,47 :: 		case READY:
L_aac_execute3:
;aac.c,48 :: 		Clutch_set(100);
	MOV.B	#100, W10
	CALL	_Clutch_set
;aac.c,49 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,50 :: 		case START_RELEASE:
L_aac_execute4:
;aac.c,51 :: 		aac_clutchValue = aac_parameters[RAMP_START];
	MOV	_aac_parameters, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,52 :: 		Clutch_set(aac_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,53 :: 		aac_dtRelease = aac_parameters[RAMP_TIME] / AAC_WORK_RATE_ms;
	MOV	_aac_parameters+4, W0
	MOV	#25, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _aac_dtRelease
;aac.c,54 :: 		aac_clutchStep = ((float)(aac_parameters[RAMP_START] - aac_parameters[RAMP_END]) * AAC_WORK_RATE_ms) / (float)aac_parameters[RAMP_TIME];
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
;aac.c,55 :: 		aac_currentState = RELEASING;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;aac.c,56 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,57 :: 		case RELEASING:
L_aac_execute5:
;aac.c,59 :: 		aac_clutchValue = aac_clutchValue - aac_clutchStep;
	MOV	_aac_clutchValue, W0
	MOV	_aac_clutchValue+2, W1
	MOV	_aac_clutchStep, W2
	MOV	_aac_clutchStep+2, W3
	CALL	__Sub_FP
	MOV	W0, _aac_clutchValue
	MOV	W1, _aac_clutchValue+2
;aac.c,60 :: 		Clutch_set((unsigned char)aac_clutchValue);
	CALL	__Float2Longint
	MOV.B	W0, W10
	CALL	_Clutch_set
;aac.c,61 :: 		aac_dtRelease--;
	MOV	#1, W1
	MOV	#lo_addr(_aac_dtRelease), W0
	SUBR	W1, [W0], [W0]
;aac.c,62 :: 		if(aac_dtRelease <= 0 || Clutch_get() <= aac_parameters[RAMP_END]){
	MOV	_aac_dtRelease, W0
	CP	W0, #0
	BRA GT	L__aac_execute39
	GOTO	L__aac_execute30
L__aac_execute39:
	CALL	_Clutch_get
	ZE	W0, W1
	MOV	#lo_addr(_aac_parameters+2), W0
	CP	W1, [W0]
	BRA GT	L__aac_execute40
	GOTO	L__aac_execute29
L__aac_execute40:
	GOTO	L_aac_execute8
L__aac_execute30:
L__aac_execute29:
;aac.c,63 :: 		Clutch_set(0);
	CLR	W10
	CALL	_Clutch_set
;aac.c,64 :: 		Efi_unsetRPMLimiter();
	CALL	_Efi_unsetRPMLimiter
;aac.c,65 :: 		aac_currentState = RUNNING;                 //For gearshift  Use alternatively to aac_stop
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#5, W0
	MOV.B	W0, [W1]
;aac.c,68 :: 		}
L_aac_execute8:
;aac.c,69 :: 		Buzzer_bip();
	CALL	_Buzzer_Bip
;aac.c,70 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,71 :: 		case RUNNING:
L_aac_execute9:
;aac.c,73 :: 		if(gearShift_currentGear == 4){
	MOV	_gearShift_currentGear, W0
	CP	W0, #4
	BRA Z	L__aac_execute41
	GOTO	L_aac_execute10
L__aac_execute41:
;aac.c,74 :: 		aac_stop();
	CALL	_aac_stop
;aac.c,75 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,76 :: 		}
L_aac_execute10:
;aac.c,78 :: 		if(aac_externValues[RPM] >= aac_parameters[RPM_LIMIT_1_2 + gearShift_currentGear - 1]
	MOV	_gearShift_currentGear, W0
	ADD	W0, #3, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
;aac.c,79 :: 		&& aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
	MOV	#lo_addr(_aac_externValues), W0
	CP	W1, [W0]
	BRA LE	L__aac_execute42
	GOTO	L__aac_execute32
L__aac_execute42:
	MOV	_gearShift_currentGear, W0
	ADD	W0, #6, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_aac_externValues+2), W0
	CP	W1, [W0]
	BRA LE	L__aac_execute43
	GOTO	L__aac_execute31
L__aac_execute43:
L__aac_execute27:
;aac.c,80 :: 		GearShift_up();
	CALL	_GearShift_up
;aac.c,79 :: 		&& aac_externValues[WHEEL_SPEED] >= aac_parameters[SPEED_LIMIT_1_2 + gearShift_currentGear - 1]){
L__aac_execute32:
L__aac_execute31:
;aac.c,82 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,83 :: 		case STOPPING:
L_aac_execute14:
;aac.c,84 :: 		aac_currentState = OFF;
	MOV	#lo_addr(_aac_currentState), W1
	CLR	W0
	MOV.B	W0, [W1]
;aac.c,85 :: 		Can_writeByte(SW_AUX_ID, MEX_OFF);
	MOV.B	#3, W12
	MOV	#2032, W10
	MOV	#0, W11
	CALL	_Can_writeByte
;aac.c,86 :: 		return;
	GOTO	L_end_aac_execute
;aac.c,88 :: 		default: return;
L_aac_execute15:
	GOTO	L_end_aac_execute
;aac.c,89 :: 		}
L_aac_execute0:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA NZ	L__aac_execute44
	GOTO	L_aac_execute2
L__aac_execute44:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA NZ	L__aac_execute45
	GOTO	L_aac_execute3
L__aac_execute45:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA NZ	L__aac_execute46
	GOTO	L_aac_execute4
L__aac_execute46:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA NZ	L__aac_execute47
	GOTO	L_aac_execute5
L__aac_execute47:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #5
	BRA NZ	L__aac_execute48
	GOTO	L_aac_execute9
L__aac_execute48:
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #6
	BRA NZ	L__aac_execute49
	GOTO	L_aac_execute14
L__aac_execute49:
	GOTO	L_aac_execute15
;aac.c,90 :: 		}
L_end_aac_execute:
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _aac_execute

_aac_sendOneTime:

;aac.c,92 :: 		void aac_sendOneTime(time_id pos){
;aac.c,93 :: 		aac_timesCounter = pos;
	ZE	W10, W0
	MOV	W0, _aac_timesCounter
;aac.c,94 :: 		}
L_end_aac_sendOneTime:
	RETURN
; end of _aac_sendOneTime

_aac_sendTimes:

;aac.c,96 :: 		void aac_sendTimes(void)
;aac.c,98 :: 		if(aac_timesCounter >= 0){
	PUSH	W10
	PUSH	W11
	MOV	_aac_timesCounter, W0
	CP	W0, #0
	BRA GE	L__aac_sendTimes52
	GOTO	L_aac_sendTimes16
L__aac_sendTimes52:
;aac.c,99 :: 		Can_resetWritePacket();
	CALL	_Can_resetWritePacket
;aac.c,100 :: 		Can_addIntToWritePacket(CODE_SET_AAC);
	MOV	#2, W10
	CALL	_Can_addIntToWritePacket
;aac.c,101 :: 		Can_addIntToWritePacket(aac_timesCounter);
	MOV	_aac_timesCounter, W10
	CALL	_Can_addIntToWritePacket
;aac.c,102 :: 		Can_addIntToWritePacket(aac_parameters[aac_timesCounter]);
	MOV	_aac_timesCounter, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W10
	CALL	_Can_addIntToWritePacket
;aac.c,103 :: 		if(Can_write(GCU_GEAR_TIMING_TELEMETRY_ID) < 0)
	MOV	#1805, W10
	MOV	#0, W11
	CALL	_Can_write
	CP	W0, #0
	BRA LTU	L__aac_sendTimes53
	GOTO	L_aac_sendTimes17
L__aac_sendTimes53:
;aac.c,104 :: 		Buzzer_Bip();
	CALL	_Buzzer_Bip
L_aac_sendTimes17:
;aac.c,105 :: 		aac_timesCounter -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_aac_timesCounter), W0
	SUBR	W1, [W0], [W0]
;aac.c,106 :: 		if(!aac_sendingAll || aac_timesCounter < 0){
	MOV	#lo_addr(_aac_sendingAll), W0
	CP0.B	[W0]
	BRA NZ	L__aac_sendTimes54
	GOTO	L__aac_sendTimes35
L__aac_sendTimes54:
	MOV	_aac_timesCounter, W0
	CP	W0, #0
	BRA GE	L__aac_sendTimes55
	GOTO	L__aac_sendTimes34
L__aac_sendTimes55:
	GOTO	L_aac_sendTimes20
L__aac_sendTimes35:
L__aac_sendTimes34:
;aac.c,107 :: 		aac_sendingAll = FALSE;
	MOV	#lo_addr(_aac_sendingAll), W1
	CLR	W0
	MOV.B	W0, [W1]
;aac.c,108 :: 		aac_timesCounter = -1;
	MOV	#65535, W0
	MOV	W0, _aac_timesCounter
;aac.c,109 :: 		}
L_aac_sendTimes20:
;aac.c,110 :: 		}
L_aac_sendTimes16:
;aac.c,111 :: 		}
L_end_aac_sendTimes:
	POP	W11
	POP	W10
	RETURN
; end of _aac_sendTimes

_aac_sendAllTimes:

;aac.c,113 :: 		void aac_sendAllTimes(void)
;aac.c,115 :: 		if(!aac_sendingAll){
	MOV	#lo_addr(_aac_sendingAll), W0
	CP0.B	[W0]
	BRA Z	L__aac_sendAllTimes57
	GOTO	L_aac_sendAllTimes21
L__aac_sendAllTimes57:
;aac.c,116 :: 		aac_timesCounter = AAC_NUM_PARAMS;
	MOV	#9, W0
	MOV	W0, _aac_timesCounter
;aac.c,117 :: 		aac_sendingAll = TRUE;
	MOV	#lo_addr(_aac_sendingAll), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;aac.c,118 :: 		}
L_aac_sendAllTimes21:
;aac.c,119 :: 		}
L_end_aac_sendAllTimes:
	RETURN
; end of _aac_sendAllTimes

_aac_loadDefaultParams:

;aac.c,121 :: 		void aac_loadDefaultParams(void){
;aac.c,124 :: 		aac_parameters[RAMP_START]      = DEF_RAMP_START;
	MOV	#70, W0
	MOV	W0, _aac_parameters
;aac.c,125 :: 		aac_parameters[RAMP_END]        = DEF_RAMP_END;
	CLR	W0
	MOV	W0, _aac_parameters+2
;aac.c,126 :: 		aac_parameters[RAMP_TIME]       = DEF_RAMP_TIME;
	MOV	#250, W0
	MOV	W0, _aac_parameters+4
;aac.c,127 :: 		aac_parameters[RPM_LIMIT_1_2]   = DEF_RPM_LIMIT_1_2;
	MOV	#11300, W0
	MOV	W0, _aac_parameters+6
;aac.c,128 :: 		aac_parameters[RPM_LIMIT_2_3]   = DEF_RPM_LIMIT_2_3;
	MOV	#11300, W0
	MOV	W0, _aac_parameters+8
;aac.c,129 :: 		aac_parameters[RPM_LIMIT_3_4]   = DEF_RPM_LIMIT_3_4;
	MOV	#11300, W0
	MOV	W0, _aac_parameters+10
;aac.c,130 :: 		aac_parameters[SPEED_LIMIT_1_2] = DEF_SPEED_LIMIT_1_2;
	MOV	#47, W0
	MOV	W0, _aac_parameters+12
;aac.c,131 :: 		aac_parameters[SPEED_LIMIT_2_3] = DEF_SPEED_LIMIT_2_3;
	MOV	#65, W0
	MOV	W0, _aac_parameters+14
;aac.c,132 :: 		aac_parameters[SPEED_LIMIT_3_4] = DEF_SPEED_LIMIT_3_4;
	MOV	#80, W0
	MOV	W0, _aac_parameters+16
;aac.c,134 :: 		}
L_end_aac_loadDefaultParams:
	RETURN
; end of _aac_loadDefaultParams

_aac_updateParam:

;aac.c,136 :: 		void aac_updateParam(const aac_params id, const int value){
;aac.c,137 :: 		if(id < AAC_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__aac_updateParam60
	GOTO	L_aac_updateParam22
L__aac_updateParam60:
;aac.c,138 :: 		aac_parameters[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_aac_updateParam22:
;aac.c,139 :: 		}
L_end_aac_updateParam:
	RETURN
; end of _aac_updateParam

_aac_stop:

;aac.c,141 :: 		void aac_stop(void){
;aac.c,142 :: 		if(aac_currentState != OFF)
	MOV	#lo_addr(_aac_currentState), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__aac_stop62
	GOTO	L_aac_stop23
L__aac_stop62:
;aac.c,143 :: 		aac_currentState = STOPPING;
	MOV	#lo_addr(_aac_currentState), W1
	MOV.B	#6, W0
	MOV.B	W0, [W1]
L_aac_stop23:
;aac.c,144 :: 		}
L_end_aac_stop:
	RETURN
; end of _aac_stop

_aac_updateExternValue:

;aac.c,146 :: 		void aac_updateExternValue(const aac_values id, const int value){
;aac.c,147 :: 		if(id < AAC_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__aac_updateExternValue64
	GOTO	L_aac_updateExternValue24
L__aac_updateExternValue64:
;aac.c,148 :: 		aac_externValues[id] = value;
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_externValues), W0
	ADD	W0, W1, W0
	MOV	W11, [W0]
L_aac_updateExternValue24:
;aac.c,149 :: 		}
L_end_aac_updateExternValue:
	RETURN
; end of _aac_updateExternValue

_aac_getParam:

;aac.c,151 :: 		int aac_getParam(const aac_params id){
;aac.c,152 :: 		if(id < AAC_NUM_PARAMS)
	CP.B	W10, #9
	BRA LTU	L__aac_getParam66
	GOTO	L_aac_getParam25
L__aac_getParam66:
;aac.c,153 :: 		return aac_parameters[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_parameters), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_aac_getParam
L_aac_getParam25:
;aac.c,154 :: 		return -1;
	MOV	#65535, W0
;aac.c,155 :: 		}
L_end_aac_getParam:
	RETURN
; end of _aac_getParam

_aac_getExternValue:

;aac.c,157 :: 		int aac_getExternValue(const aac_params id){
;aac.c,158 :: 		if(id < AAC_NUM_VALUES)
	CP.B	W10, #3
	BRA LTU	L__aac_getExternValue68
	GOTO	L_aac_getExternValue26
L__aac_getExternValue68:
;aac.c,159 :: 		return aac_externValues[id];
	ZE	W10, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_aac_externValues), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	GOTO	L_end_aac_getExternValue
L_aac_getExternValue26:
;aac.c,160 :: 		return -1;
	MOV	#65535, W0
;aac.c,161 :: 		}
L_end_aac_getExternValue:
	RETURN
; end of _aac_getExternValue
