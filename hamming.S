		;		ARM Programming Assignment #4: Encode in Hamming(15, 11)
		;
		;		Write a subroutine that encodes 11 bits of data into a 15-bit
		;		block, using 4 parity bits. Assume even parity, that is,
		;		the parity of the bits covered by a parity bit, including
		;		the parity bit, has to be an even number. Assume the bits are
		;		written in the following sequence: p1, p2, d1, p4, d2, d3, d4,
		;		p8, d5, d6, d7, d8, d9, d10, d11, p16, d12, d13, d14, d15.
		;		Call the subroutine `hencode`.
		;
		;		Write a subroutine that decodes a H(15, 11) block to extract
		;		the 11 data bits. Call it `hdecode`. It should:
		;		- calculate the correcting code
		;		- dentify the case: no error (noer), one-bit error (onee)
		;		- write the result in `case` using the encoding provided
		;		- if there is a one-bit error, write the number of the
		;		erroneous bit in `berr`
		;		- if there is a one-bit error, correct the data
		;		- write the result in `corr`
		;
		;		Now, write a main function which uses `hencode` and `decode`
		;		to encode `data` and then, after a simulated transmission,
		;		decode `recv`. Assume that `recv` contains what is received
		;		at the other end.
		
		;		Your code here
		
		;		Load a test value into R1
START
		ADR		R10, data
		
		LDR		R1, [R10]
		

		
		AND		R2, R1, #0x1		; Clear all bits apart from d0
		MOV		R0, R2, LSL #2		; Align data bit d0
		
		AND		R2, R1, #0xE		; Clear all bits apart from d1, d2, & d3
		ORR		R0, R0, R2, LSL #3	; Align data bits d1, d2 & d3 and combine with d0
		
		AND		R2, R1, #0xF0		; Clear all bits apart from d3-d7
		ORR		R0, R0, R2, LSL #7	; Align data bits d4-d7 and combine with d0-d3
		

		
		;		Generate check bit c0
		
		EOR		R2, R0, R0, LSR #2	; Generate c0 parity bit using parity tree
		EOR		R2, R2, R2, LSR #4	; ... second iteration ...
		EOR		R2, R2, R2, LSR #8	; ... final iteration
		
		AND		R2, R2, #0x1		; Clear all but check bit c0
		ORR		R0, R0, R2		; Combine check bit c0 with result
		
		;		Generate check bit c1
		
		EOR		R2, R0, R0, LSR #1	; Generate c1 parity bit using parity tree
		EOR		R2, R2, R2, LSR #4	; ... second iteration ...
		EOR		R2, R2, R2, LSR #8	; ... final iteration
		
		AND		R2, R2, #0x2		; Clear all but check bit c1
		ORR		R0, R0, R2		; Combine check bit c1 with result
		
		;		Generate check bit c2
		
		EOR		R2, R0, R0, LSR #1	; Generate c2 parity bit using parity tree
		EOR		R2, R2, R2, LSR #2	; ... second iteration ...
		EOR		R2, R2, R2, LSR #8	; ... final iteration
		
		AND		R2, R2, #0x8		; Clear all but check bit c2
		ORR		R0, R0, R2		; Combine check bit c2 with result
		
		;		Generate check bit c3
		
		EOR		R2, R0, R0, LSR #1	; Generate c3 parity bit using parity tree
		EOR		R2, R2, R2, LSR #2	; ... second iteration ...
		EOR		R2, R2, R2, LSR #4	; ... final iteration
		
		AND		R2, R2, #0x80		; Clear all but check bit c3
		ORR		R0, R0, R2		; Combine check bit c3 with result
		

		
		EOR		R0, R0, #0x100		; Flip bit 8 to test
		

		
		
		;Clear	bits c0, c1, c3, c7
		LDR		R3, =0XFFFFFF74
		AND		R3, R0, R3
		
		
		
		;		Generate check bit c0
		
		EOR		R2, R3, R3, LSR #2	; Generate c0 parity bit using parity tree
		EOR		R2, R2, R2, LSR #4	; ... second iteration ...
		EOR		R2, R2, R2, LSR #8	; ... final iteration
		
		AND		R2, R2, #0x1		; Clear all but check bit c0
		ORR		R3, R3, R2		    ; Combine check bit c0 with result
		
		;		Generate check bit c1
		
		EOR		R2, R3, R3, LSR #1	; Generate c1 parity bit using parity tree
		EOR		R2, R2, R2, LSR #4	; ... second iteration ...
		EOR		R2, R2, R2, LSR #8	; ... final iteration
		
		AND		R2, R2, #0x2		; Clear all but check bit c1
		ORR		R3, R3, R2		; Combine check bit c1 with result
		
		;		Generate check bit c2
		
		EOR		R2, R3, R3, LSR #1	; Generate c2 parity bit using parity tree
		EOR		R2, R2, R2, LSR #2	; ... second iteration ...
		EOR		R2, R2, R2, LSR #8	; ... final iteration
		
		AND		R2, R2, #0x8		; Clear all but check bit c2
		ORR		R3, R3, R2		; Combine check bit c2 with result
		
		;		Generate check bit c3
		
		EOR		R2, R3, R3, LSR #1	; Generate c3 parity bit using parity tree
		EOR		R2, R2, R2, LSR #2	; ... second iteration ...
		EOR		R2, R2, R2, LSR #4	; ... final iteration
		
		AND		R2, R2, #0x80		; Clear all but check bit c3
		ORR		R3, R3, R2		; Combine check bit c3 with result
		
		
	
		EOR		R1, R0, R3
		
		

		LDR		R4, =0X80
		AND		R4, R4, R1
		MOV		R4, R4, LSR #4
		

		LDR		R5, =0X8
		AND		R5, R5, R1
		MOV		R5, R5, LSR #1
		
		;Clearing	all bits apart from c0 and c1
		LDR		R6, =0X3
		AND		R6, R6, R1
		
		
		;Adding	the 4 registers together
		ADD		R1, R4, R5
		ADD		R1, R1, R6
		
		;Subtracting	1 from R1 to determine the bit position of the error
		SUB		R1, R1, #1
		
	
		LDR		R7, =0X1
		MOV		R7, R7, LSL R1
		
		EOR		R0, R0, R7
		
		
	
		
		
		
		END
		
data		DCD		0b10100100101
recv		DCD		0b101111010100101
		
noer		DCD		0x00
onee		DCD		0x01
		
case		FILL		4
berr		FILL		4
corr		FILL		4
