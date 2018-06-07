//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 6

//The following ARM assembly code calculates the function ln(x) for real x values > 1/2. It does so by first
//reading an input file containing floating points x>1/2. Those numbers are used as 
//x values and a series representation, formula being 1/1(x-1)/x +  1/2 ((x-1)/x)^2+  1/3 ((x-1)/x)^3... is
//used to calculate the ln(x) function 

//macros
define(fdReg, w19) //file descriptor register
define(nreadRegg, x20) //# bytes read
define(bufferBaseReg, x21) //buffer base register

//assembly equates
bufferAdd = 16	//buffer address in memory
bufferSize = 8 //size of buffer
alloc = -(16 + bufferSize) & -16 //allocation
dealloc = -alloc //deallocation 

//define register aliases
fp .req x29
lr .req x30

numerator    .req d19 //numerator floating point register
denominator  .req d20                           
negativeone  .req d21 //negative one register for x - 1
term         .req d22 //final term after operations are complete                                 
summation    .req d23 //summing them up
increment    .req d24 //increment by 1 each time for term                               
coefficient	 .req d25 //coefficient register for 1/1, 1/2, 1/3...	
termOne		 .req d26 //used for breaking down equation


defineStrings:
	threshold:   	.double 0r1.0e-13     //arbitrary small constant to compare final term with to end summation                     
	fileName: 		.string "input.bin" //file name to open
	error: 			.string "Error opening file. Program aborted." //error string
	output: 		.string "%13.10f\t%13.10f  \n" //output data
	columnLabel: 	.string "x value:\t ln(x):\t\t\n"  // label of output columns


	.global main //global main to make it visible to OS
	.balign 4	//instructions must be word aligned


main:
 	stp 	fp, lr, [sp, alloc]! //save fp, lr to stack, preincrement sp
	mov 	fp, sp

	adrp    x0, columnLabel //printing initial label for columns
    add 	x0, x0, :lo12:columnLabel 
    bl  	printf 

	mov 	w0, -100 //argument for opening binary file
	adrp 	x1, fileName // 2nd arg (fileName)
	add 	x1, x1, :lo12: fileName
	
	mov 	w2, 0 //specify it as read only (3rd arg)	
	mov 	x8, 56 //openat I/O, open file
	svc 	0	//sys function

	mov 	fdReg, w0 //record fd register
	cmp 	fdReg, 0 //check if fd is -1 for errors
	b.ge 	fileOpened	//noerror then branch, otherwise print error message

	adrp 	x0, error //first higher order argument
 	add 	x0, x0, :lo12:error	//first arguement, lower order bits
	bl 		printf

	mov 	w0, -1 //return -1 and exit program
	b 		exit

fileOpened:
	add 	bufferBaseReg, x29, bufferAdd //calc base addresss

readFile:
    mov 	w0, fdReg //first arg fd
    mov 	x1, bufferBaseReg //2nd arg buffer
	mov 	w2, bufferSize //3rd arg bytes to read
	mov 	x8, 63 //read request
	svc 	0 //sys function

	mov 	nreadRegg, x0 //record number of bytes read
	cmp 	nreadRegg, bufferSize //if read doesnt equal buffer size, read filed
	b.ne 	end //exiting loop

	ldr 	d0, [bufferBaseReg] //loading d0 to put data into 
	bl 		lnFunction //algorithm for ln(x)
	fmov    d1, d0 //putting into another register
	ldr 	d0, [bufferBaseReg] //loading the input once more
	 
	adrp 	x0, output	//loading arguments for printing data (initial x value, ln(x) function value)
    add 	x0, x0, :lo12:output					
    ldr 	x1, [bufferBaseReg] 			
	bl 		printf
	b 		readFile 

end: // close the text file
	mov 	w0, fdReg
	mov 	x8, 57
	svc 	0
	mov 	w0, 0
	b 		exit



lnFunction: 
	stp 	x29, x30, [sp, -16]! //allocate memory
    mov 	x29, sp //fp = sp

	adrp 	x22, threshold //load threshold higher bits
    add 	x22, x22, :lo12:threshold //lower bits
    ldr 	d3, [x22] //into d3 float register for comparison later

    fmov    increment, 1.0 //incrementing terms by 1 
    fmov    summation, xzr  // summation starts at 0
	fmov	negativeone, -1.0 //negative one for x - 1
	fmov	coefficient, 1.0 //coefficient starts at 1

	fmov    numerator, d0 // numerator = x
	fadd	numerator, numerator, negativeone //x = x - 1
	fmov	denominator, d0	//denominator = x
    fdiv    termOne, numerator, denominator  //termOne = x-1/x
	fmov	d0, termOne //putting into d0 for looping later
	
	fmul	term, termOne, coefficient // first term = (1)*(x-1/x)
    fadd    summation, summation, term // summation = 0 + first term

	b 		loopTest

loop:  //loop for rest of terms                                    
    fmov 	coefficient, 1.0 //coefficient numerator is always 1
	fadd	increment, increment, coefficient //incr = incr + 1 essentially
	fdiv	coefficient, coefficient, increment //coefficient is now 1/increment...

	fmul	termOne, termOne, d0 //(x-1/x) * (x-1/x)...

	fmul	term, termOne, coefficient //1/incr... * (x-1/x)*(x-1/x)... 
	fadd    summation, summation, term // summation = sum of previous terms + latest term	
	
loopTest:
	fabs 	term, term //check if absolute value of last term is less than threshold, if so exit loop
	fcmp    term, d3  // if term >= threshold:
    b.ge    loop  //do loop
    fmov    d0, summation  // d0 = summation, return back to main

    ldp 	x29, x30, [sp], 16  // deallocate memory
    ret  // return to caller



exit:
	ldp 	fp, lr, [sp], dealloc //restore fp lr from stack, post increment sp
    ret		//return to caller