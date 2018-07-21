
_sendUpdatesSW:

;sw.c,5 :: 		void sendUpdatesSW(int valCode)
;sw.c,7 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	PUSH	W10
	CALL	_Can_resetWritePacket
	POP	W10
;sw.c,8 :: 		switch (valCode)
	GOTO	L_sendUpdatesSW0
;sw.c,11 :: 		case ACC_CODE:
L_sendUpdatesSW2:
;sw.c,12 :: 		Can_addIntToWritePacket(ACC_CODE);
	MOV	#1, W10
	CALL	_Can_addIntToWritePacket
;sw.c,13 :: 		Can_addIntToWritePacket(accelerationFb);
	MOV	_accelerationFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,14 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,34 :: 		default:
L_sendUpdatesSW3:
;sw.c,35 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,36 :: 		}
L_sendUpdatesSW0:
	CP	W10, #1
	BRA NZ	L__sendUpdatesSW5
	GOTO	L_sendUpdatesSW2
L__sendUpdatesSW5:
	GOTO	L_sendUpdatesSW3
L_sendUpdatesSW1:
;sw.c,37 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sw.c,38 :: 		Can_addIntToWritePacket(0);
	CLR	W10
	CALL	_Can_addIntToWritePacket
;sw.c,39 :: 		Can_write(GCU_FEEDBACK_ID);
	MOV	#793, W10
	MOV	#0, W11
	CALL	_Can_write
;sw.c,40 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW
