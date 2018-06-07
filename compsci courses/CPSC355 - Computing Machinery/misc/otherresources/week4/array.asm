size = 20							//20 elements
t_size = size*4 					//Size of all variable of array = 20*4 = 80 bytes
i_size = 4							//Size of counter i = 4
j_size = 4							//Size of counter j = 4

//Define equates for variable sizes
t_s = 16							//
i_s = 16 + t_size
j_s = i_s + i_size
 
 //Define equates for stack variable offsets
 var_size = t_size + i_size + j_size
 
 //Calculate memory needed for local variable
 alloc=-(16+var_size) & -16
 dealloc=-alloc
 
 define(i_reg, w19)
 define(j_reg, w20)
 define(base, x21)
 //Define register aliases
fp .req x29
lr .req x30

fmt1: .string "v[%d]: %d\n"

.balign 4
.global main							//Make main visible

main: 
	 stp fp, lr, [sp, alloc]!			//Store FP and LR on stack, and allocate space for local variables
     mov fp, sp							//Update FP to current SP
     
     mov i_reg,0						//Initialize i to 0
     str i_reg, [fp, i_s]				//Store counter at this address
     b test1
     
top1:
		bl rand								//Call rand() function
		and j_reg, w0, 0xFF					//Mod the result with 255
		
		add base, fp, t_s					//Calculate array base address	
		ldr i_reg, [fp, i_s]				//Load current i
		str j_reg, [base, i_reg, SXTW 2]	//Store random integer into array[i]
		
 		adrp x0, fmt1					//Set 1st arg (high order bits)
        add x0, x0, :lo12:fmt1			//Set 1st arg (lower 12 bits)    
        ldr w1, [fp, i_s]				//Arg 1 : i
        add base, fp, 16				//Calculate array base address
        ldr w2, [base, w1, SXTW 2]		//Arg 2: v[i]
        bl printf						//Call printf
        
        ldr i_reg, [fp, i_s]			//Get current i
        add i_reg, i_reg, 1				//Increment i
        str i_reg, [fp, i_s]			//Save updated i

test1:
		cmp i_reg, size					//Loop while i<size
		b.lt top1

		
		
		mov w0, 0
		ldp fp, lr, [sp], dealloc		//Deallocate stack memory
		ret								//Return to calling code in OS
	