// GDB debugging sample code
// Bonus: can you find a way to use the madd instruction to optimize your code?

fmt:	
	.string "Hello World! %d + (%d * %d) = %d\n"			//define string
	.balign 4
	.global main	

main:
	stp x29, x30, [sp,-16]!			//Save fp and lr to stack
	mov x29, sp						//update FP to current SP


//custom code starts here mostly
calc:
	//lets calculate 400 + (7544 * 6546)
	//assume the formula xa + (xb * xc) = result
	mov x19, 400					//xa
	mov x20, 7544					//xb
	mov x21, 6546					//xc
	mov x22, 0						//result
	
	mul x22, x20, x21
	add x22, x22, x19

	//print result
print_result:
	adrp x0, fmt					//set 1st arg (high-order bits), sets the string
	add x0, x0, :lo12:fmt			//set 1st arg (lower 12 bits)
	mov x1, x19
	mov x2, x20
	mov x3, x21
	mov x4, x22
	bl printf

//custom code stop here mostly
	
cleanup:
	//just for example, cleaning up registers, no need to clear registers though ;)
	mov x19, 0
	mov x20, 0
	mov x21, 0
	mov x22, 0
	
	
	//return 0 for main
	mov w0, 0
exit:
	ldp x29, x30, [sp], 16			 //restore stack
	ret								 //return to caller