//Safian Omar Qureshi
//ID 10086638

//The following assembly code is a driver for taking input from a SNES controller

.section .text
.global main
gBase 	.req	r2


main:
	mov 	r0, #13 //the print subroutine takes an argument r0 to print a corresponding ascii string
	bl 		print //in the case of #13, its author name
	
    ldr		r0, =GpioPtr
    bl		initGpioPtr //initializing virtual memory address for base GPIO
    bl      initSNES
	

start: 
	mov		r0,	#14 //button prompt
	bl 		print
	

getInput:
	bl		loopSNES //loopsnes routine will return a button word register
	mov		r1, #0xffff //compare button word register with 111...to see if any button is pressed or not
	cmp		r0, r1
	beq		loopSNES //if there is no button pressed, loop back to get input

	bl	 	print //otherwise print, loopsnes returns a button word and we can compare
	//the button word with a corresponding hex value to print our button

//this change subroutine complies with one of the assignment requirements that the same button
//should not keep repeatedly printing so this makes it so that user must select another button 
//to print again
changeButton:
	mov  	r0, #9999     
	bl  	delayMicroseconds 
	bl		loopSNES
	mov		r1, #0xffff 
	cmp		r0, r1  //now we read snes again to see if the user has let go of the button. if they have 
	//not, we keep looping here so that once user lets go, then we go back up top to get new input to print
	beq 		start  //if       
	b changeButton
	
.unreq gBase
.global haltLoop
haltLoop:
	b		haltLoop


.section .data
.align 2
.global GpioPtr
GpioPtr:
	.int	0	@ GPIO base address
	
noButton:
	.asciz "No button pressed, looping...\n" //Debugging msgs

yesButton:
	.asciz	"Button detected!\n"



