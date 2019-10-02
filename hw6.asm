; Kim Huynh
; CS150
; hw6.asm
; DUE 5/3/2019 

; --> ID number : 3743

; 16 mil clock cycle per sec
; 0x05 = PORTB
; 0x04 = DDRB

 .ORG   0x00
 RJMP   start                   

 start:
	LDI    r16, 0xFF               ; Fills in all bits
	OUT    0x04, r16               ; Make all pins into output (DDRB)
	LDI    r25, 0x20               ; 0x20=ON, Use on PORTB, or 0x05
	LDI    r26, 0x00               ; 0x00=OFF, Use on PORTB, or 0x05

 loop:
	RCALL blinkThree

	RCALL delayOneSec ; NOTE: Due to the extra second placed before blink,
	RCALL delayOneSec ; only 2 seconds need here to make full 3 seconds. :)

	RCALL blinkSeven

	RCALL delayOneSec ; See above note.
	RCALL delayOneSec

	RCALL blinkFour

	RCALL delayOneSec ; See above note.
	RCALL delayOneSec

	RCALL blinkThree

	RCALL delayThreeSec ; Same logic as above note.
	RCALL delayOneSec   ; Only 4 seconds here to make full 5 seconds. 

	RJMP   loop                    

 delayOneSec: ; Delays one second
	LDI r20, -0x01
	LDI r21, 1
	LDI r22, 0x5A     ; 90   
	LDI r23, 0x5A 

 delayOneSecLoop: ; I want to use up as many machine cycles as possible!
	ADD r21, r20
	BRBC 1, delayOneSecLoop
	ADD r22, r20
	BRBC 1, delayOneSecLoop
	ADD r23, r20
	BRBC 1, delayOneSecLoop
	NOP
	RET 

 delayThreeSec: ; Delays three seconds 
	RCALL delayOneSec 
	RCALL delayOneSec
	RCALL delayOneSec
	RET

 delayFiveSec: ; Delays five seconds
	RCALL delayThreeSec
	RCALL delayOneSec
	RCALL delayOneSec
	RET

 blinkOneDot: ; Blinks for one second = dot.
	RCALL  delayOneSec
	OUT 0x05, r25              
	RCALL  delayOneSec
	OUT 0x05, r26 
	RET 

 blinkLongDash: ; Blinks for three seconds = dash. 
	RCALL  delayOneSec
	OUT 0x05, r25       
	RCALL delayThreeSec
	OUT 0x05, r26 
	RET

 blinkThree: ; Blinks . . . _ _
	RCALL blinkOneDot
	RCALL blinkOneDot
	RCALL blinkOneDot
	RCALL blinkLongDash 
	RCALL blinkLongDash
	RET 

 blinkSeven: ; Blinks _ _ . . .
	RCALL blinkLongDash 
	RCALL blinkLongDash
	RCALL blinkOneDot
	RCALL blinkOneDot
	RCALL blinkOneDot
	RET 

 blinkFour: ; Blinks . . . . _ 
	RCALL blinkOneDot
	RCALL blinkOneDot
	RCALL blinkOneDot
	RCALL blinkOneDot
	RCALL blinkLongDash
	RET
	
 

