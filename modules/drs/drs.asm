
_Drs_open:

;drs.c,13 :: 		void Drs_open(void)
;drs.c,15 :: 		Drs_setDX(DRS_SERVO_DX_OPEN);
	PUSH	W10
	MOV.B	#40, W10
	CALL	_Drs_setDX
;drs.c,16 :: 		Drs_setSX(DRS_SERVO_SX_OPEN);
	MOV.B	#60, W10
	CALL	_Drs_setSX
;drs.c,17 :: 		drs_currentValue = Drs_get();
	CALL	_Drs_get
	MOV	#lo_addr(_drs_currentValue), W1
	MOV.B	W0, [W1]
;drs.c,18 :: 		drsFb = (unsigned int)drs_currentValue;
	ZE	W0, W0
	MOV	W0, _drsFb
;drs.c,19 :: 		sendUpdatesSW(DRS_CODE);
	MOV	#4, W10
	CALL	_sendUpdatesSW
;drs.c,20 :: 		}
L_end_Drs_open:
	POP	W10
	RETURN
; end of _Drs_open

_Drs_close:

;drs.c,22 :: 		void Drs_close(void)
;drs.c,24 :: 		Drs_setDX(DRS_SERVO_DX_CLOSE);
	PUSH	W10
	MOV.B	#60, W10
	CALL	_Drs_setDX
;drs.c,25 :: 		Drs_setSX(DRS_SERVO_SX_CLOSE);
	MOV.B	#40, W10
	CALL	_Drs_setSX
;drs.c,26 :: 		drs_currentValue = Drs_get();
	CALL	_Drs_get
	MOV	#lo_addr(_drs_currentValue), W1
	MOV.B	W0, [W1]
;drs.c,27 :: 		drsFb = (unsigned int)drs_currentValue;
	ZE	W0, W0
	MOV	W0, _drsFb
;drs.c,28 :: 		sendUpdatesSW(DRS_CODE);
	MOV	#4, W10
	CALL	_sendUpdatesSW
;drs.c,29 :: 		}
L_end_Drs_close:
	POP	W10
	RETURN
; end of _Drs_close

_Drs_setDX:

;drs.c,31 :: 		void Drs_setDX(unsigned char percentageDX) {
;drs.c,32 :: 		unsigned char actualPercentageDX = 0;
	PUSH	W10
;drs.c,33 :: 		if (percentageDX > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__Drs_setDX20
	GOTO	L_Drs_setDX0
L__Drs_setDX20:
;drs.c,34 :: 		actualPercentageDX = 100;
; actualPercentageDX start address is: 4 (W2)
	MOV.B	#100, W2
;drs.c,35 :: 		} else {
; actualPercentageDX end address is: 4 (W2)
	GOTO	L_Drs_setDX1
L_Drs_setDX0:
;drs.c,36 :: 		actualPercentageDX = percentageDX;
; actualPercentageDX start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentageDX end address is: 4 (W2)
;drs.c,37 :: 		}
L_Drs_setDX1:
;drs.c,38 :: 		DrsMotor_setPositionDX(100 - actualPercentageDX);
; actualPercentageDX start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_DrsMotor_setPositionDX
	POP	W2
;drs.c,39 :: 		drs_currentValueDX = actualPercentageDX;
	MOV	#lo_addr(_drs_currentValueDX), W0
	MOV.B	W2, [W0]
; actualPercentageDX end address is: 4 (W2)
;drs.c,40 :: 		}
L_end_Drs_setDX:
	POP	W10
	RETURN
; end of _Drs_setDX

_Drs_setSX:

;drs.c,42 :: 		void Drs_setSX(unsigned char percentageSX) {
;drs.c,43 :: 		unsigned char actualPercentageSX = 0;
	PUSH	W10
;drs.c,44 :: 		if (percentageSX > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__Drs_setSX22
	GOTO	L_Drs_setSX2
L__Drs_setSX22:
;drs.c,45 :: 		actualPercentageSX = 100;
; actualPercentageSX start address is: 4 (W2)
	MOV.B	#100, W2
;drs.c,46 :: 		} else {
; actualPercentageSX end address is: 4 (W2)
	GOTO	L_Drs_setSX3
L_Drs_setSX2:
;drs.c,47 :: 		actualPercentageSX = percentageSX;
; actualPercentageSX start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentageSX end address is: 4 (W2)
;drs.c,48 :: 		}
L_Drs_setSX3:
;drs.c,49 :: 		DrsMotor_setPositionSX(100 - actualPercentageSX);
; actualPercentageSX start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_DrsMotor_setPositionSX
	POP	W2
;drs.c,50 :: 		drs_currentValueSX = actualPercentageSX;
	MOV	#lo_addr(_drs_currentValueSX), W0
	MOV.B	W2, [W0]
; actualPercentageSX end address is: 4 (W2)
;drs.c,51 :: 		}
L_end_Drs_setSX:
	POP	W10
	RETURN
; end of _Drs_setSX

_Drs_getDX:

;drs.c,53 :: 		unsigned char Drs_getDX(void)
;drs.c,55 :: 		return drs_currentValueDX;
	MOV	#lo_addr(_drs_currentValueDX), W0
	MOV.B	[W0], W0
;drs.c,56 :: 		}
L_end_Drs_getDX:
	RETURN
; end of _Drs_getDX

_Drs_getSX:

;drs.c,58 :: 		unsigned char Drs_getSX(void)
;drs.c,60 :: 		return drs_currentValueSX;
	MOV	#lo_addr(_drs_currentValueSX), W0
	MOV.B	[W0], W0
;drs.c,61 :: 		}
L_end_Drs_getSX:
	RETURN
; end of _Drs_getSX

_Drs_get:

;drs.c,63 :: 		unsigned char Drs_get(void)
;drs.c,66 :: 		currentValueSX = Drs_getSX();
	CALL	_Drs_getSX
; currentvalueSX start address is: 2 (W1)
	MOV.B	W0, W1
;drs.c,67 :: 		currentValueDX = Drs_getDX();
	CALL	_Drs_getDX
; currentValueDX start address is: 4 (W2)
	MOV.B	W0, W2
;drs.c,69 :: 		&& currentValueDX < DRS_SERVO_CENTRAL_POSITION )
	MOV.B	#50, W0
	CP.B	W1, W0
	BRA GTU	L__Drs_get26
	GOTO	L__Drs_get14
L__Drs_get26:
	MOV.B	#50, W0
	CP.B	W2, W0
	BRA LTU	L__Drs_get27
	GOTO	L__Drs_get13
L__Drs_get27:
; currentvalueSX end address is: 2 (W1)
; currentValueDX end address is: 4 (W2)
L__Drs_get12:
;drs.c,70 :: 		return 1; //DRS open
	MOV.B	#1, W0
	GOTO	L_end_Drs_get
;drs.c,69 :: 		&& currentValueDX < DRS_SERVO_CENTRAL_POSITION )
L__Drs_get14:
; currentValueDX start address is: 4 (W2)
; currentvalueSX start address is: 2 (W1)
L__Drs_get13:
;drs.c,72 :: 		&& currentValueDX > DRS_SERVO_CENTRAL_POSITION )
	MOV.B	#50, W0
	CP.B	W1, W0
	BRA LTU	L__Drs_get28
	GOTO	L__Drs_get16
L__Drs_get28:
; currentvalueSX end address is: 2 (W1)
	MOV.B	#50, W0
	CP.B	W2, W0
	BRA GTU	L__Drs_get29
	GOTO	L__Drs_get15
L__Drs_get29:
; currentValueDX end address is: 4 (W2)
L__Drs_get11:
;drs.c,73 :: 		return 0; //DRS close
	CLR	W0
	GOTO	L_end_Drs_get
;drs.c,72 :: 		&& currentValueDX > DRS_SERVO_CENTRAL_POSITION )
L__Drs_get16:
L__Drs_get15:
;drs.c,74 :: 		}
L_end_Drs_get:
	RETURN
; end of _Drs_get
