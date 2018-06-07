#
# Author:  James Tam
# Version: November 14, 2014
#
# Learning concepts:
# * Class definition in a separate module file


class Car: #object called car
    make = ""
    model = ""

    def __init__(self,aMake,aModel):
        self.make = aMake
        self.model = aModel

    def displayInfo(self): #attribute or method? 
        print("Make: %s, Model: %s" %(self.make,self.model))
