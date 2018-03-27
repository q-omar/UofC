//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 2

//The following ARM assembly code takes two hexadecimal numbers as input and performs a multiplication via
//looping and shifting through bits. The initial inputs are printed in hexadecimal and decimal format and
//the final product is printed at the end after the calculation

fp .req x29//Define register aliases
lr .req x30

define(multiplicand_c, 0xffff1000)	//define multiplicand, multiplier and product constants
define(multiplier_c, 0xffffffe0)	
define(product_c, 0)		

define(multicand_reg, w19)	//define registers for multiplicand, multiplier and product
define(multiplier_reg, w20)	
define(product_reg, w28)		
define(temp_reg,w26)

definestrings:	
	multiplicand: .string "Multiplicand = %d\ \n\Multiplicand(hex) = 0x%08X\n" //definiing strings for hex and dec output formats
	multiplier: .string "\nMultiplier = %d\ \nMultiplier(hex) = 0x%08X\n"	
	finalproduct: .string "\nFinal product = %d \n\Final product(hex) = 0x%08X\n"
	finalmultiplier: .string "\nMultiplier = %d\nMultiplier(hex) = 0x%08X\nMultiplier Result Extended (hex) = 0x%016X\n\n"	

	.global main//Make main visible to OS
	.balign 4//Instructions must be word aligned

main:
	stp     fp, lr, [sp, -16]!     //Save FP and LR to stack, pre-increment sp
	mov     fp, lr  //Update FP to current SP


initialprinting:
	mov 	product_reg, 0 //initializing product as 0
	mov 	w23, 0 //initializing bitcounter as 0

	mov 	multicand_reg, multiplicand_c	//initializing multiplicand
	sxtw 	x20, multicand_reg
							//Sign extend a word (32-bits) to a doubleword (64-bits) used Kevin Ta's tutorial code		
	adrp 	x0, multiplicand		//Set 1st arg (high order bits)	
	add 	x0, x0, :lo12:multiplicand//Set 1st arg (lower 12 bits)
	mov 	w1, multicand_reg
	mov 	w2, multicand_reg	//moving to appropriate registers for printing
	mov	 	x1, x20
	mov 	x2, x20
	bl 		printf

	mov 	multiplier_reg, multiplier_c //initializing multiplier
	sxtw 	x21, multiplier_reg//Sign extend a word (32-bits) to a doubleword (64-bits) used Kevin Ta's tutorial code		

	adrp 	x0, multiplier			//Set 1st arg (high order bits)	
	add 	x0, x0, :lo12:multiplier//Set 1st arg (lower 12 bits)
	mov 	w1, multiplier_reg
	mov 	w2, multiplier_reg	//moving to appropriate registers for printing
	mov	 	x1, x21
	mov 	x2, x21
	bl 		printf

start: 
	lsr		w25, multiplier_reg, 31 //using logical shift right operator to check if multiplier is negative 

	b 		test    //enter looping condition

loop:
    and 	temp_reg, multiplier_reg, 1//first extract rightmost bit in multiplier
	cmp		temp_reg, 1//check if it is 1
	b.ne 	pos //if it isnt, branch to positive

	add 	product_reg, product_reg, multicand_reg //if so, add multiplicand to product

pos:
	and 	temp_reg, product_reg, 1 // now extract rightmost bit of product
	lsl		temp_reg, temp_reg, 31   //logical shift it all the way to left
	lsr		multiplier_reg, multiplier_reg, 1  //logical shift right the multiplier by 1
	orr		multiplier_reg, temp_reg, multiplier_reg //bitmasking move rightmost bit of product to leftmost of multiplier
	asr		product_reg, product_reg, 1 //arithmitic shift product right by 1

	add 	w23, w23, 1 //update counter

test:
	cmp 	w23, 32 //check if the bitcounter has looped 32 times
	b.lt	loop //if not, enter loop
	cmp		w25, 1 //if so, check if multiplier is negative
	b.ne 	endprinting //if not, go to end printing

	sub 	product_reg, product_reg, multicand_reg //if it is,  subtract multiplicand from product	
	
endprinting:
	sxtw	x22, product_reg//Sign extend a word (32-bits) to a doubleword (64-bits) used Kevin Ta's tutorial code		
	adrp	x0, finalproduct//Set 1st arg (high order bits)	
	add 	x0, x0, :lo12:finalproduct//Set 1st arg (lower 12 bits)
	mov		w1, product_reg//moving to appropriate registers for printing
	mov		w2, product_reg
	bl 		printf

	sxtw 	x21, multiplier_reg//Sign extend a word (32-bits) to a doubleword (64-bits) used Kevin Ta's tutorial code		
	adrp 	x0, finalmultiplier
	add 	x0, x0, :lo12:finalmultiplier
	mov 	w1, multiplier_reg//moving to appropriate registers for printing
	mov 	w2, multiplier_reg	
	mov	 	x3, x21
	mov 	x4, x21
	bl 		printf




exit://exiting program 
	mov w0, 0 
	ldp fp, lr, [sp], 16            //restore stack
	ret//return to caller