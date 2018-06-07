// Local Variables example
// Generates a random number between -8 and 7 inclusive


min_s = 16							//start offset just after the frame record
range_s = 20
rand_num_s = 24

alloc = -(16 + 12) & -16			//create space for frame record and 3 int sized variables
dealloc = -alloc					//deallocation offset when the function ends

fp .req x29						//frame pointer register
lr .req x30						//link register


fmt:	.string "Hello world! Your lucky number today is: %d\n"		

	.balign 4						//instructions are word aligned
	.global main					//make main visible to OS
	
main:
	stp fp, lr, [sp,alloc]!			//Save fp and lr to stack, allocate our memory
	mov fp, sp						//update FP to current SP

init_local:

	str wzr, [fp, min_s]			//initalize min to zero to memory
	str wzr, [fp, range_s]			//initalize range to zero to memory
	str wzr, [fp, rand_num_s]		//initalize rand_num to zero to memory
	
	
	
	mov w19, -8						//set min
	str w19, [fp, min_s]			//store to memory

	mov w19, 0xF					//set range
	str w19, [fp, range_s]			//store to memory
	
gen_rand:
	bl clock						//get current time in milliseconds, result in w0
	bl srand						//srand(clock());
	
	bl rand							//call rand(), result will be in register w0
	str w0, [fp, rand_num_s]		//store to memory
	
	
calc_rand:	
	//calculate (rand_num & range) and store
	ldr w19, [fp, rand_num_s]
	ldr w20, [fp, range_s]
	and w19, w19, w20				//rand_num & range
	str	w19, [fp, rand_num_s]		//rand_num = rand_num & range
	
	
	
	//calculate rand_num + min;
	ldr w19, [fp, rand_num_s]
	ldr w20, [fp, min_s]
	add w19, w19, w20				//rand_num + min
	str w19, [fp, rand_num_s]		//rand_num = rand_num + min
	
	
	
print_rando:	
	//print out using printf
	adrp x0, fmt					
	add x0, x0, :lo12:fmt			
	ldr w1, [fp, rand_num_s]			//load straight as an argument
	bl printf						
	
	
	
	
	//return 0 for main
	mov w0, 0
exit:
	ldp fp, lr, [sp], dealloc		//restore stack
	ret								//return to caller
