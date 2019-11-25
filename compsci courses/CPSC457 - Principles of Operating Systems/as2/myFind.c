/**********************************************
#  * Last Name:   Qureshi
#  * First Name:  Omar
#  * Student ID:  10086638
#  * Course:      CPSC 457
#  * Tutorial:    T04
#  * Assignment:  2
#  * Question:    Q2
#  *
#  * File name: scan.sh
#  *********************************************/
//Resource used: https://pages.cpsc.ucalgary.ca/~sina.keshvadi1/os/execl.pdf
#include <stdio.h>
#include <dirent.h>
#include <string.h>

/*
The following function is called by main, and then recursively explores directories and
subdirectories to list files with their paths to standard output
*/
void visitDir(const char *path, int depth)
{
    DIR *directory = opendir(path);
    struct dirent* element = NULL;

    if(!directory) {return;}
    while((element = readdir(directory)))
    {        
        if(element->d_type == DT_DIR)
        {
            if (strcmp(element->d_name, ".") && strcmp(element->d_name, ".."))
            {
                char buffer[1000];
                sprintf(buffer, "%s/%s", path, element->d_name);
                visitDir(buffer, depth+1);
            }
        }
        else
        {   
            printf("%s/", path);
            printf("%s\n", element->d_name);
        }
    }
    closedir(directory);
}

/*
Calls visitDir function with the current directory "."
*/
int main(int argc, char **argv)
{
    visitDir(".", 0);
    return 0;
}