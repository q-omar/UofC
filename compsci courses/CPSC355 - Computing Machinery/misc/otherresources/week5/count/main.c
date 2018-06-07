#include <stdio.h>
#include <stdlib.h>

//an example program to link with a assembly file. Link and compile with count.s.
//Linking is done easier in a make file


/* Function prototypes */
void addCount(int x);
int getCurrentCount();


int main(){
	
	int input = -1;
	
	do{
		printf("Enter a number:\n");
		scanf("%d", &input);
		
		if (input != -1){
			addCount(input);
			printf("Count: %d\n", getCurrentCount());
		}
		else{
			return 0;			//finish the program and exit
		}
		
	} while (1);					//run forever, to forcefully exit, press ctrl-C
	
	
	
	return 0;
}

