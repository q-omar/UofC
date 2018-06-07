.section .text
.global print

//the print subroutine called by main uses an argument r0 passed to it to print a 
//corresponding string. It's a bunch of if else if statements essentially

print:
	push 	{lr}
	mov		r3, #14 //14 is arbitrary, used for printing prompt
	cmp		r0, r3 //if its 14, print the prompt
	bne 	printName //otherwise check another r0 value
	ldr		r0, =prompt
	bl		printf
	b 		done
	
printName:
	mov 	r3, #13 //if its 13, print name
	cmp		r0, r3
	bne 	bButton
	ldr		r0, =name
	bl		printf
	b 		done

bButton:
	mov		r3,	#0x7fff //now we check if the r0 buttonword passed is a hex value
	cmp 	r0, r3
	bne 	rightTrigger //in particular if its 0x7fff, it will print b button otherwise check right trigger
	ldr		r0, =b_button
	bl		printf
	b 		done

rightTrigger:
	mov 	r3, #0xffef
	cmp		r0, r3 //and so on..
	bne 	yButton
	ldr		r0, =righttrigger_button
	bl		printf
	b 		done

yButton:
	mov		r3,	#0xbfff
	cmp 	r0, r3
	bne 	selButton
	ldr		r0, =y_button
	bl		printf
	b 		done
	
selButton:
	mov		r3,	#0xdfff
	cmp 	r0, r3
	bne 	startButton
	ldr		r0, =select_button
	bl		printf
	b 		done
	
startButton:
	mov		r3,	#0xefff
	cmp 	r0, r3
	bne 	joyupButton
	ldr		r0, =start_button
	bl		printf
	bl 		haltLoop
	
	
joyupButton:
	mov		r3,	#0xf7ff
	cmp 	r0, r3
	bne 	joydownButton
	ldr		r0, =joyup_button
	bl		printf
	b 		done
	
joydownButton:
	mov		r3,	#0xfbff
	cmp 	r0, r3
	bne 	joyleftButton
	ldr		r0, =joydown_button
	bl		printf
	b 		done
	
joyleftButton:
	mov		r3,	#0xfdff
	cmp 	r0, r3
	bne 	joyrightButton
	ldr		r0, =joyleft_button
	bl		printf
	b 		done
	
joyrightButton:
	mov		r3,	#0xfeff
	cmp 	r0, r3
	bne 	aButton
	ldr		r0, =joyright_button
	bl		printf
	b 		done
	
aButton:
	mov		r3,	#0xff7f
	cmp 	r0, r3
	bne 	xButton
	ldr		r0, =a_button
	bl		printf
	b 		done
	
xButton:
	mov		r3,	#0xffbf
	cmp 	r0, r3
	bne 	lefttriggerButton
	ldr		r0, =x_button
	bl		printf
	b 		done
	
lefttriggerButton:
	mov		r3,	#0xffdf
	cmp 	r0, r3
	bne 	righttriggerButton
	ldr		r0, =lefttrigger_button
	bl		printf
	b 		done
	
righttriggerButton:
	mov		r3,	#0xffef
	cmp 	r0, r3
	bne 	multi
	ldr		r0, =righttrigger_button
	bl		printf

multi: //this subroutine executes if none of the other hex decimals match, meaning user must
//be pressing multiple buttons. for this assignment though, this should not execute given user is
//only allowed to press one button at a time
	ldr r0, =multi_buttons
	bl printf
	
	
done:
	pop	{lr}
	bx lr
	
	
	
.section .data

//strings used for printing


name:
	.asciz	"By Omar Qureshi\n"
prompt:
	.asciz	"\nPlease press a button...\n"
y_button:
	.asciz	"\nUser pressed Y\n"
b_button:
	.asciz	"\nUser pressed B\n"
start_button:
	.asciz	"\nUser pressed start to terminate program, press ctrl+c to exit halt loop\n"
select_button:
	.asciz	"\nUser pressed select\n"
joyup_button:
	.asciz	"\nUser pressed joypad up\n"
joydown_button:
	.asciz	"\nUser pressed joypad down\n"
joyleft_button:
	.asciz	"\nUser pressed joypad left\n"
joyright_button:
	.asciz	"\nUser pressed joypad right\n"
a_button:
	.asciz	"\nUser pressed A\n"
x_button:
	.asciz	"\nUser pressed X\n"
lefttrigger_button:
	.asciz	"\nUser pressed left trigger\n"
righttrigger_button:
	.asciz	"\nUser pressed right trigger\n"
multi_buttons:
	.asciz "\nUser pressed multiple buttons\n"
