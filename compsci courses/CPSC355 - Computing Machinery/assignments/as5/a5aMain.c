//CPSC 355
//Safian Omar Qureshi
//ID 10086638
//Assignment 5

//The following C code is written and all methods except main() are to be translated into
//ARM assembly code which is provided in an accompanying file. 


#include <stdio.h>
#include <stdlib.h>

#define STACKSIZE   5
#define FALSE       0
#define TRUE        1

/* Function Prototypes */
void push(int value);
int pop();
int stackFull();
int stackEmpty();
void display();

/* Global Variables */
int stack[STACKSIZE];
int top = -1;

int main()
{
    int operation, value;

    do {
        system("clear");
        printf("### Stack Operations ###\n\n");
        printf("Press 1 - Push, 2 - Pop, 3 - Display, 4 - Exit\n");
        printf("Your option? ");
        scanf("%d", &operation);
        switch (operation) {
            case 1:
                printf("\nEnter the positive integer value to be pushed: ");
                scanf("%d", &value);
                push(value);
                break;
            case 2:
                value = pop();
                if (value != -1)
                    printf("\nPopped value is %d\n", value);
                break;
            case 3:
                display();
                break;
            case 4:
                printf("\nTerminating program\n");
                exit(0);
            default:
                printf("\nInvalid option! Try again.\n");
                break;
        }
        printf("\nPress the return key to continue . . . ");
        getchar();
        getchar();
    } while (operation != 4);

    return 0;
}

//The code below is commented since an equivalent assembly code will be used. 

/*

void push(int value)
{
    if (stackFull())
        printf("\nStack overflow! Cannot push value onto stack.\n");
    else {
        stack[++top] = value;
    }
}

int pop()
{
    register int value;

    if (stackEmpty()) {
        printf("\nStack underflow! Cannot pop an empty stack.\n");
        return (-1);
    } else {
        value = stack[top];
        top--;
        return value;
    }
}

int stackFull()
{
    if (top == STACKSIZE - 1)
        return TRUE;
    else
        return FALSE;
}

int stackEmpty()
{
    if (top == -1)
        return TRUE;
    else
        return FALSE;
}

void display()
{
    register int i;

    if (stackEmpty())
        printf("\nEmpty stack\n");
    else {
        printf("\nCurrent stack contents:\n");
        for (i = top; i >= 0; i--) {
            printf("  %d", stack[i]);
            if (i == top) {
                printf(" <-- top of stack");
            }
            printf("\n");
        }
    }
}

*/