//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 3

//The following ARM assembly code generates two cuboids with an x, y location, length, height and width. If the 
//two cuboids have the same height, length and width, the first cuboid is moved to another x, y location and
//the second cuboid scales by an amount in the same location


//Begin with using assembly equates 

//point structure
pointX = 0		//setting offsets for variables in struct point				
pointY = pointX + 4							
structPointSize = 4*2  //two variables of int type each of size 4		

//dimension structure
dimensionW = 0	//setting offsets for variables in struct dimension						
dimensionL = dimensionW + 4						
structDimensionSize = 4*2 //two variables of int type each of size 4				

//cuboid structure
cuboidPointN = 0 //setting offsets for variables in struct cuboid					
cuboidDimensionN = cuboidPointN + structPointSize	//have to essentially offset first two variables by 8 since cuboid structure contains nested structures					
cuboidHeight = cuboidDimensionN + structDimensionSize		
cuboidVolume = cuboidHeight + 4					
structCuboidSize = structPointSize + structDimensionSize + 4*2 //cuboid contains two structures so we have to add size of point and dimension structures, along with 2 ints of size 4 each										

//calculating bases for both cuboids
cuboid1Base = 16	//base offset for cuboid 1, fp+lr						
cuboid2Base = cuboid1Base + structCuboidSize //base offset for cuboid 2, which is cuboid1base + the size of the cuboid struct				

//memory allocation
alloc = -(16 + structCuboidSize*2) & -16	//allocating enough memory, multiplied struct size of cuboid by 2 for 2 cuboids			
dealloc = -alloc

//defining macros 

//registers
define(cuboid1BaseRegister, x20)
define(cuboid2BaseRegister, x21)
define(generalCuboidRegister,x22)

//constants
define(INIT_XPOINT,0)
define(INIT_YPOINT,0)
define(INIT_WIDTH,2)
define(INIT_LENGTH,2)
define(INIT_HEIGHT,3)
define(MOVE_X,3)
define(MOVE_Y,-6)
define(SCALE_FACTOR,4)
define(FALSE, 0)
define(TRUE, 1)
					
 //define register aliases
fp .req x29
lr .req x30

//define strings
defineStrings:
    initialLabel:	.string "Initial cuboid values:"	
    changeLabel:	.string "\nChanged cuboid values:"
    variableLabel:	.string "\nCuboid %s origin = (%d, %d)\n Base width = %d  Base length = %d\n Height = %d\n Volume = %d\n"

    firstString:	.string "first"												
    secondString:	.string "second"				

    .balign 4
    .global main


scale:		
    stp     fp, lr, [sp, -16]!	//allocating memory for subroutine				
    mov     fp, sp							

    mov     generalCuboidRegister, x0		//loading x0s information into a temp register					
    mov     w23, w1	    //loading scale factor						

    ldr     w25, [generalCuboidRegister, cuboidDimensionN + dimensionW]	//loading c.base.width to multiply by factor		
debugScale1: //added a debug label here for checking how values update
    mul     w25, w25, w23 //multiply width by 4					
debugScale2:
    str     w25, [generalCuboidRegister, cuboidDimensionN + dimensionW]	//storing new c.base.width

    ldr     w26, [generalCuboidRegister, cuboidDimensionN + dimensionL]	//same process as above	
    mul     w26, w26, w23						
    str     w26, [generalCuboidRegister, cuboidDimensionN + dimensionL]		

    ldr     w27, [generalCuboidRegister, cuboidHeight] //same process above
    mul     w27, w27, w23						
    str     w27, [generalCuboidRegister, cuboidHeight]				

    mul     w28, w25, w26	//new volume calculation					
    mul     w28, w28, w27
    str     w28, [generalCuboidRegister, cuboidVolume] //storing it appropriate place on stack					


    ldp     fp, lr, [sp], 16	//deallocating frame record					
    ret							


move:		
    stp     fp, lr, [sp, -16]!	//allocating memory for subroutine
    mov     fp, sp							

    mov     generalCuboidRegister, x0		//putting cuboid1s information into temp register generalCuboidRegister					
    mov     w23, w1		//putting the move x and y values into temp registers	
    mov     w24, w2		//putting the move x and y values into temp registers						

    ldr     w25, [generalCuboidRegister, cuboidPointN + pointX]	//loading current x of cuboid, c.origin.x
debugMove1:	//added a debug label here for checking how values update		
    add     w25, w25, w23	//adding x value from above	
debugMove2:				
    str     w25, [generalCuboidRegister, cuboidPointN + pointX] //storing new c.origin.x on the stack 

    ldr     w25, [generalCuboidRegister, cuboidPointN + pointY]	//same as above for y 			
    add     w25, w25, w24						
    str     w25, [generalCuboidRegister, cuboidPointN + pointY]					


    ldp     x29, x30, [sp], 16	//deallocating frame record						
	ret					


equalSize:		
    stp     fp, lr, [sp, -16]!		//allocating memory for subroutine			
    mov     fp, sp							
						
    mov     x0, FALSE //setting temp register x0 as false and if it reaches the bottom of the subroutine, can be set to true						

    ldr     x19, [cuboid1BaseRegister, cuboidDimensionN + dimensionW]	//and then width 	
    ldr     x23, [cuboid2BaseRegister, cuboidDimensionN + dimensionW]			
    cmp     x19, x23						
    b.ne    return	//if they are not equal, skip to return and x0 will remain false						

    ldr     x19, [cuboid1BaseRegister, cuboidDimensionN + dimensionL] //comparing length		
    ldr     x23, [cuboid2BaseRegister, cuboidDimensionN + dimensionL]	
    cmp     x19, x23					
    b.ne    return//if they are not equal, skip to return and x0 will remain false		

    ldr     x19, [cuboid1BaseRegister, cuboidHeight] //comparing length		
    ldr     x23, [cuboid2BaseRegister, cuboidHeight]	
    cmp     x19, x23					
    b.ne    return							

    mov     x0, TRUE		//if everything is equal, then x0 is true												


return:	
    ldp     fp, lr, [sp], 16	//deallocating frame record				
	ret							


printCuboid:	
    stp     fp, lr, [sp, -16]!	//allocating memory for subroutine				
    mov     fp, sp							
    
    mov     generalCuboidRegister, x0	//generalCuboidRegister used as a temp register to hold information in x0						
    mov     x26, x1	//x26 also used as a temp register for string input (either first or second)					

    adrp    x0, variableLabel						
    add     w0, w0, :lo12:variableLabel					
    ldr     w2, [generalCuboidRegister, cuboidPointN + pointX] //printing all relevant variables, loading from appropriate memory addresses			
    ldr     w3, [generalCuboidRegister, cuboidPointN + pointY]				//loading from appropriate memory addresses
    ldr     w4, [generalCuboidRegister, cuboidDimensionN + dimensionW]	//loading from appropriate memory addresses	
    ldr     w5, [generalCuboidRegister, cuboidDimensionN + dimensionL]		
    ldr     w6, [generalCuboidRegister, cuboidHeight]					
    ldr     w7, [generalCuboidRegister, cuboidVolume]						
    bl      printf						
		
    ldp     fp, lr, [sp], 16			//deallocating frame record		
	ret


newCuboid:		
    stp     fp, lr, [sp, -16]! //allocating memory for subroutine			
    mov     fp, sp						
    
    mov     generalCuboidRegister, x0	//generalCuboidRegister used as a temp register to hold information in x0	

    mov     w8, INIT_XPOINT   //initializing variables in temp registers first
    mov     w9, INIT_YPOINT							
    mov     w10, INIT_WIDTH							
    mov     w11, INIT_LENGTH
    mov     w12, INIT_HEIGHT
    mul     w13, w10, w11
    mul     w13, w13, w12 //calculating volume

    str     w8,	[generalCuboidRegister, cuboidPointN + pointX]		//storing variables into their appropriate addresses on stack
    str     w9, [generalCuboidRegister, cuboidPointN + pointY]			//storing variables into their appropriate addresses on stack
    str     w10, [generalCuboidRegister, cuboidDimensionN + dimensionW]//storing variables into their appropriate addresses on stack			
    str     w11, [generalCuboidRegister, cuboidDimensionN + dimensionL]			
    str     w12, [generalCuboidRegister, cuboidHeight]						
    str     w13, [generalCuboidRegister, cuboidVolume]


    ldp     fp, lr, [sp], 16						
	ret	


main:		
    stp     fp, lr, [sp, alloc]! //allocating enough memory for main	
    mov     fp, sp	//update FP to SP						
    
    add     cuboid1BaseRegister, fp, cuboid1Base	//setting address of cuboid1 into a register, will serve over entire program				
    add     cuboid2BaseRegister, fp, cuboid2Base	//setting address of cuboid2 into a register						

    mov     x0, cuboid1BaseRegister		//giving x0 cuboid1 address and passing it into createCuboid subroutine					
    bl      newCuboid							
    mov     x0, cuboid2BaseRegister		//updating x0 to cuboid2 address and passing it into createCuboid subroutine										
    bl      newCuboid						

    adrp    x0, initialLabel		//printing the initial label 				
    add     w0, w0, :lo12:initialLabel					
    bl      printf
    	
    mov     x0, cuboid1BaseRegister	//again using x0 to pass information to next printCuboid subroutine						
    adrp    x1, firstString		//loading first string into x1				
    add     w1, w1, :lo12:firstString				//load lower 12 bits
    bl      printCuboid		//printCuboid subroutine is called					

    mov     x0, cuboid2BaseRegister	//essentially same process as above						
    adrp    x1, secondString						
    add     w1, w1, :lo12:secondString					
    bl      printCuboid							
						
    
    bl      equalSize	//once the cuboids are created and initial values printed, we can now move into equalSize subroutine to compare their attributes						
    					
    cmp     x0, TRUE		//comparing the x0 value we get from subroutine equalsize 			
    b.ne    printChanged //if the value was not equal to true, we can skip the moving/scaling subroutines 					

    mov     x0, cuboid1BaseRegister	//if the value was true, then we have to execute these instructions						
    mov     w1, MOVE_X	//temp registers for holding the moved x and y values						
    mov     w2,	MOVE_Y							
    bl      move								

    mov     x0, cuboid2BaseRegister //once cuboid1 is moved, we can load cuboid2s information into x0 and use it scale subroutine						
    mov     w1, SCALE_FACTOR	//loading scale factor into register				
    bl      scale					


printChanged: 			
    adrp    x0, changeLabel		//printing changed cuboid attributes			
    add     w0, w0, :lo12:changeLabel	//label printing				
    bl      printf	
    
    mov     x0, cuboid1BaseRegister							
    adrp    x1, firstString						
    add     w1, w1, :lo12:firstString			
    bl      printCuboid							

    mov     x0, cuboid2BaseRegister						
    adrp    x1, secondString						
    add     w1, w1, :lo12:secondString					
    bl      printCuboid							


exit://exiting program 
	mov 	w0, 0
	ldp 	fp, lr, [sp], dealloc		//Deallocate stack memory
	ret	//return to caller