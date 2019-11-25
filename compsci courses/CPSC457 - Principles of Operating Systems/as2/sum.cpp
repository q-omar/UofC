/**********************************************
 * Last Name:   Qureshi
 * First Name:  Safian
 * Student ID:  10086638
 * Course:      CPSC 457
 * Tutorial:    T02
 * Assignment:  2
 * Question:    Q5
 *
 * File name: sum.cpp
 *********************************************/

//Instructions for compilation: g++ sum.cpp -lpthread, ./a.out <input.txt> <int num threads>

#include <unistd.h>
#include <string>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <vector>
#include <fstream>
#include <cmath>
#include <thread>
#include <pthread.h>

using namespace std;

vector<int> threadNum;
vector<int> numbers;
int numLines;
int threadCount;
int currNum;

void* choose(void* i){ //assigning threads to number of groupings 
	//resource used: https://www.geeksforgeeks.org/sum-array-using-pthreads/
	int n = *(int *)i;
	int count = 0;
	int length = 0;

	if ((threadCount - 1) <= n) 
        length = numbers.size()- n *currNum;
    else 
        length = currNum;

  	int m = n*currNum;
  	while (m < (n*currNum+length))
    {
      count = count + numbers[m];
      m++;
    } 

  	threadNum[n] = count;
	printf("Thread %i: %li\n", n, (long)threadNum[n]);
  	return 0;
}

int main (int argc, char** argv)
{
	if (argc != 3)
    { //checks if there are three command line arguments, if not error
		cout << "Ensure three parameters when executing. Form should be './sum <filename> <number_of_threads>'" << endl;
    	exit(-1);
    } 

	threadCount = stoi(argv[2]);
  	ifstream in(argv[1]);
  	std::string unused;
  	while ( std::getline(in, unused) ) //count number of lines to compare with thread number
   		++numLines;

  	if (threadCount > numLines)
    { //if number of lines is less than the thread number inputted, error
    	perror("Thread number greater than number of lines in file");
    	exit(1);
  	}

	ifstream file;
	file.open(argv[1]); //check if file exists
	if(file.is_open() == false){
		perror("Error opening file.");
		exit(-1);
	} 

	char buffer[1000000]; //create character array based on max size
	while(file.getline(buffer, 1000000))
    {
		numbers.push_back(stoi(buffer)); //push value back to our array
	}
	file.close();    

    threadNum = vector<int>(threadCount);
  	pthread_t threads[threadCount];
	currNum = round(numbers.size()/threadCount);

	int s;
  	for(int i = 0; i < threadCount; i++)
    { 
		if(pthread_create(&threads[i], NULL, choose, (void *)(new int(i))) != 0)
        {
			cout << "Error: Invalid thread creation." << endl;
            exit(-1);
		}

    	pthread_join(threads[i], NULL);
		s = s + threadNum[i];
  	}
      
  	printf("Sum = %ld\n", (long)s);
  	return 0;
}

