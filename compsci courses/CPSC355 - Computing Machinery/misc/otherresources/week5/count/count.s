//Linking external programs example


		.bss
count:	.word						//int count = 0;		(as a global variable)
		.text						//getting segmentation errors? try including the .text section
	
	
fp .req x29							//frame pointer register
lr .req x30							//link register



//=================================================================
//void addCount(int x)
//Adds a number to the current count
//=================================================================

alloc_addCount = -(16) & -16				
dealloc_addCount = -alloc_addCount					//deallocation offset when the function ends

	.balign 4						
	.global addCount					
	
addCount:
	stp fp, lr, [sp,alloc_addCount]!			
	mov fp, sp						
	
	adrp x9, count					
	add x9, x9, :lo12:count							//grab the global variable count
	ldr w10, [x9]
	add w10, w10, w0
	str w10, [x9]									//count += x;
	
	
addCount_exit:
	ldp fp, lr, [sp], dealloc_addCount		//restore stack
	ret								//return to caller

	
	
//=================================================================
//int getCurrentCount(int x)
//Adds a number to the current count
//=================================================================	

	

alloc_getCurrentCount = -(16) & -16					//create space our function's stack
dealloc_getCurrentCount = -alloc_getCurrentCount

	.balign 4
	.global getCurrentCount

getCurrentCount: 
	stp fp, lr, [sp,alloc_getCurrentCount]!			//Save fp and lr to stack, allocate our memory
	mov fp, sp				

	adrp x9, count					
	add x9, x9, :lo12:count							//grab the global variable count
	
	
	ldr w0, [x9]									//return count
	
getCurrentCount_exit:
	ldp fp, lr, [sp], dealloc_getCurrentCount			//restore stack
	ret											//return to caller	
	