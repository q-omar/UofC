// Bitwise logical instructions 

output_str:	.string "arg1= %04X\narg2= %04X\nres = %04X\n\n"		//prints up to 4 hex digits, pads with zero from left
output_res: .string "res = %04X\n\n"
output_str_long: .string "arg1= %04X\narg2= %04X\nres = %lX\n\n"
output_res_long: .string "res = %lX\n\n"

not_str: .string "=======NOT========\n"
and_str: .string "=======AND========\n"
or_str: .string "=======OR========\n"
xor_str: .string "=======XOR========\n"
and_not_str: .string "=======AND NOT========\n"
or_not_str: .string "=======OR NOT========\n"
xor_not_str: .string "=======XOR NOT========\n"
ands_str: .string "=======ANDS========\n"

not_equal: .string "ANDS not equal\n"
yes_equal: .string "ANDS is equal\n"


	.balign 4
	.global main
	
main:
	stp x29, x30, [sp,-16]!				//Save fp and lr to stack
	mov x29, sp							//update FP to current SP


	
not:	
	mov x19, 0b1111000011110000			//this is 0xF0F0
	mvn x19, x19						//logical not
	
	
	
	//print result
	adrp x0, not_str					
	add x0, x0, :lo12:not_str			
	bl printf
	adrp x0, output_res_long					
	add x0, x0, :lo12:output_res_long			
	mov x1, x19	
	bl printf
	
	0x33333333
	0x00000777
and:
	mov x19, 0b1111					
	mov x20, 0b1100						//this bitmask sets deletes all but the 2 bits
	and x21, x19, x20					//and

	
	
	
	adrp x0, and_str					
	add x0, x0, :lo12:and_str			
	bl printf
	adrp x0, output_str					
	add x0, x0, :lo12:output_str			
	mov x1, x19	
	mov x2, x20
	mov x3, x21
	bl printf

or:
	mov x19, 0b10000000
	mov x20, 0b00001111					//this bitmask sets the first 4 bits to 1
	orr x21, x19, x20					//inclusive OR

	
	
	
	adrp x0, or_str					
	add x0, x0, :lo12:or_str			
	bl printf
	adrp x0, output_str					
	add x0, x0, :lo12:output_str			
	mov x1, x19	
	mov x2, x20
	mov x3, x21
	bl printf

xor:
	mov x19, 0b1010101010001010
	mov x20, 0b0000000011111111				//this bitmask toggles only the first 8 bits
	eor x21, x19, x20						//exclusive or

	
	
	
	adrp x0, xor_str					
	add x0, x0, :lo12:xor_str			
	bl printf
	adrp x0, output_str					
	add x0, x0, :lo12:output_str			
	mov x1, x19	
	mov x2, x20
	mov x3, x21
	bl printf
	
and_not:
	mov x19, 0b1010101010101010
	mov x20, 0b0000000011111111				//this bitmask clears only the first 8 bits
	bic x21, x19, x20						//bit clear, AKA and-not

	
	
	
	
	adrp x0, and_not_str					
	add x0, x0, :lo12:and_not_str			
	bl printf
	adrp x0, output_str					
	add x0, x0, :lo12:output_str			
	mov x1, x19	
	mov x2, x20
	mov x3, x21
	bl printf
	
or_not:
	mov x19, 0b1111111100000000
	mov x20, 0b0000000011111111				//this register (0xFF) gets negated then OR'ed
	orn x21, x19, x20						//inclusive or-not

	
	
	
	adrp x0, or_not_str					
	add x0, x0, :lo12:or_not_str			
	bl printf
	adrp x0, output_str					
	add x0, x0, :lo12:output_str			
	mov x1, x19	
	mov x2, x20
	mov x3, x21
	bl printf
	
	
xor_not:
	mov x19, 0b1010101010001010
	mov x20, 0b0000111111110000				//this bitmask toggles every bit other bit but the first 8 bits
	eon x21, x19, x20						//exclusive-or-not

	
	

	adrp x0, xor_not_str					
	add x0, x0, :lo12:xor_not_str			
	bl printf
	adrp x0, output_str_long					
	add x0, x0, :lo12:output_str_long			
	mov x1, x19	
	mov x2, x20
	mov x3, x21
	bl printf
	
ands:
	mov x19, 0b1101
	mov x20, 0b1001
	ands xzr, x19, x20
	b.ne yes_ands
	
no_ands:
	
	//Result of ANDS compare is false
	adrp x0, ands_str					
	add x0, x0, :lo12:ands_str			
	bl printf
	adrp x0, not_equal					
	add x0, x0, :lo12:not_equal			
	bl printf
	
	b end_ands_if
	
yes_ands:	

	//Result of ANDS compare is true
	adrp x0, ands_str					
	add x0, x0, :lo12:ands_str			
	bl printf
	adrp x0, yes_equal					
	add x0, x0, :lo12:yes_equal			
	bl printf
	
end_ands_if:
	
	//return 0 for main
	mov w0, 0
exit:
	ldp x29, x30, [sp], 16			 //restore stack
	ret								 //return to caller