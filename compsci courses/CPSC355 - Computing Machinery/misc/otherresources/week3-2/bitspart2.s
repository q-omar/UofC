// Bitwise logical instructions 
0xffff1000
0xffffffe0
output_str:	.string "arg1= %lX\nres= %lX\n\n"		//prints up to 4 hex digits, pads with zero from left
output_res: .string "res = %lX\n\n"
output_num: .string "res = %d\n\n"

lsl_str: .string "=======Logical Shift Left========\n"
lsr_str: .string "=======Logical Shift Right========\n"
asr_str: .string "=======Arithmetic shift right========\n"
asl_str: .string "=======Arithmetic shift left========\n"

rotate_r_str: .string "=======Rotate right========\n"
rotate_l_str: .string "=======Rotate left========\n"

signed_extend_str: .string "=======Signed Extend========\n"
unsigned_extend_str: .string "=======Unsigned Extend========\n"
output_extend: .string "Old = %d\nOld(hex) = %X\nExtended = %ld\nExtended (hex)=%lX\n\n"						//signed
output_unsigned_extend: .string "Old = %u\nOld(hex) = %04X\nExtended = %lu\nExtended (hex)= %lX\n\n"			//unsigned


	.balign 4
	.global main
	
main:
	stp x29, x30, [sp,-16]!				//Save fp and lr to stack
	mov x29, sp							//update FP to current SP


	
lsl:	
	mov x19, 2			
	lsl x20, x19, 4						//logical shift left, multiply by 2^4
	
	
	
	//print result
	adrp x0, lsl_str					
	add x0, x0, :lo12:lsl_str			
	bl printf
	adrp x0, output_num					
	add x0, x0, :lo12:output_num			
	mov x1, x19	
	bl printf
	
	
lsr:
	mov x19, 85														
	lsr x19, x19, 4						//logical shift right, divide by 2^4
	
	
	
	//print result
	adrp x0, lsr_str					
	add x0, x0, :lo12:lsr_str			
	bl printf
	adrp x0, output_num					
	add x0, x0, :lo12:output_num			
	mov x1, x19	
	bl printf
	
asr:
	mov x19, -85														
	asr x19, x19, 4						//arithmetic shift right, divide by 2^4, preserves sign
	
	
	
	//print result
	adrp x0, asr_str					
	add x0, x0, :lo12:asr_str			
	bl printf
	adrp x0, output_num					
	add x0, x0, :lo12:output_num			
	mov x1, x19	
	bl printf

rotate_r:
	mov x19, 0xF11F
	ror x19, x19, 16					//rotate right 16 times

	
	
	//print result
	adrp x0, rotate_r_str				//NOTE: printf does not print this result out correctly, use GDB to check
	add x0, x0, :lo12:rotate_r_str			
	bl printf
	adrp x0, output_res					
	add x0, x0, :lo12:output_res			
	mov x1, x19	
	bl printf

rotate_l:
	mov x19, 0b00111100					//0x3C
	ror x19, x19, 62					//simulate rotate left by 2, by rotating the 62 times to the right in this 64-bit register
	
	
	//print result
	adrp x0, rotate_l_str					
	add x0, x0, :lo12:rotate_l_str			
	bl printf
	adrp x0, output_res					
	add x0, x0, :lo12:output_res			
	mov x1, x19	
	bl printf
	
signed_extend:
	mov w19, 0xFFFFFFFD					//-3
	sxtw x20, w19						//Sign extend a word (32-bits) to a doubleword (64-bits)

	
	
	//print result
	adrp x0, output_extend				
	add x0, x0, :lo12:output_extend
	mov w1, w19
	mov w2, w19	
	mov x3, x20
	mov x4, x20
	bl printf
	
unsigned_extend:
	mov w19, 0xFFFFFFFD					//4294967293
	uxtw x20, w19						//unsigned extend a word (32-bits) to a doubleword (64-bits)

	
	
	//print result
	adrp x0, unsigned_extend_str					
	add x0, x0, :lo12:unsigned_extend_str			
	bl printf
	adrp x0, output_unsigned_extend				
	add x0, x0, :lo12:output_unsigned_extend
	mov w1, w19
	mov w2, w19	
	mov x3, x20
	mov x4, x20
	bl printf
	
return:
	
	//return 0 for main
	mov w0, 0
exit:
	ldp x29, x30, [sp], 16			 	//restore stack
	ret								 	//return to caller