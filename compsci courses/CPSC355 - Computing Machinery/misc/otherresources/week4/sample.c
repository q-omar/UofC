#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 50

//fills an array with the current index. Also computes a running total
int main(){
	int array[SIZE];
	long int runningTotal = 0;
	for ( int i= 0 ; i < SIZE ; i++){
		array[i] = i;
		runningTotal += i;
		printf("array[%d]=%d  runningTotal=%ld\n", i, array[i], runningTotal);
	}

	return 0;
}