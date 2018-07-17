
_sendUpdatesSW:

;sw.c,3 :: 		void sendUpdatesSW(unsigned int valCode)
;sw.c,5 :: 		Can_resetWritePacket();
	PUSH	W10
	PUSH	W11
	CALL	_Can_resetWritePacket
;sw.c,6 :: 		switch (valCode)
	GOTO	L_sendUpdatesSW0
;sw.c,32 :: 		default:
L_sendUpdatesSW2:
;sw.c,33 :: 		break;
	GOTO	L_sendUpdatesSW1
;sw.c,34 :: 		}
L_sendUpdatesSW0:
	GOTO	L_sendUpdatesSW2
L_sendUpdatesSW1:
;sw.c,35 :: 		Can_write(GCU_DEBUG_2_ID);
	MOV	#791, W10
	MOV	#0, W11
	CALL	_Can_write
;sw.c,36 :: 		}
L_end_sendUpdatesSW:
	POP	W11
	POP	W10
	RETURN
; end of _sendUpdatesSW
