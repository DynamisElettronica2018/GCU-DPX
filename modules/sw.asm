
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
;sw.c,28 :: 		case DRS_CODE:
L_sendUpdatesSW2:
;sw.c,29 :: 		Can_addIntToWritePacket(DRS_CODE);
	MOV	#4, W10
	CALL	_Can_addIntToWritePacket
;sw.c,30 :: 		Can_addIntToWritePacket(drsFb);
	MOV	_drsFb, W10
	CALL	_Can_addIntToWritePacket
;sw.c,31 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,33 :: 		default:
L_sendUpdatesSW3:
;sw.c,34 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,35 :: 		}
L_sendUpdatesSW0:
	CP	W10, #4
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
