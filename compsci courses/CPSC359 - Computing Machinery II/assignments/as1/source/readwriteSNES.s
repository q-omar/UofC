.section .text
.global writeClock
gBase	.req	r2


writeClock: //clock is pin11
	
	ldr		gBase, =GpioPtr //load gBase from main .global int
    ldr		gBase, [gBase]
    
	mov     r1, #1 //1 is used regardless of clearing or setting
	lsl     r1, #11	//aliging pin by shifting 11 times
	teq     r0, #0 //r0 parameter from loopSNES
	streq   r1, [gBase, #40]//gpioclr0, gBase is from main			
	strne   r1, [gBase, #28]//gpioset0
	
	bx lr
	

.global writeLatch
writeLatch:
	
	ldr		gBase, =GpioPtr
    ldr		gBase, [gBase]
    
	mov     r1, #1//1 is used regardless of clearing or setting
	lsl     r1, #9//aliging pin by shifting 9 times
	teq     r0, #0 //r0 parameter from loopSNES
	streq   r1, [gBase, #40]//gpioclr0
	strne   r1, [gBase, #28]//gpioset0
	
	bx lr


.global readData
readData:
	
	ldr		r0, =GpioPtr
    ldr		gBase, [r0]
    ldr     gBase, [gBase, #52] //gpiolev0
 
	mov		r1, #1 //1 is used for reading
	lsl     r1, #10	 //move to appropriate bit by shifting 10 times			
	and     gBase, r1//and with gpiolev0 			
    teq     gBase, #0
	moveq   r0, #0      //depending on the result of the and, send either 0 for button pressed or 1 for no button press
	movne   r0, #1     
    
	bx lr
	
	
.unreq gBase
