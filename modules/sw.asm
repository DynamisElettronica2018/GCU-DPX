
_sendUpdatesSW:

;sw.c,6 :: 		void sendUpdatesSW(unsigned int valCode)
;sw.c,8 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	PUSH	W10
	CALL	_Can_resetWritePacket
	POP	W10
;sw.c,9 :: 		switch (valCode)
	GOTO	L_sendUpdatesSW0
;sw.c,12 :: 		case ACC_CODE:
L_sendUpdatesSW2:
;sw.c,13 :: 		Can_addIntToWritePacket(ACC_CODE);
	MOV	#1, W10
	CALL	_Can_addIntToWritePacket
;sw.c,14 :: 		Can_addIntToWritePacket(accelerationFb);
	MOV	_accelerationFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,15 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,24 :: 		case TRACTION_CODE:
L_sendUpdatesSW3:
;sw.c,25 :: 		Can_addIntToWritePacket(TRACTION_CODE);
	MOV	#3, W10
	CALL	_Can_addIntToWritePacket
;sw.c,26 :: 		Can_addIntToWritePacket(tractionFb);
	MOV	_tractionFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,27 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,35 :: 		default:
L_sendUpdatesSW4:
;sw.c,36 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,37 :: 		}
L_sendUpdatesSW0:
	CP	W10, #1
	BRA NZ	L__sendUpdatesSW6
	GOTO	L_sendUpdatesSW2
L__sendUpdatesSW6:
	CP	W10, #3
	BRA NZ	L__sendUpdatesSW7
	GOTO	L_sendUpdatesSW3
L__sendUpdatesSW7:
	GOTO	L_sendUpdatesSW4
L_sendUpdatesSW1:
;sw.c,38 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sw.c,39 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sw.c,40 :: 		Can_write(GCU_FEEDBACK_ID);
	MOV	#793, W10
	MOV	#0, W11
	CALL	_Can_write
;sw.c,41 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW
