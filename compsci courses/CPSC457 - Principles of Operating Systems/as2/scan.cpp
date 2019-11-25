/**********************************************
#  * Last Name:   Qureshi
#  * First Name:  Omar
#  * Student ID:  10086638
#  * Course:      CPSC 457
#  * Tutorial:    T04
#  * Assignment:  2
#  * Question:    Q3
#  *
#  * File name: scan.sh
#  *********************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <iostream>
using namespace std;

#define MAX_LENGTH 512
#define MAX_FILE_NUM 1000

struct file
{//structure for file name and size
    char fname[MAX_LENGTH];
    int size;
};

//Reference: sort funciton :http://www.cplusplus.com/reference/cstdlib/qsort/
int compare(const void *a, const void *b) 
{
    struct file *left = (struct file*) a;
    struct file *right = (struct file*) b;
    if(left->size > right->size) return -1;
    return 1;
}


int main(int argc, char** argv) {
    // handle command line arguments
    if( argc != 3) 
    {
        fprintf(stderr, "I take 3 command line arguments.\n");
        exit(-1);
    }

    char fsuffix[MAX_LENGTH];
    int cut = atoi(argv[2]);

    //open 'find...' from q2
    FILE* fp = popen("./myFind", "r");
    if( fp == NULL) 
    {
        perror("popen failed:");
        exit(-1);
    }
    //read in filenames and filter based on command line argument
    char buffer[MAX_LENGTH];
    char* files[MAX_FILE_NUM];
    char extension[MAX_LENGTH-1]; //for edgecases if extension name is 511 characters
    int fileCount = 0;

    while(fgets(buffer,MAX_LENGTH,fp)) 
    {
      for(int i=0; i<strlen(argv[1]);i++)
        extension[i]=buffer[strlen(buffer)-1-strlen(argv[1])+i]; //build extension based on length of commadline argument
      
      int elen=strlen(extension)-1;
      if(extension[elen]=='\n') //check for new line and if so, go back
          extension[elen]='\r';
      
      if (strcmp(argv[1], extension)==0) //if extension matches, put into new array
      {
          int len = strlen(buffer);
          files[fileCount] = strndup(buffer,len-1);
          fileCount ++;
      }
    }
    fclose(fp);


    //get file name and sizes 
    struct stat st;
    struct file fileArray[MAX_FILE_NUM];
    long long totalSize = 0;

    int j = 0;
    while(j<fileCount)
    {
        if(stat(files[j],&st) != 0) 
        {
            perror("stat failed:");
            exit(-1);
        }

        struct file newFile;
        strcpy(newFile.fname, files[j]);
        newFile.size = st.st_size;
        fileArray[j] = newFile;
        j++;
    }
    //sort file array by size
    qsort(fileArray, fileCount, sizeof(struct file), compare);

    //only print top files above the cut defined by command argument
    if(cut > fileCount)
        cut = fileCount;

    int i = 0;
    while(i<cut)
    {
        printf("%s %i\n", fileArray[i].fname, fileArray[i].size);
        totalSize +=fileArray[i].size;
        i++;
    }

    printf("Total size: %lld \n", totalSize);

    for(int i = 0; i < fileCount ; i ++ ) 
    {
        free(files[i]);
    }
    // return success
    return 0;
}