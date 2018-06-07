.section .text
.global initSNES
gBase	.req	r2


initSNES:
    
    //init GPIO line 9 (latch) to output
    ldr		r0, =GpioPtr
    ldr		gBase, [r0]
    ldr     r0, [gBase] //copy
    
    mov     r1, #7 		//clear mask 0b111
    bic     r0, r1, lsl #27
    mov     r1, #1 //Output code 
    orr     r0, r1, lsl #27     
    str     r0, [gBase] 	//write back to gpioselect0

   
    //init GPIO line 10 (data) to input
    mov     r1, #7 		//clear mask
    bic     r0, r1
    mov     r1, #0 		//input code
    orr     r0, r1
    str     r0, [gBase, #4]	//write back to GPSEL1


     //init GPIO line 11 (clock) to output
    mov     r1, #7 		//clear mask
    bic     r0, r1, lsl #3
    mov     r1, #1 	//output code
    orr     r0, r1, lsl #3
    str     r0, [gBase, #4]	//write back to GPSEL1

   
    .unreq  gBase
    bx lr
