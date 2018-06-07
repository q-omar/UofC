//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 5

//The following assembly code is called by the main method in the accompanying C code. The C code calls upon
//the global methods defined here. The program can push integers to the stack, pop them, and display them in order



define(STACKSIZE,5) //specify constant stacksize macro                                 
define(FALSE,0)     //setting constants false and true macros                                
define(TRUE,1)                                       

define(top64, x20) //top 64 register
define(top32, w22) // top 32register
define(valueR, w23)  // value register
define(i_reg,w24) //i register


fp .req x29 //register aliases
lr .req x30


defineStrings:
    stackOverflow:   .string "\nStack overflow! Cannot push value onto stack.\n" //defining strings
    stackUnderflow:  .string "\nStack underflow! Cannot pop an empty stack.\n"
    stackEmptyStr:   .string "\nEmpty stack\n"
    stackContents:   .string "\nCurrent stack contents:\n"
    stackIndex:      .string "%d"
    stackTop:        .string " <-- top of stack"
    linebreak:       .string "\n"

    .balign 4
    .global push, pop, display //setting subroutines as global so C code can call it



push:                                          
    stp     x29, x30, [sp, -16]! //allocate memory on stack
    mov     x29, sp //fp to sp link

    mov     valueR, w0 //store pushed value into register
    bl      stackFull //branch to stackfull to return a boolean
    cmp     w0, TRUE //if not true, push
    b.ne    pushElse  //by branching to else

pushIf:                              
    adrp    x0, stackOverflow //otherwise print overflow message, load higher order bits
    add     x0, x0, :lo12:stackOverflow   //lower order bits
    bl      printf  //call print function
    
    b       pushEnd //branch to end                                      

pushElse:
    adrp    top64, top //load higher and lower order bits                              
    add     top64, top64, :lo12:top  
    ldr     top32, [top64] //then load from x19 into top register
    
    add     top32, top32, 1 //increment top
    str     top32, [top64] //store top
    
    adrp    x21, stack //load higher and lower order bits, reading from stack
    add     x21, x21, :lo12:stack              
    str     valueR, [x21, top32, SXTW 2] // store value into stack
    
pushEnd:
    ldp     x29, x30, [sp], 16 //deallocate memory and return to calling code
    ret 



pop:                                            
    stp     x29, x30, [sp, -16]! //allocate memoryy
    mov     x29, sp  //link fp and fp                  

    bl      stackEmpty //branch to stackempty to return boolean
    cmp     w0, TRUE //if stack isnt empty                              
    b.ne    popElse //branch to else

popIf:
    adrp    x0, stackUnderflow //otherwise print stack is underflow      
    add     x0, x0, :lo12:stackUnderflow           
    bl      printf //calling print
    mov     x0, -1  //return negative 1

    b       popEnd                             

popElse:
    adrp    top64, top //if stack isnt underflow, read top (load higher/lower order bits)   
    add     top64, top64, :lo12:top                    
    ldr     top32, [top64] //load value of top into top register
    
    adrp    x21, stack //read stack, higher and lower bits
    add     x21, x21, :lo12:stack 
    ldr     valueR, [x21, top32, SXTW 2] //load index of stack that is at top, stack[top]            
    
    sub     top32, top32, 1  // top = top - 1
    str     top32, [top64] //store top
    mov     w0, valueR // return value

popEnd:
    ldp     x29, x30, [sp], 16 //deallocate and return to calling code
    ret   



stackFull:                               
    stp     x29, x30, [sp, -16]! //allocate memory                 
    mov     x29, sp //equate fp to sp

    adrp    top64, top  //loading higher and lower bits of top                    
    add     top64, top64, :lo12:top 
    ldr     top32, [top64] //putting into register

    cmp     top32, STACKSIZE - 1                    
    b.ne    stackFullElse //else branch to false

 stackFullIf:   
    mov     x0, TRUE   //otherwise true                      
    b       stackFullEnd //branch to end                                   

stackFullElse:
    mov     x0, FALSE //setting flag appropriately

stackFullEnd:
    ldp     x29, x30, [sp], 16  //deallocate and return to calling code
    ret                                        



stackEmpty:                          
    stp     x29, x30, [sp, -16]!  //allocate memory,                 
    mov     x29, sp  //link fp to sp                             

    adrp    top64, top //loading higher/lower order bits of top                         
    add     top64, top64, :lo12:top              
    ldr     top32, [top64]  //loading top into register

    cmp     top32, -1   //checking empty
    b.ne    stackEmptyElse //if it isnt equal to -1, its not empty branch to false

stackEmptyIf:
    mov     x0, TRUE  //otherwise it is empty
    b       stackEmptyEnd

stackEmptyElse:
    mov     x0, FALSE //not empty flag

stackEmptyEnd:
    ldp     x29, x30, [sp], 16  //deallocate memory
    ret 



display:                                        
    stp     x29, x30, [sp, -16]!  //allocate memory,                 
    mov     x29, sp  //link fp to sp   
    
    bl      stackEmpty  //branch to stack empty to return boolean
    cmp     w0, TRUE //if true, print empty
    b.ne    displayElse

displayIf:
    adrp    x0, stackEmptyStr   //printing stack empty, load higher order bits
    add     x0, x0, :lo12:stackEmptyStr   //lower order bits            
    bl      printf  
    b       displayEnd //if its empty, just go to end 

displayElse:
    adrp    x0, stackContents //printing current content tag
    add     x0, x0, :lo12:stackContents
    
    adrp    top64, top      //loading top
    add     top64, top64, :lo12:top
    ldr     top32, [top64]    
    mov     i_reg, top32 //move top value into register i 
      
    b       loopTest //looping to print all values on stack

loop:
    adrp    x21, stack //read stack, higher and lower bits
    add     x21, x21, :lo12:stack 
    ldr     w28, [x21, i_reg, SXTW 2] //load index of stack that is at top, stack[i_reg]   
    
    adrp    x0, stackIndex //loading higher and lower bits of stack index
    add     x0, x0, :lo12:stackIndex
    mov     w1, w28 //setting register for printing
    bl      printf

    cmp     i_reg, top32 //check if current value i is == top
    b.ne    updateLoop //if not, decrement

    adrp    x0, stackTop //printing stacktop
    add     x0, x0, :lo12:stackTop
    bl      printf

updateLoop:
    adrp    x0, linebreak //pritning a linebreak character
    add     x0, x0, :lo12:linebreak
    bl      printf
    sub     i_reg, i_reg, 1 //then decrementing index i by 1

loopTest:
    cmp     i_reg, 0 //checking if register i value is >= 0
    b.ge    loop //then loop otherwise end

displayEnd:
    ldp     x29, x30, [sp], 16   //deallocate memory, return to calling code
    ret                                         
