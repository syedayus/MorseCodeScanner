 .equ AUDIO, 0xFF203040


 .global audio
 audio:

	#SAVE CALLEE SAVED REGISTERS ON STACK
	addi sp, sp, -32
	stw r16, 0(sp)
	stw r17, 4(sp)
	stw r18, 8(sp)
	stw r19, 12(sp)
	stw r20, 16(sp)
	stw r21, 20(sp)
	stw r22, 24(sp)
	stw r23, 28(sp)
	
	/*initialize sounds*/

	movia r20, AUDIO /*address of audio*/
	addi r21, r21, 0
	movi r8, 48
	mov r9, r8
	mov r18, r0	
	
	
	#counter
	mov r10, r0
	movi r12, 200
	
		waitForWriteSpace:
		beq r10, r12, exit
			ldwio r3, 4(r20)
			andhi r23, r3, 65280
			beq r23, r0, waitForWriteSpace
			andhi r23, r3, 255
			beq r23, r0, waitForWriteSpace

		writeTwoSamples:
   
			add r3,r18,r4

			ldwio r21, (r3)
			stwio r21, 8(r20)
			stwio r21, 12(r20)
			addi r18,r18,8
			addi r9, r9, -1
			bne r9, r0, waitForWriteSpace
		
		halfPeriodInvertWaveform:
			mov r9, r8
			sub r21, r0,r21
			
			addi r10, r10, 1
			
			br waitForWriteSpace

exit: 
#POP CALLEE SAVED REGISTERS FROM STACK
	ldw r16, 0(sp)
	addi sp, sp, 4
	ldw r17, 0(sp)
	addi sp, sp, 4
	ldw r18, 0(sp)
	addi sp, sp, 4
	ldw r19, 0(sp)
	addi sp, sp, 4
	ldw r20, 0(sp)
	addi sp, sp, 4
	ldw r21, 0(sp)
	addi sp, sp, 4
	ldw r22, 0(sp)
	addi sp, sp, 4
	ldw r23, 0(sp)
	addi sp, sp, 4	

ret
