/**********************************************
 * Last Name:   Qureshi
 * First Name:  Safian
 * Student ID:  10086638
 * Course:      CPSC 457
 * Tutorial:    T02
 * Assignment:  3
 * Question:    Q2
 *
 * File name: count.cpp
 *********************************************/

/// counts number of primes from standard input
///
/// compile with:
///   $ g++ count.cpp -O2 -o count -lm
///
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <thread>
#include <mutex>
#include <pthread.h>
#include <vector>

std::mutex myMutex;
int64_t count = 0;
std::vector<int64_t> numbers;
std::vector<int64_t> threadNumbers;


/// primality test, if n is prime, return 1, else return 0
void isPrime(int id, int nThreads)
{   //https://stackoverflow.com/questions/33251330/c-multithreaded-prime-counter-between-specified-range
    int i = (threadNumbers[id] - ((int) ceil(((float)(numbers.size()))/((float)(nThreads)))));
    for(;i < threadNumbers[id]; i++)
    {
        int64_t n = numbers[i];
        if( n <= 1) { continue;} // small numbers are not primes
        if( n <= 3) 
        {
            myMutex.lock();
            count++;
            myMutex.unlock();
            
            continue; // 2 and 3 are prime
        }
        if( n % 2 == 0 || n % 3 == 0) {continue;} // multiples of 2 and 3 are not primes
        int64_t i = 5;
        int64_t max = sqrt(n);
        while( i <= max) {
            if (n % i == 0 || n % (i+2) == 0) { goto end;}
            i += 6;
        }
        myMutex.lock();
        count++;
        myMutex.unlock();

        end:;
    }
}


int main( int argc, char ** argv)
{
    /// parse command line arguments
    int nThreads = 1;

    if( argc != 1 && argc != 2) {
        printf("Uasge: countPrimes [nThreads]\n");
        exit(-1);
    }

    if( argc == 2) nThreads = atoi( argv[1]);

    /// handle invalid arguments
    if( nThreads < 1 || nThreads > 256) {
        printf("Bad arguments. 1 <= nThreads <= 256!\n");
    }
    /// count the primes
    printf("Counting primes using %d thread%s.\n", nThreads, nThreads == 1 ? "s" : "");
    
    while( 1) 
    {
        int64_t num;
        if( 1 != scanf("%lld", & num)) break;
        numbers.push_back(num);
    }

    if (nThreads >= numbers.size()) nThreads = numbers.size(); //if the number of threads is greater, equate to the size of vector
    std::vector<std::thread> t;

    for (int i = 0; i < nThreads; i++)
    {//https://stackoverflow.com/questions/33251330/c-multithreaded-prime-counter-between-specified-range
        if (i == nThreads) threadNumbers.push_back(numbers.size());
        else threadNumbers.push_back(((int)ceil(((float)(numbers.size()))/((float)(nThreads)))) * (i + 1)); 
    }

    for (int id = 0; id < nThreads; id++)
    {
        t.push_back(std::thread(isPrime, id, nThreads));
    }
    for (int id = 0; id < nThreads; id++)
    {
        for (auto &tt: t) {tt.join();}
        t.clear();   
    }
    
    printf("Found %lld primes.\n", count);
    return 0;
}

