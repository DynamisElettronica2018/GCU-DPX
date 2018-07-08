
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
;drsmotor.c,18 :: 		setTimer(TIMER3_DEVICE, DRSMOTOR_PWM_PERIOD);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#55050, W11
	MOV	#15523, W12
	MOV.B	#3, W10
	CALL	_setTimer
;drsmotor.c,19 :: 		DrsMotor_setupPWM();
	CALL	_DrsMotor_setupPWM
;drsmotor.c,20 :: 		}
L_end_DrsMotor_init:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _DrsMotor_init

_DrsMotor_setupPWM:

;drsmotor.c,22 :: 		void DrsMotor_setupPWM(void) {
;drsmotor.c,23 :: 		OC1CON = 0x6; //DX SERVO PWM on Timer 3
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#6, W0
	MOV	WREG, OC1CON
;drsmotor.c,24 :: 		OC2CON = 0x6; //SX SERVO PWM on Timer 3
	MOV	#6, W0
	MOV	WREG, OC2CON
;drsmotor.c,25 :: 		DRSMOTOR_PWM_PERIOD_VALUE = getTimerPeriod(DRSMOTOR_PWM_PERIOD, TIMER3_PRESCALER);   //PRESCALER calcolato 256
	MOV	#lo_addr(T3CONbits), W0
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
	MOV	#52429, W2
	MOV	#15820, W3
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
;drsmotor.c,33 :: 		OC2R = DRSMOTOR_PWM_MIN_VALUE;   //SX DRS SERVO
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
	MOV	WREG, OC2R
;drsmotor.c,35 :: 		}
L_end_DrsMotor_setupPWM:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _DrsMotor_setupPWM

_DrshMotor_setPosition:
	LNK	#4

;drsmotor.c,37 :: 		void DrshMotor_setPosition(unsigned char percentage) {
;drsmotor.c,39 :: 		pwmValue = (unsigned int) ((percentage * DRSMOTOR_PERCENTAGE_STEP) + DRSMOTOR_PWM_MIN_VALUE);
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
;drsmotor.c,40 :: 		if (pwmValue > DRSMOTOR_PWM_MAX_VALUE) {
	MOV	#lo_addr(_DRSMOTOR_PWM_MAX_VALUE), W1
	CP	W0, [W1]
	BRA GTU	L__DrshMotor_setPosition8
	GOTO	L_DrshMotor_setPosition0
L__DrshMotor_setPosition8:
; pwmValue end address is: 4 (W2)
;drsmotor.c,41 :: 		pwmValue = DRSMOTOR_PWM_MAX_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_DRSMOTOR_PWM_MAX_VALUE, W0
;drsmotor.c,42 :: 		} else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
; pwmValue end address is: 0 (W0)
	GOTO	L_DrshMotor_setPosition1
L_DrshMotor_setPosition0:
; pwmValue start address is: 4 (W2)
	MOV	#lo_addr(_DRSMOTOR_PWM_MIN_VALUE), W0
	CP	W2, [W0]
	BRA LTU	L__DrshMotor_setPosition9
	GOTO	L__DrshMotor_setPosition3
L__DrshMotor_setPosition9:
; pwmValue end address is: 4 (W2)
;drsmotor.c,43 :: 		pwmValue = DRSMOTOR_PWM_MIN_VALUE;
; pwmValue start address is: 0 (W0)
	MOV	_DRSMOTOR_PWM_MIN_VALUE, W0
; pwmValue end address is: 0 (W0)
;drsmotor.c,44 :: 		}
	GOTO	L_DrshMotor_setPosition2
L__DrshMotor_setPosition3:
;drsmotor.c,42 :: 		} else if (pwmValue < DRSMOTOR_PWM_MIN_VALUE) {
	MOV	W2, W0
;drsmotor.c,44 :: 		}
L_DrshMotor_setPosition2:
; pwmValue start address is: 0 (W0)
; pwmValue end address is: 0 (W0)
L_DrshMotor_setPosition1:
;drsmotor.c,45 :: 		OC1R = pwmValue;   //DX DRS SERVO
; pwmValue start address is: 0 (W0)
	MOV	WREG, OC1R
;drsmotor.c,46 :: 		OC2R = pwmValue;   //SX DRS SERVO
	MOV	WREG, OC2R
; pwmValue end address is: 0 (W0)
;drsmotor.c,47 :: 		}
L_end_DrshMotor_setPosition:
	ULNK
	RETURN
; end of _DrshMotor_setPosition
