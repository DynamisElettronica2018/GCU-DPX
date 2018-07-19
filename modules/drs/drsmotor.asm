
_timer3_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;drsmotor.c,13 :: 		onTimer3Interrupt{
;drsmotor.c,14 :: 		clearTimer3();
	BCLR	IFS0bits, #7
;drsmotor.c,15 :: 		}
L_end_timer3_interrupt:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _timer3_interrupt

_DrsMotor_init:

;drsmotor.c,17 :: 		void DrsMotor_init(void) {
;drsmotor.c,19 :: 		DrsMotorDX_setupPWM();
	CALL	_DrsMotorDX_setupPWM
;drsmotor.c,20 :: 		DrsMotorSX_setupPWM();
	CALL	_DrsMotorSX_setupPWM
;drsmotor.c,21 :: 		}
L_end_DrsMotor_init:
	RETURN
; end of _DrsMotor_init

_DrsMotorDX_setupPWM:

;drsmotor.c,23 :: 		void DrsMotorDX_setupPWM(void) {
;drsmotor.c,24 :: 		OC1CON = 0x6; //DX SERVO PWM on Timer 3
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#6, W0
	MOV	WREG, OC1CON
;drsmotor.c,25 :: 		DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(DRSMOTOR_PWM_PERIOD, TIMER2_PRESCALER);   //PRESCALER calcolato 256
	MOV	#lo_addr(T2CONbits), W0
	MOV.B	[W0], W0
	MOV.B	W0, W1
	MOV.B	#48, W0
	AND.B	W1, W0, W1
	ZE	W1, W0
	LSR	W0, #4, W1
	MOV.B	W1, W12
	MOV	#55050, W10
	MOV	#15523, W11
	CALL	_getTimerPeriod
	MOV	W0, _DRSMOTOR_PWM_PERIOD_VALUE
;drsmotor.c,28 :: 		(DRSMOTOR_MAX_PWM_PERCENTAGE / 100.0));
	CLR	W1
	CALL	__Long2Float
	MOV	#18350, W2
	MOV	#15841, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _DRSMOTOR_PWM_MAX_VALUE
;drsmotor.c,30 :: 		(DRSMOTOR_MIN_PWM_PERCENTAGE / 100.0));
	MOV	_DRSMOTOR_PWM_PERIOD_VALUE, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _DRSMOTOR_PWM_MIN_VALUE
;drsmotor.c,31 :: 		DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
	MOV	#lo_addr(_DRSMOTOR_PWM_MAX_VALUE), W1
	SUBR	W0, [W1], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#17096, W3
	CALL	__Div_FP
	MOV	W0, _DRSMOTOR_PERCENTAGE_STEP
	MOV	W1, _DRSMOTOR_PERCENTAGE_STEP+2
;drsmotor.c,32 :: 		OC1R = DRSMOTOR_PWM_MIN_VALUE;   //DX DRS SERVO
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
	MOV	WREG, OC1R
;drsmotor.c,34 :: 		}
L_end_DrsMotorDX_setupPWM:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _DrsMotorDX_setupPWM

_DrsMotorSX_setupPWM:

;drsmotor.c,36 :: 		void DrsMotorSX_setupPWM(void) {
;drsmotor.c,37 :: 		OC2CON = 0x6; //SX SERVO PWM on Timer 3
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#6, W0
	MOV	WREG, OC2CON
;drsmotor.c,38 :: 		DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(DRSMOTOR_PWM_PERIOD, TIMER2_PRESCALER);   //PRESCALER calcolato 256
	MOV	#lo_addr(T2CONbits), W0
	MOV.B	[W0], W0
	MOV.B	W0, W1
	MOV.B	#48, W0
	AND.B	W1, W0, W1
	ZE	W1, W0
	LSR	W0, #4, W1
	MOV.B	W1, W12
	MOV	#55050, W10
	MOV	#15523, W11
	CALL	_getTimerPeriod
	MOV	W0, _DRSMOTOR_PWM_PERIOD_VALUE
;drsmotor.c,41 :: 		(DRSMOTOR_MAX_PWM_PERCENTAGE / 100.0));
	CLR	W1
	CALL	__Long2Float
	MOV	#18350, W2
	MOV	#15841, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _DRSMOTOR_PWM_MAX_VALUE
;drsmotor.c,43 :: 		(DRSMOTOR_MIN_PWM_PERCENTAGE / 100.0));
	MOV	_DRSMOTOR_PWM_PERIOD_VALUE, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#15692, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _DRSMOTOR_PWM_MIN_VALUE
;drsmotor.c,44 :: 		DRSMOTOR_PERCENTAGE_STEP = (DRSMOTOR_PWM_MAX_VALUE - DRSMOTOR_PWM_MIN_VALUE) / 100.0;
	MOV	#lo_addr(_DRSMOTOR_PWM_MAX_VALUE), W1
	SUBR	W0, [W1], W0
	CLR	W1
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#17096, W3
	CALL	__Div_FP
	MOV	W0, _DRSMOTOR_PERCENTAGE_STEP
	MOV	W1, _DRSMOTOR_PERCENTAGE_STEP+2
;drsmotor.c,45 :: 		OC2R = DRSMOTOR_PWM_MIN_VALUE;   //SX DRS SERVO
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
	MOV	WREG, OC2R
;drsmotor.c,47 :: 		}
L_end_DrsMotorSX_setupPWM:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _DrsMotorSX_setupPWM

_DrsMotor_setPositionDX:
	LNK	#4

;drsmotor.c,49 :: 		void DrsMotor_setPositionDX(unsigned char percentage) {
;drsmotor.c,51 :: 		pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
	ZE	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	_DRSMOTOR_PERCENTAGE_STEP, W2
	MOV	_DRSMOTOR_PERCENTAGE_STEP+2, W3
	CALL	__Mul_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
	CLR	W1
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
; pwmValue start address is: 4 (W2)
	MOV	W0, W2
;drsmotor.c,52 :: 		if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
	MOV	#lo_addr(_DRSMOTOR_PWM_MAX_VALUE), W1
	CP	W0, [W1]
	BRA GTU	L__DrsMotor_setPositionDX13
	GOTO	L_DrsMotor_setPositionDX0
L__DrsMotor_setPositionDX13:
; pwmValue end address is: 4 (W2)
;drsmotor.c,53 :: 		pwmValue = DRSMOTOR_PWM_MAX_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_DRSMOTOR_PWM_MAX_VALUE, W0
;drsmotor.c,54 :: 		} else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
; pwmValue end address is: 0 (W0)
	GOTO	L_DrsMotor_setPositionDX1
L_DrsMotor_setPositionDX0:
; pwmValue start address is: 4 (W2)
	MOV	#lo_addr(_DRSMOTOR_PWM_MIN_VALUE), W0
	CP	W2, [W0]
	BRA LTU	L__DrsMotor_setPositionDX14
	GOTO	L__DrsMotor_setPositionDX6
L__DrsMotor_setPositionDX14:
; pwmValue end address is: 4 (W2)
;drsmotor.c,55 :: 		pwmValue = DRSMOTOR_PWM_MIN_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
; pwmValue end address is: 0 (W0)
;drsmotor.c,56 :: 		}
	GOTO	L_DrsMotor_setPositionDX2
L__DrsMotor_setPositionDX6:
;drsmotor.c,54 :: 		} else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
	MOV	W2, W0
;drsmotor.c,56 :: 		}
L_DrsMotor_setPositionDX2:
; pwmValue start address is: 0 (W0)
; pwmValue end address is: 0 (W0)
L_DrsMotor_setPositionDX1:
;drsmotor.c,57 :: 		OC1RS = pwmValue;   //DX DRS SERVO
; pwmValue start address is: 0 (W0)
	MOV	WREG, OC1RS
; pwmValue end address is: 0 (W0)
;drsmotor.c,58 :: 		}
L_end_DrsMotor_setPositionDX:
	ULNK
	RETURN
; end of _DrsMotor_setPositionDX

_DrsMotor_setPositionSX:
	LNK	#4

;drsmotor.c,60 :: 		void DrsMotor_setPositionSX(unsigned char percentage) {
;drsmotor.c,62 :: 		pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
	ZE	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	_DRSMOTOR_PERCENTAGE_STEP, W2
	MOV	_DRSMOTOR_PERCENTAGE_STEP+2, W3
	CALL	__Mul_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
	CLR	W1
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
; pwmValue start address is: 4 (W2)
	MOV	W0, W2
;drsmotor.c,63 :: 		if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
	MOV	#lo_addr(_DRSMOTOR_PWM_MAX_VALUE), W1
	CP	W0, [W1]
	BRA GTU	L__DrsMotor_setPositionSX16
	GOTO	L_DrsMotor_setPositionSX3
L__DrsMotor_setPositionSX16:
; pwmValue end address is: 4 (W2)
;drsmotor.c,64 :: 		pwmValue = DRSMOTOR_PWM_MAX_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_DRSMOTOR_PWM_MAX_VALUE, W0
;drsmotor.c,65 :: 		} else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
; pwmValue end address is: 0 (W0)
	GOTO	L_DrsMotor_setPositionSX4
L_DrsMotor_setPositionSX3:
; pwmValue start address is: 4 (W2)
	MOV	#lo_addr(_DRSMOTOR_PWM_MIN_VALUE), W0
	CP	W2, [W0]
	BRA LTU	L__DrsMotor_setPositionSX17
	GOTO	L__DrsMotor_setPositionSX7
L__DrsMotor_setPositionSX17:
; pwmValue end address is: 4 (W2)
;drsmotor.c,66 :: 		pwmValue = DRSMOTOR_PWM_MIN_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
; pwmValue end address is: 0 (W0)
;drsmotor.c,67 :: 		}
	GOTO	L_DrsMotor_setPositionSX5
L__DrsMotor_setPositionSX7:
;drsmotor.c,65 :: 		} else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
	MOV	W2, W0
;drsmotor.c,67 :: 		}
L_DrsMotor_setPositionSX5:
; pwmValue start address is: 0 (W0)
; pwmValue end address is: 0 (W0)
L_DrsMotor_setPositionSX4:
;drsmotor.c,68 :: 		OC2RS = pwmValue;   //SX DRS SERVO
; pwmValue start address is: 0 (W0)
	MOV	WREG, OC2RS
; pwmValue end address is: 0 (W0)
;drsmotor.c,69 :: 		}
L_end_DrsMotor_setPositionSX:
	ULNK
	RETURN
; end of _DrsMotor_setPositionSX
