//the following loop pulses clock, latch and data signals up and down 
//to read voltages in the form of 0 or 1 from the snes controller


.section .text
.global loopSNES

loopSNES:

	push	{r5,r6,lr}
    mov  	r5, #0      //button word register

	mov 	r0, #1
	bl  	writeClock

	mov 	r0, #1
	bl  	writeLatch

	mov  	r0, #12
	bl 		delayMicroseconds

	mov  	r0, #0
	bl  	writeLatch

	mov  	r6, #0    //i increment counter


pulseLoop:

	mov  	r0, #6      
	bl  	delayMicroseconds 

	mov 	r0, #0       
	bl  	writeClock

	mov  	r0, #6      
	bl  	delayMicroseconds

	bl 		readData      //read bit i  
	lsl 	r5, #1    //left shift button register every time it loops so that eventually all 16 bits are read
	orr 	r5, r0    //we can orr the buttonword register with the gpiolev0 read register to paste a 0 at the appropriate spot

	mov 	r0, #1       
	bl  	writeClock

	add  	r6, #1

	cmp  	r6, #16      //check if counter < 16
	blt  	pulseLoop

	mov  	r0, r5        //copy r4 to r0 for return
	pop 	{r5,r6,lr}
	bx lr	
