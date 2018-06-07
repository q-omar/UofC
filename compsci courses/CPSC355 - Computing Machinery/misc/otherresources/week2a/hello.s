//Hello world in assembly for ARM v8

define(secret_number,999)
define(secret_number_reg,x19)


fmt: .string "Hello world! Secret number = %d\n"
	.balign 4
	.global main
	
main: 
	stp x29, x30, [sp, -16]! //allocate stackspace
	mov x29, sp //move

	mov secret_number_reg, secret_number
	add secret_number_reg, secret_number_reg, 23
	
print_hello:
	//print out using printf()
	adrp x0, fmt
	mov w1, 999 //999 is secret number
	bl printf

	mov w0, 0 //return 0
exit: 
	ldp x29, x30, [sp], 16
	ret
