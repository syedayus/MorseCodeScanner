.equ ADDR_JP2_EDGE, 0xFF20007C
.equ ADDR_LED, 0xFF200000
.equ ADDR_JP2, 0xFF200070 #adress of JP2
.equ ADDR_JP2_IRQ, 0x1000 #IRQ line for GPIO JP2 (IRQ12)
.equ ADDR_CHAR, 0x09000000 # character buffer VGA
.equ ADDR_VGA, 0x08000000
.equ PS2, 0xFF200100

 .equ TIMER, 0xFF202020
 .equ time, 0xFFFFFFFF
 
 .equ AUDIO, 0xFF203040
 
 .equ A,0x00000021 #65
 .equ B,0x00001112 #66
 .equ C,0x00001212 #67
 .equ D,0x00000112 #68
 .equ E,0x00000001 #69
 .equ F,0x00001211 #70
 .equ G,0x00000122 #71
 .equ H,0x00001111 #72
 .equ I,0x00000011 #73
 .equ J,0x00002221 #74
 .equ K,0x00000212 #75
 .equ L,0x00001121 #76
 .equ M,0x00000022 #77
 .equ N,0x00000012 #78
 .equ O,0x00000222 #79
 .equ P,0x00001221 #80
 .equ Q,0x00002122 #81
 .equ R,0x00000121 #82
 .equ S,0x00000111 #83
 .equ T,0x00000002 #84
 .equ U,0x00000211 #85
 .equ V,0x00002111 #86
 .equ W,0x00000221 #87
 .equ X,0x00002112 #88
 .equ Y,0x00002212 #89
 .equ Z,0x00001122 #90
 .equ space, 0x00000000 #32
 
 .equ lowerBound, 125000000# 2.5 seconds #150000000 #3 seconds
 .equ upperBound, 250000000# 5 seconds #350000000 # 7 seconds
 .equ second, 50000000
 
 .section .data
 background: .incbin "background.bin"
 startScreen: .incbin "start.bin"
 
 Asound: .incbin "A2.wav"
 Bsound: .incbin "B2.wav"
 Csound: .incbin "C2.wav"
 Dsound: .incbin "D2.wav"
 Esound: .incbin "E2.wav"
 Fsound: .incbin "F2.wav"
 Gsound: .incbin "G2.wav"
 Hsound: .incbin "H2.wav"
 Jsound: .incbin "J2.wav"
 Isound: .incbin "I2.wav"
 Ksound: .incbin "K2.wav"
 Lsound: .incbin "L2.wav"
 Msound: .incbin "M2.wav"
 Nsound: .incbin "N2.wav"
 Osound: .incbin "O2.wav"
 Psound: .incbin "P2.wav"
 Qsound: .incbin "Q2.wav"
 Rsound: .incbin "R2.wav"
 Ssound: .incbin "S2.wav"
 Tsound: .incbin "T2.wav"
 Usound: .incbin "U2.wav"
 Vsound: .incbin "V2.wav"
 Wsound: .incbin "W2.wav"
 Xsound: .incbin "X2.wav"
 Ysound: .incbin "Y2.wav"
 Zsound: .incbin "Z2.wav"
  
 

.section .text
.global main
main:
	
	
	call clear_screen #C function which clears the screen
	
	
	 movia r2,ADDR_VGA # move address of vga
 
	movui r3,0x0140 #320 to the address value of the VGA
	movui r6, 0x00f0 #240 
	mov r7,r0 #x counter
	mov r8,r0 #y counter
	mov r9,r2 #address of vga we are writing to
	movia r10,1024
	movia r11,2
  
	  movia r5, startScreen #address of bin file  
	  addi r5,r5,16

	  #display the background
	  Loop2Start:
		  Loop1Start: #going upto 0 0 to 320 0
		  
			  ldh r4,(r5)		  
			  sthio r4,(r9)

			  addi r7,r7,1 #increment 1 to the x counter
			  
			  addi r5,r5,2 #used to be 16
			  mul r11,r11,r7
			  mul r10,r10,r8 
			  
			  mov r9,r2
			  add r9,r9,r11
			  add r9,r9,r10
			  
			  movi r11, 2
			  movi r10, 1024

		  blt r7,r3,Loop1Start
	  
		  mov r7,r0
		  addi r8,r8,1
	  
	  blt r8,r6,Loop2Start
 
 
 
	#enable interupts
	
	movia r3,PS2
	movi  r4,1
	stwio r4,4(r3)

	movui r9,0x80
	wrctl ienable,r9

	movi r9,0b1
	wrctl status,r9

	
	#check if user has pressed go by checking flag r7
	addi sp, sp, -4
	stw r0, 0(sp)
	
	ldw r7,0(sp)
	movi r8, 1

wait:  
	ldw r7,0(sp)
	beq r7, r8, startProgram
	br wait


	#turn off interupts
	mov r9, r0
	wrctl status, r9
	
startProgram: 	
  movia r2,ADDR_VGA # move address of vga
 
  movui r3,0x0140 #320 to the address value of the VGA
  movui r6, 0x00f0 #240 
  mov r7,r0 #x counter
  mov r8,r0 #y counter
  mov r9,r2 #address of vga we are writing to
  movia r10,1024
  movia r11,2
  
  movia r5, background #address of bin file  
  addi r5,r5,16

  #display the background
  Loop2:
	  Loop1: #going upto 0 0 to 320 0
	  
		  ldh r4,(r5)		  
		  sthio r4,(r9)

		  addi r7,r7,1 #increment 1 to the x counter
		  
		  addi r5,r5,2 #used to be 16
		  mul r11,r11,r7
		  mul r10,r10,r8 
		  
		  mov r9,r2
		  add r9,r9,r11
		  add r9,r9,r10
		  
		  movi r11, 2
		  movi r10, 1024

	  blt r7,r3,Loop1
  
	  mov r7,r0
	  addi r8,r8,1
  
  blt r8,r6,Loop2
 
	
	movia r8, ADDR_JP2
	movia r9, 0x07f557ff #set motors as output and sensors as inout
	stwio r9, 4(r8) #load into the direction register
	
	movia r9, 0xFFFFFFFF /*initialize all motors and sensors to be off*/
	stwio r9, 0(r8)
	
	mov r10, r0 #dot dash counter
	movi r12, 7 #threshold value
	mov r14, r0 #r14 has value of the current letter being read
	mov r13, r0 #state of the sensor (above threshold=1, below threshold=0) 
	movi r18, 4 #initial offset
	mov r1, r0
	
	#r16 has address of TIMER
	#store counter start value low and high
	movia r16, TIMER 
	movui r17, %lo(time) 
	stwio r17, 8(r16) 
	movui r17, %hi (time) 
	stwio r17, 12(r16)

	#start the timer
#	stwio r0,0(r16)
#	movi r17, 0b100
#	stwio r17, 4(r16)	
	
	LOOP:

		br loopS0 /*poll sensor 0*/
				
		
		TURN_OFF: /*code for turning off leds*/
		
		
			/*turn on the led to test if working*/
				movia r2, ADDR_LED
				movi r3, 0x0
				stwio r3, 0(r2)	
				
			/*take a snap shot before the sensor goes above the threshold*/
			
			movi r2, 1 
			beq r13, r2, afterSnap
			beq r13, r0, beforeSnap
			
			beforeSnap:
				 #start the timer
				stwio r0,0(r16)
				movi r17, 0b100
				stwio r17, 4(r16)
				
				stwio r0,16(r16)              # Tell Timer to take a snapshot of the timer 
				ldwio r3,16(r16)              # Read snapshot bits 0..15 
				ldwio r4,20(r16)              # Read snapshot bits 16...31 
				slli  r4,r4,16		         # Shift left logically
				or    r4,r4,r3 				 # r4=snap shot after dot/dash
			
			br loopS0
			
			afterSnap:
				stwio r0,16(r16)              # Tell Timer to take a snapshot of the timer 
				ldwio r3,16(r16)              # Read snapshot bits 0..15 
				ldwio r5,20(r16)              # Read snapshot bits 16...31 
				slli  r5,r5,16		         # Shift left logically
				or    r5,r5,r3 				 #r5=snap shot after dot/dash
				
				sub r6, r4, r5				 #get the difference in time before and after the dot/dash
				mov r13, r0					 #reset the above/below threshold register to 0
				
				movia r7, upperBound
				bgt r6, r7, detectLetter #r6>upperBound
				
				movia r7, lowerBound
				bgt r6, r7, dash #r6>lowerBound
										
				br dot
					
				dot: 
					movi r7, 0x1 
					muli r9, r10, 4 
					sll r7, r7, r9
					or r14, r14, r7
					
					addi r10, r10, 1
					#movi r6, 4
					#beq r10, r6, detectLetter #check if counter is 4 
					
					
					
					movia r2, ADDR_VGA
					add r2, r2, r1
					movui r3, 0xffff 
					mov r6,r0
					addi r6,r6,30740
					add r2,r6,r2
					sthio r3, 30740(r2)
					addi r1, r1, 10
					
					
						
				br loopS0
				
				dash:
					movi r7, 0x2 
					muli r9, r10, 4 
					sll r7, r7, r9
					or r14, r14, r7
									
					addi r10, r10, 1

					movia r2, ADDR_VGA
					add r2, r2, r1
					movui r3, 0xffff 
					mov r6,r0
					addi r6,r6,30740
					add r2,r6,r2
					sthio r3, 30740(r2)
					sthio r3, 30742(r2)
					sthio r3, 30744(r2)
					addi r1, r1, 14
				
		loopS0:
							/*turn motor on and forward*/
							movia	 r9, 0xfffffffc        
							stwio	 r9, 0(r8)	
							
							/*store all used registers on the stack*/
							addi sp, sp, -60
							stw r1, 0(sp)
							stw r2, 4(sp)
							stw r3, 8(sp)
							stw r4, 12(sp)
							stw r5, 16(sp)
							stw r6, 20(sp)
							stw r7, 24(sp)
							stw r8, 28(sp)
							stw r9, 32(sp)
							stw r10, 36(sp)
							stw r11, 40(sp)
							stw r12, 44(sp)	
							stw r13, 48(sp)
							stw r14, 52(sp)
							stw r15, 56(sp)
							
							
							/*call the function to delay*/
							call go
							
							/*store all used registers on the stack*/
							ldw r1, 0(sp)
							addi sp, sp, 4
							ldw r2, 0(sp)
							addi sp, sp, 4
							ldw r3, 0(sp)
							addi sp, sp, 4
							ldw r4, 0(sp)
							addi sp, sp, 4
							ldw r5, 0(sp)
							addi sp, sp, 4
							ldw r6, 0(sp)
							addi sp, sp, 4
							ldw r7, 0(sp)
							addi sp, sp, 4
							ldw r8, 0(sp)
							addi sp, sp, 4
							ldw r9, 0(sp)
							addi sp, sp, 4
							ldw r10, 0(sp)
							addi sp, sp, 4
							ldw r11, 0(sp)
							addi sp, sp, 4
							ldw r12, 0(sp)
							addi sp, sp, 4
							ldw r13, 0(sp)
							addi sp, sp, 4
							ldw r14, 0(sp)
							addi sp, sp, 4
							ldw r15, 0(sp)
							addi sp, sp, 4							
							
							/*turn motor off*/
							movia	 r9, 0xffffffff        
							stwio	 r9, 0(r8)	
							
							addi sp, sp, -60
							stw r1, 0(sp)
							stw r2, 4(sp)
							stw r3, 8(sp)
							stw r4, 12(sp)
							stw r5, 16(sp)
							stw r6, 20(sp)
							stw r7, 24(sp)
							stw r8, 28(sp)
							stw r9, 32(sp)
							stw r10, 36(sp)
							stw r11, 40(sp)
							stw r12, 44(sp)	
							stw r13, 48(sp)
							stw r14, 52(sp)
							stw r15, 56(sp)
							
							/*call the function to delay*/
							call stop
							
							/*store all used registers on the stack*/
							ldw r1, 0(sp)
							addi sp, sp, 4
							ldw r2, 0(sp)
							addi sp, sp, 4
							ldw r3, 0(sp)
							addi sp, sp, 4
							ldw r4, 0(sp)
							addi sp, sp, 4
							ldw r5, 0(sp)
							addi sp, sp, 4
							ldw r6, 0(sp)
							addi sp, sp, 4
							ldw r7, 0(sp)
							addi sp, sp, 4
							ldw r8, 0(sp)
							addi sp, sp, 4
							ldw r9, 0(sp)
							addi sp, sp, 4
							ldw r10, 0(sp)
							addi sp, sp, 4
							ldw r11, 0(sp)
							addi sp, sp, 4
							ldw r12, 0(sp)
							addi sp, sp, 4
							ldw r13, 0(sp)
							addi sp, sp, 4
							ldw r14, 0(sp)
							addi sp, sp, 4
							ldw r15, 0(sp)
							addi sp, sp, 4							
							
							
			########################### POLL VALID BIT TO READ SENSOR VALUE #####################################
		
		POLL:
			movia  r11, 0xFFFFFBFF      /* enable sensor 0, disable all motors*/
			stwio  r11, 0(r8)
			ldwio  r11,  0(r8)           /* checking for valid data sensor 0*/
			srli   r11,  r11,11           /* bit 11 equals valid bit for sensor 0*/           
			andi   r11,  r11,0x1
			bne    r0,  r11, POLL        /* checking if low indicated polling data at sensor 0 is valid*/

			########################### READ SENSOR VALUE INTO R11 #####################################
		goodS0:
			ldwio  r11, 0(r8)         /* read sensor0 value (into r11) */
			srli   r11, r11, 27       /* shift to the right by 27 bits so that 4-bit sensor value is in lower 4 bits */
			andi   r11, r11, 0x0f
			
			
		blt r11, r12, TURN_OFF  # if r11<r12, go back to the loop (value not bigger than the threshold)
							
		movi r13, 1 /*sensor is above the threshold*/
					
		
	TURN_ON:		
			/*turn on the led to test if working*/
				movia r2, ADDR_LED
				movi r3, 0xf
				stwio r3, 0(r2)	
		
	br LOOP
	
	
	detectLetter:
	
	addi r1, r1, 14 #increment to add space between dots/dashes after a character has been detected
	
	movia r15, space
		beq r14, r15, storeSpace
	movia r15,A
		beq r14,r15,storeA
	movia r15,B
		beq r14,r15,storeB
	movia r15,C
		beq r14,r15,storeC
	movia r15,D
		beq r14,r15,storeD
	movia r15,E
		beq r14,r15,storeE
	movia r15,F
		beq r14,r15,storeF
	movia r15,G
		beq r14,r15,storeG
	movia r15,H
		beq r14,r15,storeH
	movia r15,I
		beq r14,r15,storeI
	movia r15,J
		beq r14,r15,storeJ
	movia r15,K
		beq r14,r15,storeK
	movia r15,L
		beq r14,r15,storeL
	movia r15,M
		beq r14,r15,storeM
	movia r15,N
		beq r14,r15,storeN
	movia r15,O
		beq r14,r15,storeO
	movia r15,P
		beq r14,r15,storeP
	movia r15,Q
		beq r14,r15,storeQ
	movia r15,R
		beq r14,r15,storeR
	movia r15,S
		beq r14,r15,storeS
	movia r15,T
		beq r14,r15,storeT
	movia r15,U
		beq r14,r15,storeU
	movia r15,V
		beq r14,r15,storeV
	movia r15,W
		beq r14,r15,storeW
	movia r15,X
		beq r14,r15,storeX
	movia r15,Y
		beq r14,r15,storeY
	movia r15,Z
		beq r14,r15,storeZ
	
	notFound: 
		movi r14,47
		movia r4, 24
		br doneletter
	storeSpace:
		movi r14, 32
		movia r4, 24
		br doneletter
	storeA:
		movi r14, 65
		movia r4, Asound
		br doneletter
	storeB:
		movi r14, 66 
		movia r4, Bsound
		br doneletter
	storeC:
		movi r14, 67
		movia r4, Csound
		br doneletter
	storeD:
		movi r14, 68
		movia r4, Dsound
		br doneletter
	storeE:
		movi r14, 69
		movia r4, Esound
		br doneletter
	storeF:
		movi r14, 70
		movia r4, Fsound
		br doneletter
	storeG:
		movi r14, 71
		movia r4, Gsound
		br doneletter	
	storeH:
		movi r14, 72
		movia r4, Hsound
		br doneletter
	storeI:
		movi r14, 73
		movia r4, Isound
		br doneletter
	storeJ:
		movi r14, 74
		movia r4, Jsound
		br doneletter
	storeK:
		movi r14, 75
		movia r4, Ksound
		br doneletter
	storeL:
		movi r14, 76
		movia r4, Lsound
		br doneletter
	storeM:
		movi r14, 77
		movia r4, Msound
		br doneletter
	storeN:
		movi r14, 78
		movia r4, Nsound
		br doneletter
	storeO:
		movi r14, 79
		movia r4, Osound
		br doneletter
	storeP:
		movi r14, 80
		movia r4, Psound
		br doneletter
	storeQ:
		movi r14, 81
		movia r4, Qsound
		br doneletter
	storeR:
		movi r14, 82
		movia r4, Rsound
		br doneletter	
	storeS:
		movi r14, 83
		movia r4, Ssound
		br doneletter
	storeT:
		movi r14, 84
		movia r4, Tsound
		br doneletter
	storeU:
		movi r14, 85
		movia r4, Usound
		br doneletter
	storeV:
		movi r14, 86
		movia r4, Vsound
		br doneletter
	storeW:
		movi r14, 87
		movia r4, Wsound
		br doneletter
	storeX:
		movi r14, 88
		movia r4, Xsound
		br doneletter
	storeY:
		movi r14, 89
		movia r4, Ysound
		br doneletter
	storeZ:
		movia r4, Zsound
		movi r14, 90
	
	
	doneletter:
	
		#disaply letter to the vga
		movia r15,ADDR_CHAR
		add r15, r18, r15
		stbio r14,5760(r15) /* character (4,1) is x + y*128 so (4 + 128 = 132) */
		addi r18, r18, 1
	
		movia r20, AUDIO
		addi r21, r21, 0
		movi r22, 48
		mov r23, r22
		
		mov r6, r0

		#counter
		mov r5, r0
		movi r10, 500

		waitForWriteSpace:
		beq r5, r10, continue
			ldwio r14, 4(r20)
			andhi r13, r14, 65280
			beq r13, r0, waitForWriteSpace
			andhi r13, r14, 255
			beq r13, r0, waitForWriteSpace
		
		writeTwoSamples:
			add r14, r6, r4
			
			ldwio r21, (r14)
			stwio r21, 8(r20)
			stwio r21, 12(r20)
			addi r6, r6, 4
			addi r23, r23, -1
			bne r23, r0, waitForWriteSpace
			
		halfPeriodInvertWaveform:
			mov r23, r22
			sub r21, r0, r21
			addi r5, r5, 1
			br waitForWriteSpace
		
		
		continue: 

		#start the timer
		stwio r0,0(r16)
		movi r17, 0b100
		stwio r17, 4(r16)
		
		mov r10, r0 #dot dash counter
		mov r14, r0 #r14 has value of the current letter being read
		mov r13, r0 #state of the sensor (above threshold=1, below threshold=0) 

		
	br LOOP
	
	
	
	

