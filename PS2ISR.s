.section .exceptions, "ax"

.equ PS2, 0xFF200100
.equ GoMake_Break, 0x0000005A
.equ GoBreak1, 0x000000F0


PS2_ISR:
	movia r3,PS2
	rdctl et,ipending
	andi et,et,0x80
	beq et,r0,exit
 
	valid:
	ldw r5, 4(r3)
	andi r5,r5,0x100
	beq r5,r0,valid

	ldbuio r5,(r3)
	movia r6,GoBreak1
	beq r6,r5,breakcodecheck
	br exit

	breakcodecheck:
	ldbuio r5,(r3)
	movia r6,GoMake_Break
	beq r6,r5,break1
	br exit

	break1:
		movi r7, 1
		stw r7, 0(sp)
exit:
subi ea,ea,4

eret




