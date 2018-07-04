
_initTraction:

;traction.c,9 :: 		void initTraction(void)
;traction.c,11 :: 		int i = 0;
; i start address is: 4 (W2)
	CLR	W2
;traction.c,12 :: 		tractionVariable[i] = UNSET_TRACTION;
	SL	W2, #1, W1
	MOV	#lo_addr(_tractionVariable), W0
	ADD	W0, W1, W1
	CLR	W0
	MOV	W0, [W1]
;traction.c,13 :: 		i++;
	ADD	W2, #1, W0
	MOV	W0, W2
;traction.c,14 :: 		tractionVariable[i] = FIRST_TRACTION_VARIABLES;
	SL	W0, #1, W1
	MOV	#lo_addr(_tractionVariable), W0
	ADD	W0, W1, W1
	CLR	W0
	MOV	W0, [W1]
; i end address is: 4 (W2)
;traction.c,15 :: 		for (; i <= MAX_TRACTION_VARIABLES; i++)
L_initTraction0:
; i start address is: 4 (W2)
	CP	W2, #8
	BRA LE	L__initTraction4
	GOTO	L_initTraction1
L__initTraction4:
;traction.c,17 :: 		tractionVariable[i] = FIRST_TRACTION_VARIABLES + STEP_TRACTION_VARIABLES;
	SL	W2, #1, W1
	MOV	#lo_addr(_tractionVariable), W0
	ADD	W0, W1, W1
	MOV	#100, W0
	MOV	W0, [W1]
;traction.c,15 :: 		for (; i <= MAX_TRACTION_VARIABLES; i++)
	INC	W2
;traction.c,18 :: 		}
; i end address is: 4 (W2)
	GOTO	L_initTraction0
L_initTraction1:
;traction.c,20 :: 		}
L_end_initTraction:
	RETURN
; end of _initTraction

_Efi_setTraction:

;traction.c,22 :: 		Efi_setTraction(unsigned int setState)
;traction.c,24 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	PUSH	W10
	CALL	_Can_resetWritePacket
	POP	W10
;traction.c,25 :: 		Can_addIntToWritePacket(setState);
	CALL	_Can_addIntToWritePacket
;traction.c,26 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;traction.c,27 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;traction.c,28 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;traction.c,29 :: 		Can_write(GCU_TRACTION_CONTROL_EFI_ID);
	MOV	#1280, W10
	MOV	#0, W11
	CALL	_Can_write
;traction.c,31 :: 		}
L_end_Efi_setTraction:
	POP	W11
	POP	W10
	RETURN
; end of _Efi_setTraction
