/**********************************************
 * Last Name:   Qureshi
 * First Name:  Omar
 * Student ID:  10086638
 * Course:      CPSC 457
 * Tutorial:    T02
 * Assignment:  4
 * Question:    Q4
 *
 * File name: scheduler.cpp
 *********************************************/

#include <fcntl.h>
#include <stdint.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <iostream>
#include <fstream>
#include <queue>
#include <sys/stat.h>
#include <map>
#include <cstring>
#include <cstdio>


int executingProcess = -1; //process starts running
int numProcess;
int totalBurstTime;
int stateCount;
float waitTC[30];
int pTable[30][2];
char state[30];


/**
 * takes input as character array, builds a corresponding process table using ints
 **/
int read(int * pTable, char * array) 
{
    std::fstream reading;
    reading.open(array);
    int index;
    int next;

    while (reading >> next) 
    {
        *(pTable + index) = next; //read in next value into process array
        index++;
        printf("%d", index);
        if (index % 2 == 0)
        {
            totalBurstTime+=next;
            numProcess++; //get number of processes
        }
    }
    reading.close();
    return numProcess;
}


/**
 * reads the character acoordingly from . to # and updates burst time or increments wait
 **/ 
void updateStatus(int i) 
{
    if (state[i] == '.') {// depending on which state, we record and add to burst times
        waitTC[i]++;
    } else if (state[i] == '#') {totalBurstTime--;}
}


/**
 * checks if command line arguments are valid
 **/
bool isInputValid(int argc, char** argv) 
{ 
    if (argc != 4 && argc != 3) 
    {
        printf("Invalid # arguments, use: ./scheduler <input.txt> <type (RR or SJF)> <int (if using RR>");
        return false;
    } else if ((strcmp(argv[2], "RR") != 0) && (strcmp(argv[2], "SJF") != 0)) 
    {
        printf("The second command line argument should be either 'RR' or 'SJF'");
        return false;
    } else if (strcmp(argv[2], "SJF") == 0 && argc == 4) 
    {
        printf("SJF doesn't take quantum input.");
        return false;
    } else if (strcmp(argv[2], "RR") == 0 && argc == 3) 
    {
        printf("RR requires quantum input.");
        return false;
    } else {return true;}
}


/**
 * Helper to remove redundant lines for updating character
 **/
int updateQueue(int tempTime, float RRTime, std::queue <float> &readyQueue)
{
  executingProcess = readyQueue.front();
  readyQueue.pop();
  tempTime = RRTime;
  pTable[executingProcess][1]--;
  state[executingProcess] = '#';
  tempTime--;
  return tempTime;
}


/**
 * algorithm for roundRobin scheduling https://www.geeksforgeeks.org/program-round-robin-scheduling-set-1/
 **/
void roundRobin(int argc, char** argv) 
{ 
    for (int i = 0; i < 30; i++){state[i] = ' ';}
    std::queue < float > readyQueue;
    float RRTime = std::stof(argv[3]); 
    int tempTime = RRTime; 
    numProcess = read((int * ) pTable, argv[1]); 
    printf("Time");
    int c = 0;
    while (c < numProcess) 
    {
        printf("\tP%d", c);
        c++;
    }
    printf("\n------------------------------------------------------------\n");
    
    for (int i = 0; totalBurstTime > 0; i++) 
    { 
        while (stateCount < numProcess) 
        {
            if (pTable[stateCount][0] == i) 
            { 
                readyQueue.push(stateCount);
                state[stateCount] = '.';
            }
            if (pTable[stateCount][0] > i) {break;}
            stateCount++;
        }

        if (executingProcess == -1) 
        {
            if (readyQueue.size() == 0) 
            {
                printf("%d", i);
                int j = 0;
                while (j < numProcess) 
                {
                    updateStatus(j);
                    printf("\t%c", state[j]);
                    j++;
                }

            printf("\n");
            } else {tempTime = updateQueue(tempTime, RRTime, readyQueue);}
        } else 
        {
            if (tempTime == 0) 
            {
                if (pTable[executingProcess][1] == 0) 
                {
                    state[executingProcess] = ' ';
                    executingProcess = -1;
                    if (readyQueue.size() == 0) 
                    { 
                        printf("%d", i);
                        int j = 0;
                        while (j < numProcess) 
                        {
                            updateStatus(j);
                            printf("\t%c", state[j]);
                            j++;
                        }

                    printf("\n");
                    } else {tempTime = updateQueue(tempTime, RRTime, readyQueue);}
                } else 
                {
                    state[executingProcess] = '.';
                    readyQueue.push(executingProcess);
                    tempTime = updateQueue(tempTime, RRTime, readyQueue);
                }
            } else 
            {
                if (pTable[executingProcess][1] == 0) 
                {
                    state[executingProcess] = ' ';
                    executingProcess = -1;
                    if (readyQueue.size() == 0) 
                    { 
                        printf("%d", i);
                        int j = 0;
                        while (j < numProcess) 
                        {
                            updateStatus(j);
                            printf("\t%c", state[j]);
                            j++;
                        }

                    printf("\n");
                    } else {tempTime = updateQueue(tempTime, RRTime, readyQueue);}
                } else 
                {
                    pTable[executingProcess][1]--;
                    tempTime--;
                }
            }
        }
        printf("%d", i);
        int j = 0;
        while (j < numProcess) 
        {
            updateStatus(j);
            printf("\t%c", state[j]);
            j++;
        }
        printf("\n");
    }
    
    printf("------------------------------------------------------------\n");
    int i = 0;
    while (i < numProcess) 
    {
        printf("P%d waited %.03f sec.\n", i, waitTC[i]);
        i++;
    }

    i = 0;
    int total = 0;
    while (i < numProcess) 
    {
        total = total + waitTC[i];
        i++;
    }
    double average = ((double) total / numProcess);
    printf("Average waiting time = %.3f sec.\n", average);
}


/**
 * algorithm for shortest job first: https://www.geeksforgeeks.org/program-shortest-job-first-sjf-scheduling-set-1-non-preemptive/
 **/
void shortestJobFirst(int argc, char** argv) 
{ 
    for (int i = 0; i < 30; i++){state[i] = ' ';}
    numProcess = read((int * ) pTable, argv[1]); 
    printf("Number of processes: %d, Total burst time: %ds\n", numProcess, totalBurstTime);
    printf("Time");
    int c = 0;
    while (c < numProcess) 
    {
        printf("\tP%d", c);
        c++;
    }
    printf("\n------------------------------------------------------------\n");

    for (int i = 0; totalBurstTime > 0; i++) 
    {
        while (stateCount < numProcess) 
        {
            if (pTable[stateCount][0] == i) { 
                state[stateCount] = '.';
            } else if (pTable[stateCount][0] > i) {
                break;
            }
            stateCount++;
        }
        if (executingProcess == -1) 
        {
            int min = -1;
            for (int i = 0; i < stateCount; i++) 
            {
                if (min == -1 && state[i] == '.') {min = i; } 
                else if (pTable[i][1] < pTable[min][1] && state[i] == '.') {min = i; }
            }
            if (min != -1) 
            { 
                executingProcess = min; 
                state[executingProcess] = '#';
                pTable[executingProcess][1]--;
            }
        } else if (pTable[executingProcess][1] == 0) 
        { 
            state[executingProcess] = ' ';
            executingProcess = -1;
            int min = -1;
            for (int i = 0; i < stateCount; i++) 
            {
                if (min == -1 && state[i] == '.') {min = i;} 
                else if (pTable[i][1] < pTable[min][1] && state[i] == '.') {min = i;}
            }

            if (min != -1) 
            {
                executingProcess = min;
                state[executingProcess] = '#';
                pTable[executingProcess][1]--;
            }
        } else {pTable[executingProcess][1]--;}

        printf("%d", i);
        int j = 0;
        while (j < numProcess) 
        {
            updateStatus(j);
            printf("\t%c", state[j]);
            j++;
        }
        printf("\n");
    }
    
    printf("------------------------------------------------------------\n");
    int i = 0;
    while (i < numProcess) 
    {
        printf("P%d waited %.03f s.\n", i, waitTC[i]);
        i++;
    }

    i = 0;
    int total = 0;
    while (i < numProcess) 
    {
        total = total + waitTC[i];
        i++;
    }
    double average = ((double) total / numProcess);
    printf("Average waiting time = %.3fs.\n", average);
}


/**
 * driver
 **/
int main(int argc, char** argv) 
{
    if (isInputValid(argc, argv)) 
    {
        if (strcmp(argv[2], "RR") == 0) {roundRobin(argc, argv);} 
        else {shortestJobFirst(argc, argv);}

    } else {exit(-1);}
    return 0;
}