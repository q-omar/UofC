//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 3

//The following ARM assembly code generates a 50 element array that is made up of random positive integers (mod 1024)
//It is printed to console and then the array is sorted via selection sort and then printed once more to console


//Begin with using assembly equates 

size = 50 //# of entries
t_size = size*4 //integers are 4 bytes, multiply that by 50 for total size
i_size = 4 //integer i index
j_size = 4 //integer j index
max = 4
temp = 4


arrayBase = 16 // assembly equates for array base address
i_s = 16 + t_size //assembly equate for i address
j_s = i_s + j_size //assembly equate for j address
max_s =  j_s + max //and so on
temp_s = max_s + temp
tot_var_sizes = t_size + i_size + j_size + max + temp //total stack variables offset
 
 //allocating memory for variables
alloc=-(16+tot_var_sizes) & -16
dealloc=-alloc


define(i_reg, w19)
define(j_reg, w20)
define(max,w18)
define(temp,w17)
define(base, x21)


fp .req x29//Define register aliases
lr .req x30

definestrings:	
	
    unsortedLabel: .string "\nUnsorted Array:\n"
    sortedLabel: .string "\nSorted Array:\n"
    unsorted: .string "v[%d] = %d\n" //definiing strings when printing unsorted/sorted arrays
	sorted: .string "v[%d] = %d\n"
    
    .global main//make main visible to OS
	.balign 4//instructions must be word aligned


main:
	stp    fp, lr, [sp, alloc]!     //save FP and LR to stack, pre-increment sp
	mov    fp, sp							//update FP to current SP
    
    mov    i_reg,0						//initialize i to 0
    str    i_reg, [fp, i_s]				//store counter at this address

    adrp   x0, unsortedLabel //printing label 
    add    x0, x0, :lo12:unsortedLabel
    bl     printf

    add    base, fp, arrayBase					//calculate array base address	
    b      unsortedTest


unsortedLoop:
    bl     rand								//call rand() function
    and    j_reg, w0, 0x3FF					//mod the result with 1024

    ldr    i_reg, [fp, i_s]				//load current i
    str    j_reg, [base, i_reg, SXTW 2]	//store random integer into array[i]
    
    //printing final
    adrp   x0, unsorted					//set 1st arg (high order bits)
    add    x0, x0, :lo12:unsorted			//set 1st arg (lower 12 bits)    
    ldr    w1, [fp, i_s]				//arg 1 : i
    ldr    w2, [base, w1, SXTW 2]		//arg 2: v[i]
    bl     printf						//call printf
    
    ldr    i_reg, [fp, i_s]			//get current i
    add    i_reg, i_reg, 1				//increment i
    str    i_reg, [fp, i_s]			//save updated i
    

unsortedTest:
    cmp    i_reg, size					//Loop while i<size
    b.lt   unsortedLoop


reset:
    mov    i_reg, 0						//reset i to 0
    str    i_reg, [fp, i_s] //store to stack
    
    mov    temp, 0 //intiialize temp for later
    str    temp, [fp, temp_s] //storing

    adrp   x0, sortedLabel //printing label 
    add    x0, x0, :lo12:sortedLabel
    bl     printf

    b      outerLoopTest //pretest


outerLoop:
    ldr    i_reg, [fp, i_s] //loading current i

    mov    max, i_reg //max = i 
    str    max, [fp,max_s] //saving max to stack

    add    j_reg, i_reg, 1 //j = j+1
    str    j_reg,[fp,j_s]//storing j_reg to allocated stack address

    b      innerLoopTest


innerLoop:    
    ldr    j_reg, [base, j_reg, SXTW 2]	//vj 
    ldr    max, [base, max, SXTW 2] //max 
    cmp    j_reg, max //comparing two of the values
    b.lt   endCondition
    
    ldr    j_reg, [fp, j_s] //skip if vj < max 
    mov    max, j_reg // max = j
    str    max, [fp,max_s] //storing max to allocated address on stack


endCondition:

    ldr    j_reg, [fp, j_s] //loading j reg
    add    j_reg, j_reg, 1 //increment j
    str    j_reg, [fp, j_s] //saving it back

    ldr    max, [fp,max_s]
    str    max, [fp,max_s]


innerLoopTest:
    cmp     j_reg, size //comparing if j index has reached size (50) yet
    b.lt    innerLoop


outerSwapping:

    ldr    temp, [base, max, SXTW 2] //temp = vmax
    str    max, [base, max, SXTW 2] //vmax = vi
    str    temp,[base, i_reg,SXTW 2] //vi = temp

    ldr    i_reg, [fp, i_s]			//get current i
    add    i_reg, i_reg, 1				//increment i
    str    i_reg, [fp, i_s]			//save updated i


outerLoopTest:
    cmp    i_reg, size - 1 //outer loop pretest
    b.lt   outerLoop

    mov    i_reg, 0 //reseting i index back for print loop
    str    i_reg, [fp, i_s]
    b      printTest


printLoop:
    ldr    i_reg, [fp, i_s]
    ldr    i_reg,[base, i_reg,SXTW 2]

    adrp   x0, sorted					//set 1st arg (high order bits)
    add    x0, x0, :lo12:sorted			//set 1st arg (lower 12 bits)    
    ldr    w1, [fp, i_s]				//arg 1 : i
    ldr    w2, [base, w1, SXTW 2]		//arg 2: v[i]
    bl     printf						//call printf

    ldr    i_reg, [fp, i_s]			//get current i
    add    i_reg, i_reg, 1				//increment i
    str    i_reg, [fp, i_s]			//save updated i
    

printTest:
    cmp    i_reg,size 
    b.lt   printLoop


exit://exiting program 
	mov    w0, 0
	ldp    fp, lr, [sp], dealloc		//Deallocate stack memory
	ret	//return to caller