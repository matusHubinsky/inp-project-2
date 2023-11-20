# Result
- points: **15/15**

# Instructions
**AND** rd, rs, rt
Executes a bitwise AND between rs and rt, and puts the result into rd.

**DADDI** rt, rs, immediate
Executes the sum between 64-bits register rs and the immediate value, putting the result in rt. This instruction considers rs and the immediate value as signed values. If an overflow occurs then trap.

**DADDU** rd, rs, rt
Sums the content of 64-bits registers rs and rt, and puts the result into rd. No integer overflow occurs under any circumstances.

**DSUBU** rd, rs, rt
Subtracts the value of 64-bits register rt to 64-bits register rs, and puts the result in rd. No integer overflow occurs under any circumstances.

**DDIV** rs, rt
Executes the division between 64-bits registers rs and rt, putting the 64-bits quotient in LO and the 64-bits remainder in HI.

**SLT** rd, rs, rt
Sets the value of rd to 1 if the value of rs is less than the value of rt, otherwise sets it to 0. This instruction performs a signed comparison.

**BEQ** rs, rt, offset
Jumps to offset if rs is equal to rt.

**BNE** rs, rt, offset
Jumps to offset if rs is not equal to rt

**SW** rt, offset(base)
Stores the content of register rt in the memory cell specified by offset and base, treating it as a word.

**LB** rt, offset(base)
Loads the content of the memory cell at address specified by offset and base in register rt, treating it as a signed byte.

# Notes
https://edumips64.readthedocs.io/en/latest/instructions.html

r0:		zero register
r4:		result cipher
r9:		logical value
r11:	character index in cipher and xlogin
r22:	numbers(97, 26, ..)
r25:	bool value of the next state

# Debugging
`java -jar edumips64-1.2.10.jar -f xhubin04.x 
