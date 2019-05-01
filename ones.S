		;		ARM Programming Assignment #4: Count the ones in a binary number
		;
		;		Write a program that counts the number of ones in a binary number,
		;		stored in a word (4 bytes). Its loop should run no more times than there
		;		are ones in the number. Write the count in `numones`. For the example
		;		number given below, the loop should only run 8 times, counting 8 ones.
		;
		;		Hint:
		;		The first significant instruction in the loop is SUB r1, r1, 1, which
		;		decrements the number, assuming it's stored in register r1. Now,
		;		remember your logical operations.
		;
		;		Bonus:
		;		1. (20 extra points) For the shortest program (by instruction count),
		;		because this operation has to be FAST.
		;		2. (30 extra points) For extending the program to counting the ones
		;		in any word-aligned contiguous region of memory.
		
		;		Your code here
		ADR		R10, example        ;put number in r1
		adr		r11, numones
		ldr		R1,[R10]           ; load number in ragister R1
		MOV		R2, #0             ; Initialize r2 as 0
loop		LSRS		R1, R1, #1         ; Right shift r1 and set carry flag 1 if the last bit is 1
		ADDCS	R2, R2, #1         ; Add 1 if the last bit is 1
		
		BNE		loop
		str		R2, [r11]
		end
		
		
done
		
example	DCD		0x0010070f
numones	FILL		4
