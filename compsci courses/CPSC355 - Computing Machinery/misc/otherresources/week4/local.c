#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//generates a random number between -8 and 7 inclusive
int main(){
	int min = 0;
	int range = 0;
	int rand_num = 0;
	
	min = -8;										//the starting minimum.
	range = 0xF;									//the range starting from minimum, in this case 2^4 makes [-8,8]
	
	srand(clock());									//set the seed for the random number generator
	rand_num = rand();								//generate a random number
	
	
	//get the random number into a range we like
	rand_num = rand_num & range;
	rand_num = rand_num + min;
	
	printf("Hello world! Your lucky number today is: %d\n", rand_num);
	
	return 0;
}