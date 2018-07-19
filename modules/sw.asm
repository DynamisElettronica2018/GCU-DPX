
_sendUpdatesSW:

;sw.c,4 :: 		void sendUpdatesSW(unsigned int valCode)
;sw.c,6 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	PUSH	W10
	CALL	_Can_resetWritePacket
	POP	W10
;sw.c,7 :: 		switch (valCode)
	GOTO	L_sendUpdatesSW0
;sw.c,22 :: 		case TRACTION_CODE:
L_sendUpdatesSW2:
;sw.c,23 :: 		Can_addIntToWritePacket(TRACTION_CODE);
	MOV	#3, W10
	CALL	_Can_addIntToWritePacket
;sw.c,24 :: 		Can_addIntToWritePacket(tractionFb);
	MOV	_tractionFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,25 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,33 :: 		default:
L_sendUpdatesSW3:
;sw.c,34 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,35 :: 		}
L_sendUpdatesSW0:
	CP	W10, #3
	BRA NZ	L__sendUpdatesSW5
	GOTO	L_sendUpdatesSW2
L__sendUpdatesSW5:
	GOTO	L_sendUpdatesSW3
L_sendUpdatesSW1:
;sw.c,36 :: 		Can_write(GCU_FEEDBACK_ID);
	MOV	#793, W10
	MOV	#0, W11
	CALL	_Can_write
;sw.c,37 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW
