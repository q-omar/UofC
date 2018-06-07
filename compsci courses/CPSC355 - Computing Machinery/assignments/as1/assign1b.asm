//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 1

//The following ARM assembly code iterates through the bounds leftbound<=x<=rightbound to calculate the minimum of the 
//function y = a3x^3 + a2x^2 + a1x + a0

//Define register aliases
fp .req x29
lr .req x30

define(leftbound, -7)		//defining our leftbound as -7
define(rightbound, 5)		//defining rightbound as 5
define(inc, 1)		//incrementing loop by 1 each time

define(a0, -9)		//a0 is x^0 coffecient
define(a1, -3)		//a1 is x^1 coffecient
define(a2, 14)		//a2 is x^2 coffecient
define(a3, 2)		//a3 is x^3 coffecient

define(min, x27)	//x27 is defined as current minimum 
define(x, x19)		//x19 is defined as the current x
define(y, x26)		//x26 is defined as the current value of the function y at the current x 



fmt: 	
	.string "currentX is %d, currentY is %d, minimum is %d\n"//define string
	.global main//Make main visible to OS
	.balign 4//Instructions must be word aligned


main:

	stp     fp, lr, [sp, -16]!     //Save FP and LR to stack, pre-increment sp
	mov     fp, lr  //Update FP to current SP
	mov 	x, leftbound 	//x, which represents current x value, starts at leftboundary
	b 		test


loop://the loop itself for iterating through the bounds	
    
	mov 	x20, a0 //starting with the constant -9 to build our function, first term
	mov 	x21, a1//coefficient 3 in front of x
	madd 	x21, x21, x, x20 //multiplying coefficient by x and also adding on the last term, -3x - 9
	
	mov 	x23, a2 //coefficient 14 in front x^2 
	mul		x24, x, x //squaring x's to get x^2
	madd 	x23, x24, x23, x21 //multiplying 14 by x^2 and then adding -3x - 9

	mov 	x25, a3 //coefficient 2 in front of x^3
	mul 	y, x, x //cubing x^3, x*x
	mul 	y, y, x //cubing x^3, x*x^2
	madd    y, y, x25, x23 //multiplying x^3 by 2, then adding the 14x^2 - 3x - 9 terms
    
	cmp 	x, leftbound //this comparison checks if we are on our first iteration of the loop
	bne 	mincheck //if the bound isnt equal to 2, it goes to notfirst branch
	mov 	min, y //if it is the first iteration, x27 which represents minimum takes value of current y
	b 		print //branch to print

mincheck://used for updating our minimum
	cmp 	y, min //if it is not our first iteration of the loop, we compare if x26>x27
	b.ge	print    ///if it is greater, go to print, no need to update x27
	mov 	min, y //otherwise, update x27 to take value of x26, then go to print 


print://printing output to terminal
	
	ldr		x0, =fmt		//Uses formatter
	mov		x1, x //current x
	mov 	x2, y //current y 
	mov     x3, min //current min 
	bl		printf//printing

	add 	x, x, inc//incrementing our x value
	

test:
	cmp		x, rightbound //comparing if x19 has reached 5, the leftmost boundary
	b.gt 	exit//if so, program exits
	b       loop//if not, go into the loop
	
exit://exiting program 
	mov w0, 0 
	ldp fp, lr, [sp], 16            //restore stack
	ret//return to caller