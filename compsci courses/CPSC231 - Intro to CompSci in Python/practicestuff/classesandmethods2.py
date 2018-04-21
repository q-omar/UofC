#
# Author:  James Tam
# Version: November 14, 2014
#
# Learning concepts:
# * Defining and calling class methods that access attributes


class Car: #object car
    make = "" #attribute make
    model = "" #attribute  model

    def __init__(self,aMake,aModel): #constructor method
        self.make = aMake
        self.model = aModel

    def displayInfo(self): #method
        print("Make: %s, Model: %s" %(self.make,self.model))

def start():
    aCar = Car("Acura","NSX")
    aCar.displayInfo() #calling displayinfo from aCar class

start()
