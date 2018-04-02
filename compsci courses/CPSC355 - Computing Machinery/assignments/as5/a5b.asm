//CPSC 355
//Student: Safian Omar Qureshi
//ID 10086638
//Assignment 5

//The following assembly code takes two number arguments when executed corresponding with the month and day.
//It then prints the month and day and for invalid numbers it prints the usage case. Depending on the month
//and day entered, it will print a corresponding season.

//Program limitations: seasons are based entirely on month, not day. 3 months per season ie winter is Dec, Jan, Feb and so on


define(monthR, w19) //defining register macros for month, day, seasons
define(dayR, w20)
define(seasonR, w21)

define(monthBase, x22) //defining macros for base pointers of month, suffix and seasons
define(suffixBase, x23)
define(seasonBase, x25)


fp .req x29 //register aliases
lr .req x30

argN .req w22  //argument aliases for number of arguments and value of arguments                       
argV .req x24                           


defineStrings:
    display: .string "%s %d%s is %s \n" // print month day and season 

    jan: .string "January" //labels for months
    feb: .string "Febuary"
    mar: .string "March"
    apr: .string "April"
    may: .string "May"
    jun: .string "June"
    jul: .string "July"
    aug: .string "August"
    sep: .string "September"
    oct: .string "October"
    nov: .string "November"
    dec: .string "December"

    st:  .string "st" //labels for suffixes 
    nd:  .string "nd"
    rd:  .string "rd"
    th:  .string "th"

    winter: .string "Winter" //labels for seasons
    spring: .string "Spring"
    summer: .string "Summer"
    fall:   .string "Fall"

    errString: .string "usage: a5b mm dd\n" //error string specifying usage


monthPters: .dword  jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec //array of pointers for month suffix and seasons
suffixPters: .dword  st, nd, rd, th, th, th, th, th, th, th, th, th, th, th, th, th, th, th, th, th, st, nd, rd, th, th, th, th, th, th, th, st
seasonPters: .dword winter, spring, summer, fall

    .balign 4  //align text
    .global main //make visible to OS


main:       
    stp     fp, lr, [sp, -16]!  //allocating memory on stack
    mov     fp, sp     //equaling frame pointer to stack pointer

    mov     argN, w0  //copy w0 to argN
    mov     argV, x1  //copy x1 to argV
    mov     w26, 1   //month argument                          
    mov     w27, 2   //day argument                          


argumentCheck:
    cmp     argN, 3  //comparing if the arguments are equal to 3 
    b.ne    errorMsg   //if not, go to error message

    ldr     x0, [argV, w26, SXTW 3]  //loading month from stack into x0       
    bl      atoi   //convert the string to int                            
    mov     monthR, w0    //put month into register for comparsion

    cmp     monthR, 12 //if month argument is greater than 12 or less than 1, go to error string
    b.gt    errorMsg //branching to error                             
    cmp     monthR, 1                            
    b.lt    errorMsg                           

    ldr     x0, [argV, w27, SXTW 3] //load day from stack into x0            
    bl      atoi   //convert string to int                             
    mov     dayR, w0   // put day into register for comparison
    
    cmp     dayR, 31 // compare day with 31
    b.gt    errorMsg // if greater than 31, branch to error
    cmp     dayR, 1// compare day with 1
    b.lt    errorMsg // if less than one, branch to error                    
    
    
//this is an efficient *cough* algorithm that ignores the day parameter. Was too busy trying to finish part A   
seasonAlgo:   
    mov     w9, monthR //storing month into temp register for seasonal calculations
    mov     seasonR, 0 //by default, if month is 12, season is winter and skip to printing
    cmp     monthR, 12
    b.eq    printing


springCheck:  
    sub     w9, w9,  3 //currentvalue - lowerbound(3) <= upperbound(5) - lowerbound(3)
    cmp     w9, 2  //essentially checking if month value is either 3, 4, or 5
    b.hi    summerCheck //if not, check summer
    mov     seasonR, 1 //spring then is march, april, may
    b       printing //skip to printing
   

summerCheck:
    mov     w9, monthR  //reset month
    sub     w9, w9,  6//checking if month value is either 6, 7 or 8
    cmp     w9,  2 //if not, check fall
    b.hi    fallCheck //summer then is june, july, august
    mov     seasonR, 2
    b       printing


fallCheck:
    mov     w9, monthR //reset month
    sub     w9, w9,  9//checking if month value is either 10, 11 or 12
    cmp     w9,  2 //if not, it is winter
    b.hi    otherwiseWinter
    mov     seasonR, 3 //fall then is september, october, november
    b       printing


otherwiseWinter:
    mov     seasonR, 0 //winter is december (from the top) or january or february


printing: 
    adrp    x0, display    //setting up string display                    
    add     x0, x0, :lo12:display // set up 1st arg (month) higher order bits      

    adrp    suffixBase, monthPters  //load higher order bits of month
    add     suffixBase, suffixBase, :lo12:monthPters //load lower order bits
    sub     monthR, monthR, 1  // month = month - 1 
    ldr     x1, [suffixBase, monthR, SXTW 3] // set up 1st arg month lower order bits

    adrp    monthBase, suffixPters //loading higher and lower order bits of second argument
    add     monthBase, monthBase, :lo12:suffixPters      
    mov     w2, dayR    // set up 2nd arg (day)
    sub     dayR, dayR, 1 // day = day - 1
    ldr     x3, [monthBase, dayR, SXTW 3] //set 3rd arg suffix

    adrp    seasonBase, seasonPters //loading higher and lower bits of third seasonal argument		
	add     seasonBase, seasonBase, :lo12:seasonPters	
	ldr     x4, [seasonBase, seasonR, SXTW 3] //set 4th arg season	

    bl      printf  //calling print function 
    b       exit


errorMsg:                                       
    adrp    x0, errString // set up 1st arg higher order bits
    add     x0, x0, :lo12:errString // set up 1st arg lower order bits                
    bl      printf   //call print function 
  

exit:            
    mov     w0, 0   //set up return value of 0 from main                      
    ldp     fp, lr, [sp], 16 //restore FP and LR from stack, post-increment SP
    ret //return to calling code in OS

