#def doubleIt(num):
#    num=num*2
#    return num

#def start():
#    num = int(input("Enter a number and I'll double it in returns: "))
#    num = doubleIt(num)
#    print(num)

#start()

# Author:  James Tam
# Version: Oct 19, 2016
def isZero(num):
    if (num == 0):
        return(True)
    else:
        return(False)

# Students write this function that uses isZero
def divide(numerator,denominator):
    if (isZero(denominator)): #here we are using a booleon function to return a true/false output
                            #that output can then be directly used in an if statement i.e
                            #if (True): block 
        result = "error"
    else:
        result = numerator/denominator

    return(result)

def start():
    num = divide(2,3)
    print(num)
    num = divide(2,0)
    print(num)

start()
