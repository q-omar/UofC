//Array of Pointers

define(seasonR, w19) 
define(seasonVal, x20)

// This section contains program text (machine code) - programmer initialized
		.text 								
fmt: 	.string "\nseason[%d] = %s\n"
spr_var: 	.string "spring"
sum_var: 	.string "summer" 
fal_var: 	.string "fall"
win_var: 	.string  "winter"

// This section contains programmer-initialized data
			.data 								// Create array of pointers
			.balign 8 							// Must be double-word aligned 
season_var: .dword spr_var, sum_var, fal_var, win_var

		.text 
		.balign 4 
		.global main
main: 
		stp x29, x30, [sp, -16]! 
		mov x29, sp
		mov seasonR, 0 
		b test
top: 
		adrp x0, fmt 
		add x0, x0,:lo12:fmt 				// set up 1st arg

		mov w1, seasonR					// set up 2nd arg
		adrp seasonVal, season_var				// Load array base address
		add seasonVal, seasonVal, :lo12:season_var
		
		ldr x2, [seasonVal, seasonR, SXTW 3] 		// set up 3rd arg bl printf

		bl printf



		
		
		ldp x29, x30, [sp], 16 
		ret
