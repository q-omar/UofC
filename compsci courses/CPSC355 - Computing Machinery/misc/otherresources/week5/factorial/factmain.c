#include <stdio.h>
#include <stdlib.h>

/*Function Prototypes */
int factorial(int x);
long int getFactorialSum();

int main(){
	
	int input = 0;
	
	printf("Enter a number 1-12\n");
	scanf("%d", &input);
	
	if (input >= 1 && input <=12){
		printf("Factorial=%d\n", factorial(input));
		printf("FactorialSum=%d\n", getFactorialSum());
	}
	else{
		printf("Invalid input\n");
	}
	
	
	return 0;
}