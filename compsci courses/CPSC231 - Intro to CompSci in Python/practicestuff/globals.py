# Author:  James Tam
# Version:  Oct 19, 2016

x = 1
y = 2

# Local overrides global scope
def fun1():
    x = 10
    y = 20
    print(x,y)

# Provides write access to one global
def fun2():
    global x   #this calls in the global x which is currently 1. This global variable is the one that gets modified now in the function
    x = 100 #this modifies the GLOBAL x, global x is now 100
    print(x,y)

# Proof: parameters are just a type of local
def fun3(num1,num2):
    num1 = 1000
    num2 = 2000
    print(x,y,num1,num2)

# No locals, access global memory space
def start():
    print(x,y) #1,2
    fun1() #10,20
    fun2() #100,2
    print(x,y) #100,2
    fun3(x,y) #100,2,1000,2000
    print(x,y) #100,2

start()
