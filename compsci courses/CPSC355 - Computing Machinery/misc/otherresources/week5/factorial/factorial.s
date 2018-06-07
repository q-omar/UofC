
	.data
result:	.word 1

	.bss
factorialSum: .dword

	.balign 8
	
fp .req x29
lr .req x30
	
	.text

//==================================================
//int factorial(int x)
//calculates the result of x!
//==================================================

i_s = 16

alloc_factorial = -(16 +4 ) & -16
dealloc_factorial = -alloc_factorial

	.balign 4
	.global factorial

factorial:
	stp fp, lr, [sp, alloc_factorial]!
	mov fp, sp
	
	mov w9 , 1
	str w9, [fp, i_s]
	
calc_loop:

	adrp x9, result
	add x9, x9, :lo12:result
	ldr w10, [x9]
	
	ldr w11, [fp, i_s]
	mul w10, w10, w11
	str w10, [x9]				//store result* i back into result
	
	adrp x9, factorialSum
	add x9, x9, :lo12:factorialSum
	ldr x10, [x9]				//factorialSum
	
	adrp x11, result
	add x11, x11, :lo12:result
	ldr w12, [x11]				//get result variable
	
	sxtw x12, w12
	add x10, x10, x12			//factorialSum + result;
	
	str x10, [x9]				//store back into factorialSum
	


	//i++
	ldr w9, [fp, i_s]
	add w9, w9, 1
	str w9, [fp, i_s]

calc_loop_check:
	ldr w9, [fp, i_s]
	cmp w9, w0
	b.le calc_loop
	
	adrp x9, result
	add x9, x9, :lo12:result
	ldr w0, [x9]
	
exit_factorial:
	ldp fp, lr, [sp], dealloc_factorial
	ret
	
	
//==================================================
//long int getFactorialSum()
//Gets the factorial sum of the previous calculation
//==================================================

alloc_getFactorialSum = -(16) & -16
dealloc_getFactorialSum =  -alloc_getFactorialSum

	.balign 4
	.global getFactorialSum

getFactorialSum:
	stp fp, lr, [sp, alloc_getFactorialSum]!
	mov fp, sp
	
	adrp x9, factorialSum
	add x9, x9, :lo12:factorialSum			//got a pointer to factorialSum
	ldr x0, [x9]							//got factorialSum put into return
	
	
	
exit_getFactorialSum:
	ldp fp, lr, [sp], dealloc_getFactorialSum
	ret
	