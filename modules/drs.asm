
_Drs_open:

;drs.c,10 :: 		void Drs_open(void)
;drs.c,12 :: 		Drs_setDX(DRS_SERVO_DX_OPEN);
	PUSH	W10
	MOV.B	#40, W10
	CALL	_Drs_setDX
;drs.c,13 :: 		Drs_setSX(DRS_SERVO_SX_OPEN);
	MOV.B	#60, W10
	CALL	_Drs_setSX
;drs.c,14 :: 		}
L_end_Drs_open:
	POP	W10
	RETURN
; end of _Drs_open

_Drs_close:

;drs.c,16 :: 		void Drs_close(void)
;drs.c,18 :: 		Drs_setDX(DRS_SERVO_DX_CLOSE);
	PUSH	W10
	MOV.B	#60, W10
	CALL	_Drs_setDX
;drs.c,19 :: 		Drs_setSX(DRS_SERVO_SX_CLOSE);
	MOV.B	#40, W10
	CALL	_Drs_setSX
;drs.c,20 :: 		}
L_end_Drs_close:
	POP	W10
	RETURN
; end of _Drs_close

_Drs_setDX:

;drs.c,22 :: 		void Drs_setDX(unsigned char percentage) {
;drs.c,23 :: 		unsigned char actualPercentage = 0;
	PUSH	W10
;drs.c,24 :: 		if (percentage > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__Drs_setDX7
	GOTO	L_Drs_setDX0
L__Drs_setDX7:
;drs.c,25 :: 		actualPercentage = 100;
; actualPercentage start address is: 4 (W2)
	MOV.B	#100, W2
;drs.c,26 :: 		} else {
; actualPercentage end address is: 4 (W2)
	GOTO	L_Drs_setDX1
L_Drs_setDX0:
;drs.c,27 :: 		actualPercentage = percentage;
; actualPercentage start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentage end address is: 4 (W2)
;drs.c,28 :: 		}
L_Drs_setDX1:
;drs.c,29 :: 		DrsMotor_setPositionDX(100 - actualPercentage);
; actualPercentage start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_DrsMotor_setPositionDX
	POP	W2
;drs.c,30 :: 		Drs_currentValue = actualPercentage;
	MOV	#lo_addr(_drs_currentValue), W0
	MOV.B	W2, [W0]
; actualPercentage end address is: 4 (W2)
;drs.c,31 :: 		}
L_end_Drs_setDX:
	POP	W10
	RETURN
; end of _Drs_setDX

_Drs_setSX:

;drs.c,33 :: 		void Drs_setSX(unsigned char percentage) {
;drs.c,34 :: 		unsigned char actualPercentage = 0;
	PUSH	W10
;drs.c,35 :: 		if (percentage > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__Drs_setSX9
	GOTO	L_Drs_setSX2
L__Drs_setSX9:
;drs.c,36 :: 		actualPercentage = 100;
; actualPercentage start address is: 4 (W2)
	MOV.B	#100, W2
;drs.c,37 :: 		} else {
; actualPercentage end address is: 4 (W2)
	GOTO	L_Drs_setSX3
L_Drs_setSX2:
;drs.c,38 :: 		actualPercentage = percentage;
; actualPercentage start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentage end address is: 4 (W2)
;drs.c,39 :: 		}
L_Drs_setSX3:
;drs.c,40 :: 		DrsMotor_setPositionSX(100 - actualPercentage);
; actualPercentage start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_DrsMotor_setPositionSX
	POP	W2
;drs.c,41 :: 		Drs_currentValue = actualPercentage;
	MOV	#lo_addr(_drs_currentValue), W0
	MOV.B	W2, [W0]
; actualPercentage end address is: 4 (W2)
;drs.c,42 :: 		}
L_end_Drs_setSX:
	POP	W10
	RETURN
; end of _Drs_setSX

_Drs_get:

;drs.c,44 :: 		unsigned char Drs_get(void) {
;drs.c,45 :: 		return Drs_currentValue;
	MOV	#lo_addr(_drs_currentValue), W0
	MOV.B	[W0], W0
;drs.c,46 :: 		}
L_end_Drs_get:
	RETURN
; end of _Drs_get
