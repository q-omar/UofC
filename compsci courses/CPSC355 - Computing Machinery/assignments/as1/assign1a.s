//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 1

//The following ARM assembly code iterates through the bounds -7<=x<=5 to calculate the minimum of the 
//function y = 2x^3 + 14x^2 - 3x - 9

fmt: 	
	.string "x is %d, y is %d, min is %d\n"//define string
	.global main//Make main visible to OS
	.balign 4//Instructions must be word aligned

main:
	stp 	x29, x30, [sp, -16]!      //Save FP and LR to stack, pre-increment sp
	mov 	x29, x30                  //Update FP to current SP
	mov 	x19, -7 	//x19, which represents current x value, starts at -7 for our boundary
	
test: //pretest loop with the test being on top
	cmp		x19, 5 //comparing if x19 has reached 5, the leftmost boundary
	b.gt 	exit //if so, program exits

loop: //the loop itself for calculating value of v at each x	
	mov 	x20, -9 //starting with the constant -9 to build our function, first term

	mov 	x21, -3//coefficient 3 in front of x
	mul 	x21, x21, x19 //multiplying coefficient by x to give us our second term
	
	mov 	x23, 14 //coefficient 14 in front x^2 
	mul		x24, x19, x19 //squaring x's to get x^2
	mul 	x23, x23, x24 //multiplying terms to get our third term

	mov 	x25, 2 //coefficient 2 in front of x^3
	mul 	x26, x19, x19 //cubing x^3, x*x
	mul 	x26, x26, x19 //cubing x^3, x*x^2
	mul 	x26, x26, x25 //multiplying coefficient with x^3 to give us our fourth term

	add		x26, x26, x23 //adding fourth and third terms, 2x^3 + 14x^2
	add 	x26, x26, x21 //adding terms, 2x^3 + 14x^2 - 3x
	add		x26, x26, x20 //adding terms to get our final function 2x^3 + 14x^2 - 3x  - 9

	cmp 	x19, -7 //this comparison checks if we are on our first iteration of the loop
	bne 	mincheck //if the bound isnt equal to -7, it goes to mincheck branch
	mov 	x27, x26 //if it is the first iteration, x27 which represents minimum takes value of current y
	b 		print //branch to print

mincheck: //used for updating our minimum
	cmp 	x26, x27 //if it is not our first iteration of the loop, we compare if x26>x27
	b.ge	print    //if it is greater, go to print, no need to update x27
	mov 	x27, x26 //otherwise, update x27 to take value of x26, then go to print 


print: //printing output to terminal
	
	ldr		x0, =fmt//Uses string formatter
	mov		x1, x19 //current x
	mov 	x2, x26 //current y 
	mov     x3, x27 //current min 
	bl		printf //printing

	add 	x19, x19, 1	//incrementing our x value
	b		test //going back up to loop test
	
exit: //exiting program 
	mov w0, 0 
	ldp x29, x30, [sp], 16			 //restore stack
	ret								 //return to caller