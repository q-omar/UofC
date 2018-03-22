#Safian Omar Qureshi
#ID 10086638
#TA: Mojtaba Komeili
#T03
#v1.55 (last modified 4:39pm, June 25, 2017)

#This file is an object that outputs true/false results to the manager, based on the probability user defines.


import random
LOWER_BOUND_RANDOM=0 #i tried to create a Globals.py file with all the named constants
UPPER_BOUND_RANDOM=100#so that all files can use it simultanesouly but couldnt
COUNT_STEP=1#get it to work for some reason so i just repeated the starting constants
STARTING_COUNTER=0 #for each file 

class Target:  #define target class

    xCount=""
    yCount=""
    xIntProb="" #i didn't bother with putting a y probability since x indirectly defines the y probability
    xGenerated=""
    yGenerated=""


    def __init__(self):
        self.xCount=STARTING_COUNTER #initialization attributes
        self.yCount=STARTING_COUNTER
        self.xIntProb=""
        self.xGenerated=""
        self.yGenerated=""


    def behaviorGeneration(self): #algorithm for generating true/false events
        randomizer = random.randint(LOWER_BOUND_RANDOM,UPPER_BOUND_RANDOM) - 1#generating a random number from 0 to 100 produces 101 numbers, so we subtract 1 

        if randomizer < self.xIntProb: #this x probablity is inputted by user in manager
            self.xGenerated = True
            self.yGenerated = False
        else:
            self.xGenerated = False
            self.yGenerated = True

        return(self.xGenerated) #returns to caller in manager 


    def tallyTarget(self): #tallies x and y events total
        if self.xGenerated==True:
            self.xCount=self.xCount+COUNT_STEP
        else:
            self.yCount=self.yCount+COUNT_STEP

        return(self.xCount,self.yCount)
