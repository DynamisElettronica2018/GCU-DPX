
_getTractionFb:

;traction.c,3 :: 		unsigned int getTractionFb()
;traction.c,5 :: 		return tractionFb;
	MOV	_tractionFb, W0
;traction.c,6 :: 		}
L_end_getTractionFb:
	RETURN
; end of _getTractionFb
