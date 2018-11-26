
_Drs_initVoltReg:

;drs.c,15 :: 		void Drs_initVoltReg(void)
;drs.c,17 :: 		TRISGbits.TRISG12 = 0;
	BCLR	TRISGbits, #12
;drs.c,18 :: 		LATGbits.LATG12 = 0;
	BCLR	LATGbits, #12
;drs.c,19 :: 		}
L_end_Drs_initVoltReg:
	RETURN
; end of _Drs_initVoltReg

_Drs_turnOnVoltReg:

;drs.c,21 :: 		void Drs_turnOnVoltReg(void)
;drs.c,23 :: 		LATGbits.LATG12 = 1;
	BSET	LATGbits, #12
;drs.c,24 :: 		}
L_end_Drs_turnOnVoltReg:
	RETURN
; end of _Drs_turnOnVoltReg

_Drs_turnOffVoltReg:

;drs.c,26 :: 		void Drs_turnOffVoltReg(void)
;drs.c,28 :: 		LATGbits.LATG12 = 0;
	BCLR	LATGbits, #12
;drs.c,29 :: 		}
L_end_Drs_turnOffVoltReg:
	RETURN
; end of _Drs_turnOffVoltReg

_Drs_open:

;drs.c,31 :: 		void Drs_open(void)
;drs.c,33 :: 		Drs_turnOnVoltReg();
	PUSH	W10
	CALL	_Drs_turnOnVoltReg
;drs.c,34 :: 		Drs_setDX(DRS_SERVO_DX_OPEN);
	MOV.B	#100, W10
	CALL	_Drs_setDX
;drs.c,35 :: 		Drs_setSX(DRS_SERVO_SX_OPEN);
	CLR	W10
	CALL	_Drs_setSX
;drs.c,36 :: 		drs_currentValue = 1;
	MOV	#1, W0
	MOV	W0, _drs_currentValue
;drs.c,38 :: 		drsFb = (unsigned int)drs_currentValue;
	MOV	#1, W0
	MOV	W0, _drsFb
;drs.c,39 :: 		sendUpdatesSW(DRS_CODE);
	MOV	#4, W10
	CALL	_sendUpdatesSW
;drs.c,41 :: 		}
L_end_Drs_open:
	POP	W10
	RETURN
; end of _Drs_open

_Drs_close:

;drs.c,43 :: 		void Drs_close(void)
;drs.c,45 :: 		Drs_setDX(DRS_SERVO_DX_CLOSE);
	PUSH	W10
	CLR	W10
	CALL	_Drs_setDX
;drs.c,46 :: 		Drs_setSX(DRS_SERVO_SX_CLOSE);
	MOV.B	#100, W10
	CALL	_Drs_setSX
;drs.c,47 :: 		timer1_drsCounter = 0;
	CLR	W0
	MOV	W0, _timer1_drsCounter
;drs.c,48 :: 		drs_currentValue = 0;
	CLR	W0
	MOV	W0, _drs_currentValue
;drs.c,50 :: 		drsFb = (unsigned int)drs_currentValue;
	CLR	W0
	MOV	W0, _drsFb
;drs.c,51 :: 		sendUpdatesSW(DRS_CODE);
	MOV	#4, W10
	CALL	_sendUpdatesSW
;drs.c,53 :: 		}
L_end_Drs_close:
	POP	W10
	RETURN
; end of _Drs_close

_Drs_setDX:

;drs.c,55 :: 		void Drs_setDX(unsigned char percentageDX) {
;drs.c,56 :: 		unsigned char actualPercentageDX = 0;
	PUSH	W10
;drs.c,57 :: 		if (percentageDX > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__Drs_setDX23
	GOTO	L_Drs_setDX0
L__Drs_setDX23:
;drs.c,58 :: 		actualPercentageDX = 100;
; actualPercentageDX start address is: 4 (W2)
	MOV.B	#100, W2
;drs.c,59 :: 		} else {
; actualPercentageDX end address is: 4 (W2)
	GOTO	L_Drs_setDX1
L_Drs_setDX0:
;drs.c,60 :: 		actualPercentageDX = percentageDX;
; actualPercentageDX start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentageDX end address is: 4 (W2)
;drs.c,61 :: 		}
L_Drs_setDX1:
;drs.c,62 :: 		DrsMotor_setPositionDX(100 - actualPercentageDX);
; actualPercentageDX start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_DrsMotor_setPositionDX
	POP	W2
;drs.c,63 :: 		drs_currentValueDX = actualPercentageDX;
	MOV	#lo_addr(_drs_currentValueDX), W0
	MOV.B	W2, [W0]
; actualPercentageDX end address is: 4 (W2)
;drs.c,64 :: 		}
L_end_Drs_setDX:
	POP	W10
	RETURN
; end of _Drs_setDX

_Drs_setSX:

;drs.c,66 :: 		void Drs_setSX(unsigned char percentageSX) {
;drs.c,67 :: 		unsigned char actualPercentageSX = 0;
	PUSH	W10
;drs.c,68 :: 		if (percentageSX > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__Drs_setSX25
	GOTO	L_Drs_setSX2
L__Drs_setSX25:
;drs.c,69 :: 		actualPercentageSX = 100;
; actualPercentageSX start address is: 4 (W2)
	MOV.B	#100, W2
;drs.c,70 :: 		} else {
; actualPercentageSX end address is: 4 (W2)
	GOTO	L_Drs_setSX3
L_Drs_setSX2:
;drs.c,71 :: 		actualPercentageSX = percentageSX;
; actualPercentageSX start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentageSX end address is: 4 (W2)
;drs.c,72 :: 		}
L_Drs_setSX3:
;drs.c,73 :: 		DrsMotor_setPositionSX(100 - actualPercentageSX);
; actualPercentageSX start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_DrsMotor_setPositionSX
	POP	W2
;drs.c,74 :: 		drs_currentValueSX = actualPercentageSX;
	MOV	#lo_addr(_drs_currentValueSX), W0
	MOV.B	W2, [W0]
; actualPercentageSX end address is: 4 (W2)
;drs.c,75 :: 		}
L_end_Drs_setSX:
	POP	W10
	RETURN
; end of _Drs_setSX

_Drs_getDX:

;drs.c,77 :: 		unsigned char Drs_getDX(void)
;drs.c,79 :: 		return drs_currentValueDX;
	MOV	#lo_addr(_drs_currentValueDX), W0
	MOV.B	[W0], W0
;drs.c,80 :: 		}
L_end_Drs_getDX:
	RETURN
; end of _Drs_getDX

_Drs_getSX:

;drs.c,82 :: 		unsigned char Drs_getSX(void)
;drs.c,84 :: 		return drs_currentValueSX;
	MOV	#lo_addr(_drs_currentValueSX), W0
	MOV.B	[W0], W0
;drs.c,85 :: 		}
L_end_Drs_getSX:
	RETURN
; end of _Drs_getSX

_Drs_get:

;drs.c,87 :: 		unsigned char Drs_get(void)
;drs.c,90 :: 		currentValueSX = Drs_getSX();
	CALL	_Drs_getSX
; currentvalueSX start address is: 2 (W1)
	MOV.B	W0, W1
;drs.c,91 :: 		currentValueDX = Drs_getDX();
	CALL	_Drs_getDX
; currentValueDX start address is: 4 (W2)
	MOV.B	W0, W2
;drs.c,93 :: 		&& currentValueDX < DRS_SERVO_CENTRAL_POSITION )
	MOV.B	#50, W0
	CP.B	W1, W0
	BRA GTU	L__Drs_get29
	GOTO	L__Drs_get14
L__Drs_get29:
	MOV.B	#50, W0
	CP.B	W2, W0
	BRA LTU	L__Drs_get30
	GOTO	L__Drs_get13
L__Drs_get30:
; currentvalueSX end address is: 2 (W1)
; currentValueDX end address is: 4 (W2)
L__Drs_get12:
;drs.c,95 :: 		return 1; //DRS open
	MOV.B	#1, W0
	GOTO	L_end_Drs_get
;drs.c,93 :: 		&& currentValueDX < DRS_SERVO_CENTRAL_POSITION )
L__Drs_get14:
; currentValueDX start address is: 4 (W2)
; currentvalueSX start address is: 2 (W1)
L__Drs_get13:
;drs.c,99 :: 		&& currentValueDX > DRS_SERVO_CENTRAL_POSITION )
	MOV.B	#50, W0
	CP.B	W1, W0
	BRA LTU	L__Drs_get31
	GOTO	L__Drs_get16
L__Drs_get31:
; currentvalueSX end address is: 2 (W1)
	MOV.B	#50, W0
	CP.B	W2, W0
	BRA GTU	L__Drs_get32
	GOTO	L__Drs_get15
L__Drs_get32:
; currentValueDX end address is: 4 (W2)
L__Drs_get11:
;drs.c,101 :: 		return 0; //DRS close
	CLR	W0
	GOTO	L_end_Drs_get
;drs.c,99 :: 		&& currentValueDX > DRS_SERVO_CENTRAL_POSITION )
L__Drs_get16:
L__Drs_get15:
;drs.c,104 :: 		}
L_end_Drs_get:
	RETURN
; end of _Drs_get
