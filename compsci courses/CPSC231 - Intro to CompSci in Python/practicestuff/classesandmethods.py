#
# Author:  James Tam
# Version: November 14, 2014
#
# Learning concepts:
# * Defining a new class
# * Instantiating objects
# * Accessing attributes


class Car:
    make = ""
    model = ""

    def __init__(self,aMake,aModel): #method constructor
        self.make = aMake
        self.model = aModel

def start():
    aCar = Car("Dodge","Viper") #calling the initializing function inside class car 
    print("Tam's Muscle car %s, %s" %(aCar.make,aCar.model))

start()
