/*pwm function*/

#lab4
#timer subroutine

.equ TIMER, 0xFF202000
.equ time, 37500000

.section .text
.global stop


stop:
#storing callee save registers onto the stack
	addi sp, sp, -16
	stw r16, 0(sp)
	stw r17, 4(sp)
	stw r18, 8(sp)
	stw r19, 12(sp)

#r16 has address of TIMER
#store counter start value low and high
	movia r16, TIMER 
	movui r17, %lo(time) 
	stwio r17, 8(r16) 
	movui r17, %hi (time) 
	stwio r17, 12(r16)

	
#start the timer
	stwio r0,0(r16)
	movi r17, 0b100
	stwio r17, 4(r16)

#wait for 3 seconds	
POLL:
	ldwio r17, (r16)
	andi r17, r17, 0b1
	beq r17, r0, POLL
	
#pop off stack
	ldw r16, 0(sp)
	addi sp, sp, 4
	ldw r17, 0(sp)
	addi sp, sp, 4
	ldw r18, 0(sp)
	addi sp, sp, 4
	ldw r19, 0(sp)
	addi sp, sp, 4

#return
ret




	