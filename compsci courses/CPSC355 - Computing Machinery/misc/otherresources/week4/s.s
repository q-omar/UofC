@NOTE: This was a fun way to test assembly knowledge
@PROGRAM SORTS AN INPUT FILE OF INTEGERS USING SELECTION SORT
@CURRENT CONSTRAINTS:
  ; INTEGERS MUST BE POSITIVE
  ; INTEGERS MUST BE > 0
  ; INTEGERS MUST BE PLACED ON SEPARATE LINES
  ; EXAMPLE: 2 - SORT -> 1 ;
  ;          1 - SORT -> 2 ;
  ;          8 - SORT -> 3 ;
  ;          3 - SORT -> 8 ;
  
@ Explanation:	https://lacanlale.weebly.com/blog/selection-sort-in-assembly-part-1 (PT1) 
@		https://lacanlale.weebly.com/blog/selection-sort-in-assembly-part-2 (PT2)

  .equ openFile, 0x66 @OPENS FILE
  .equ closeFile, 0x68 @CLOSES FILE
  .equ printInt, 0x6b @ PRINTS INT
  .equ readInt, 0x6c @READ INT FROM FILE
  .equ printStr, 0x69 @ PRINTS STRING WITH A NULL ENDING
  .equ stdout, 1 @OUTPUT
  .equ exit, 0x11 @EXITS PROGRAM

  .global _start
  .text
  _start:
stmfd sp!, {r0, r1, r3, r4, r5, r6} @connecting ldmfd gets called at the end of the program
mov r0, #stdout
ldr r1, =WelcomeMssg
swi printStr

bl ReadArr
b Sort

@=============================================================================|
@ READ METHOD                                                                 |
@ R0 -> ARRAY VALUE; HOLDS STARTING MEMORY POS OF THE ARRAY                   |
@ R1 -> ARRAY.LENGTH; INCREMENTS +1 FROM 0 UNTIL THE LAST INTEGER IN THE FILE |
@=============================================================================|
  ReadArr:
  @r0: holds file; holds file handle; returns array
  @r1: output type; array limit (arr.length)
  @r2: temp array holder
  @r3: counter variable; index
  @r4: file handle holder
stmfd sp!, {r2, r3, r4}
ldr r0, =InputFile
mov r1, #0
swi openFile
bcs ErrExit
mov r4, r0
ldr r2, =Array
b ReadLoop
ReadLoop:
  swi readInt
  bcs EndOfFile
  str r0, [r2, r3, LSL #2]
  mov r0, r4
  add r3, r3, #1
  b ReadLoop
EndOfFile:
mov r0, r4
swi closeFile
ldr r0, =Array @Move the array pos to r0
mov r1, r3
ldmfd sp!, {r2, r3, r4}
bx lr

@====================================|
@ SORTS ARRAY USING SELECTION METHOD |
@====================================|
  Sort:
  @r0: array
  @r1: array limit (size)
  @r2: loop counter
  @r3: swap index
  @r4: item that will be swapped
  @r5: item that will be swapped
mov r2, #0
OuterLoop:
  cmp r2, r1
  bge End
  mov r3, r2
  ldr r4, [r0, r3, lsl #2]
  stmfd sp!, {r2}
  add r2, r2, #1
InnerLoop:
  cmp r2, r1
  bge InnerLoopEnd
  ldr r5, [r0, r2, lsl #2]
  cmp r4, r5
  bge GreaterThan
  add r2, r2, #1
  b InnerLoop
InnerLoopEnd:
  ldmfd sp!, {r2} @this call of stmfd/ldmfd on r2 was an effort to minimize register use
  ldr r5, [r0, r2, lsl #2]
  str r4, [r0, r2, lsl #2]
  str r5, [r0, r3, lsl #2]
  add r2, r2, #1
  b OuterLoop
GreaterThan:
  mov r3, r2
  ldr r4, [r0, r3, lsl #2]
  add r2, r2, #1
  b InnerLoop
@==============|
@ PRINTS ARRAY |
@==============|
  PrintArr:
  @r0: stdout
  @r1: item that will be printed
  @r2: counter
  @r3: array
  @r4: array size
mov r2, #0
mov r3, r0
mov r4, r1
PrintLoop:
  cmp r2, r4
  bxge lr
  mov r0, #stdout
  ldr r1, =Line
  swi printStr
  mov r0, #stdout
  ldr r1, [r3, r2, lsl #2]
  swi printInt
  add r2, r2, #1
  b PrintLoop
@==============|
@ EXIT METHODS |
@==============|
  ErrExit:
mov r0, #stdout
ldr r1, =Line
swi printStr
mov r0, #stdout
ldr r1, =FileErr
swi printStr
b End

  End:
bl PrintArr
mov r2, #0
mov r0, #stdout
ldr r1, =Line
swi printStr
mov r0, #stdout
ldr r1, =GoodbyeMssg
swi printStr
ldmfd sp!, {r0, r1, r3, r4, r5, r6} @used purely for the purpose of clearing any values that were left behind after method utilization

@=================================|
@ EXTRA DATA, FILE INPUT INCLUDED |
@=================================|
  .data
InputFile: .asciz "input.txt"
FileErr: .asciz "!!ERROR. NO FILE OPENED!!"
WelcomeMssg: .asciz "!!BEGINNING PROGRAM!!"
GoodbyeMssg: .asciz "!!ENDING PROGRAM!!"
SortedMssg: .asciz "!!SORTED SET!!"
Line: .asciz "\n"
.align
Array: .skip 1
	.end