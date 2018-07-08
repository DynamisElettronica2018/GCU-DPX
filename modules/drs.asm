
_Drs_insert:

;drs.c,10 :: 		void Drs_insert(void) {
;drs.c,11 :: 		Drs_set(100);
	PUSH	W10
	MOV.B	#100, W10
	CALL	_Drs_set
;drs.c,12 :: 		}
L_end_Drs_insert:
	POP	W10
	RETURN
; end of _Drs_insert

_Drs_release:

;drs.c,14 :: 		void Drs_release(void) {
;drs.c,15 :: 		Drs_set(0);
	PUSH	W10
	CLR	W10
	CALL	_Drs_set
;drs.c,16 :: 		}
L_end_Drs_release:
	POP	W10
	RETURN
; end of _Drs_release

_DRs_set:

;drs.c,18 :: 		void DRs_set(unsigned char percentage) {
;drs.c,19 :: 		unsigned char actualPercentage = 0;
	PUSH	W10
;drs.c,20 :: 		if (percentage > 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GTU	L__DRs_set5
	GOTO	L_DRs_set0
L__DRs_set5:
;drs.c,21 :: 		actualPercentage = 100;
; actualPercentage start address is: 4 (W2)
	MOV.B	#100, W2
;drs.c,22 :: 		} else {
; actualPercentage end address is: 4 (W2)
	GOTO	L_DRs_set1
L_DRs_set0:
;drs.c,23 :: 		actualPercentage = percentage;
; actualPercentage start address is: 4 (W2)
	MOV.B	W10, W2
; actualPercentage end address is: 4 (W2)
;drs.c,24 :: 		}
L_DRs_set1:
;drs.c,25 :: 		DrsMotor_setPosition(100 - actualPercentage);
; actualPercentage start address is: 4 (W2)
	MOV	#100, W1
	ZE	W2, W0
	SUB	W1, W0, W0
	PUSH	W2
	MOV.B	W0, W10
	CALL	_DrsMotor_setPosition
	POP	W2
;drs.c,26 :: 		Drs_currentValue = actualPercentage;
	MOV	#lo_addr(_drs_currentValue), W0
	MOV.B	W2, [W0]
; actualPercentage end address is: 4 (W2)
;drs.c,27 :: 		}
L_end_DRs_set:
	POP	W10
	RETURN
; end of _DRs_set

_Drs_get:

;drs.c,29 :: 		unsigned char Drs_get(void) {
;drs.c,30 :: 		return Drs_currentValue;
	MOV	#lo_addr(_drs_currentValue), W0
	MOV.B	[W0], W0
;drs.c,31 :: 		}
L_end_Drs_get:
	RETURN
; end of _Drs_get
