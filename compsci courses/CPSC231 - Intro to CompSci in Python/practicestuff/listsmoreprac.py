import random

MAX = 4

x = [1,2,3]

# Author:  James Tam
# Version: November 13, 2013

# Learning concepts:
# Passing a list (actually a reference to a list) as a parameter

# Changes to the list passed back to called.
# JT: actually the return is useless. The address of list is
# passed in as a parameter and stored in a local reference.
# All that is returned is the same address!
def fun1(listReference):
    for i in range (0,MAX,1):
        listReference[i] = listReference[i] * 2
    return(listReference)

# No return needed because the address of the list is passed
# into fun2()
def fun2(listReference):
    for i in range (0,MAX,1):
        listReference[i] = listReference[i] * 2

# A common mistake when working with references or pointers.
# The local reference now contains the address of a new list.
def fun3(listReference):
    listReference = []
    for i in range (0,MAX,1):
        listReference.append(-1)
    print("Local list in fun3", listReference)

# A tougher trace. Pass address of a global list (twice) into
# two local references.
# 1) First reference: reassigned to point to a new list
# 2) Second reference: still contains the address of the global
# list so changes made to the list are still retained after the
# function ends even without the 'global <global variable name>'
# expression.
def fun4(a,b):
    a = [8,8,8] #a new local list is created called a
    b[0] = 3 #the elements of the global list x are changing because x is actually parameter passed in line 66
    b[1] = 2
    b[2] = 1
    print("Local list", a,"\tGlobal list modified in fun4()", b)

def initialize():
    listReference = []
    for i in range (0,MAX,1):
        listReference.append(random.randrange(1,11))
    return(listReference)

def start():
    listReference = initialize()
    print("Original data", listReference)
    listReference = fun1(listReference)
    print("Doubled in fun1()", listReference)
    fun2(listReference)
    print("Doubled again in fun2()", listReference)
    fun3(listReference)
    print("Not modified after fun3()", listReference)
    print("Global list", x)
    fun4(x,x)
    print("Global list after fun4", x)

start()
