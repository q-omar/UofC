#include <stdio.h>
#include <stdlib.h>

int result = 1;
long int factorialSum = 0;


/*The actual functions from factmain.c */
int factorial(int x){
	for (int i = 1 ; i <= x ; i++){
		result = result * i;
		factorialSum = factorialSum + result;
	}
	
	return result;
}


long int getFactorialSum(){
	return factorialSum;
}
