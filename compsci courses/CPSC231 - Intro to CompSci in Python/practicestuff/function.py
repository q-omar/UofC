# Author:  James Tam
# Version: Oct 2016

def start():
    name = input("Enter your name: ") #this line executes next
    displayName(name)#the second function is called within a function and it copies the variable name to that function
                    #the second function is still within the block of the first and so is allowed to get passed the name variable


def displayName(name):
    print(name)

start() #thisline executes first
