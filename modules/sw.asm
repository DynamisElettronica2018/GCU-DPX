
_sendUpdatesSW:

;sw.c,7 :: 		void sendUpdatesSW(unsigned int valCode)
;sw.c,9 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	PUSH	W10
	CALL	_Can_resetWritePacket
	POP	W10
;sw.c,10 :: 		switch (valCode)
	GOTO	L_sendUpdatesSW0
;sw.c,13 :: 		case ACC_CODE:
L_sendUpdatesSW2:
;sw.c,14 :: 		Can_addIntToWritePacket(ACC_CODE);
	MOV	#1, W10
	CALL	_Can_addIntToWritePacket
;sw.c,15 :: 		Can_addIntToWritePacket(accelerationFb);
	MOV	_accelerationFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,16 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,25 :: 		case TRACTION_CODE:
L_sendUpdatesSW3:
;sw.c,26 :: 		Can_addIntToWritePacket(TRACTION_CODE);
	MOV	#3, W10
	CALL	_Can_addIntToWritePacket
;sw.c,27 :: 		Can_addIntToWritePacket(tractionFb);
	MOV	_tractionFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,28 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,31 :: 		case DRS_CODE:
L_sendUpdatesSW4:
;sw.c,32 :: 		Can_addIntToWritePacket(DRS_CODE);
	MOV	#4, W10
	CALL	_Can_addIntToWritePacket
;sw.c,33 :: 		Can_addIntToWritePacket(drsFb);
	MOV	_drsFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,34 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,36 :: 		default:
L_sendUpdatesSW5:
;sw.c,37 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,38 :: 		}
L_sendUpdatesSW0:
	CP	W10, #1
	BRA NZ	L__sendUpdatesSW7
	GOTO	L_sendUpdatesSW2
L__sendUpdatesSW7:
	CP	W10, #3
	BRA NZ	L__sendUpdatesSW8
	GOTO	L_sendUpdatesSW3
L__sendUpdatesSW8:
	CP	W10, #4
	BRA NZ	L__sendUpdatesSW9
	GOTO	L_sendUpdatesSW4
L__sendUpdatesSW9:
	GOTO	L_sendUpdatesSW5
L_sendUpdatesSW1:
;sw.c,39 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sw.c,40 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sw.c,41 :: 		Can_write(GCU_FEEDBACK_ID);
	MOV	#793, W10
	MOV	#0, W11
	CALL	_Can_write
;sw.c,42 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW
