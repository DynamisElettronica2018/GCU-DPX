
_traction_init:

;traction.c,12 :: 		void traction_init(void)
;traction.c,14 :: 		tractionLoadDefaultsSettings();
	CALL	_tractionLoadDefaultsSettings
;traction.c,15 :: 		}
L_end_traction_init:
	RETURN
; end of _traction_init

_tractionLoadDefaultsSettings:

;traction.c,17 :: 		void tractionLoadDefaultsSettings(void)
;traction.c,20 :: 		traction_parameters[TRACTION_0] = DEF_TRACTION_0;
	CLR	W0
	MOV	W0, _traction_parameters
;traction.c,21 :: 		traction_parameters[TRACTION_1] = DEF_TRACTION_1;
	MOV	#100, W0
	MOV	W0, _traction_parameters+2
;traction.c,22 :: 		traction_parameters[TRACTION_2] = DEF_TRACTION_2;
	MOV	#200, W0
	MOV	W0, _traction_parameters+4
;traction.c,23 :: 		traction_parameters[TRACTION_3] = DEF_TRACTION_3;
	MOV	#300, W0
	MOV	W0, _traction_parameters+6
;traction.c,24 :: 		traction_parameters[TRACTION_4] = DEF_TRACTION_4;
	MOV	#400, W0
	MOV	W0, _traction_parameters+8
;traction.c,25 :: 		traction_parameters[TRACTION_5] = DEF_TRACTION_5;
	MOV	#500, W0
	MOV	W0, _traction_parameters+10
;traction.c,26 :: 		traction_parameters[TRACTION_6] = DEF_TRACTION_6;
	MOV	#600, W0
	MOV	W0, _traction_parameters+12
;traction.c,27 :: 		traction_parameters[TRACTION_7] = DEF_TRACTION_7;
	MOV	#700, W0
	MOV	W0, _traction_parameters+14
;traction.c,29 :: 		}
L_end_tractionLoadDefaultsSettings:
	RETURN
; end of _tractionLoadDefaultsSettings

_setTraction:

;traction.c,31 :: 		setTraction(unsigned int codeValue, unsigned int tractionValue)
;traction.c,33 :: 		Efi_setTraction(tractionValue);
	PUSH	W10
	MOV	W11, W10
	CALL	_Efi_setTraction
	POP	W10
;traction.c,34 :: 		sendUpdatesSW(codeValue);
	CALL	_sendUpdatesSW
;traction.c,35 :: 		}
L_end_setTraction:
	RETURN
; end of _setTraction

_Efi_setTraction:

;traction.c,38 :: 		Efi_setTraction(unsigned int setTractionValue)
;traction.c,40 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	PUSH	W10
	CALL	_Can_resetWritePacket
	POP	W10
;traction.c,41 :: 		Can_addIntToWritePacket(setTractionValue);
	CALL	_Can_addIntToWritePacket
;traction.c,42 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;traction.c,43 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;traction.c,44 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;traction.c,45 :: 		Can_write(GCU_TRACTION_CONTROL_EFI_ID);
	MOV	#1280, W10
	MOV	#0, W11
	CALL	_Can_write
;traction.c,47 :: 		}
L_end_Efi_setTraction:
	POP	W11
	POP	W10
	RETURN
; end of _Efi_setTraction
