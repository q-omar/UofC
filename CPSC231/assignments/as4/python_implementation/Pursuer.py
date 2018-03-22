#Safian Omar Qureshi
#ID 10086638
#TA: Mojtaba Komeili
#T03
#v1.55 (last modified 4:39pm, June 25, 2017)

#This file is a Pursuer object that generates true/false events based, initially 50/50. It then
#takes the generated events from the Target class to adjust its own probability to improve
#success rate. Final statistics are displayed by the Pursuer class.

import random
LOWER_BOUND_RANDOM=0 #i tried to create a globals.py files with all the named constants
UPPER_BOUND_RANDOM=100#so that all files can use it simultanesouly but couldnt
COUNT_STEP=1#get it to work for some reason so i just repeated the starting constants
STARTING_COUNTER=0 #for each file 

class Pursuer:

    p_xCount=""
    p_yCount=""
    p_xIntProb="" #i didnt bother creating a y probability since x probability indirectly takes care of it
    p_xGenerated=""
    p_yGenerated=""
    xxMatch=""
    xyMismatch=""
    yxMismatch=""
    yyMatch=""
    totalSuccessMatches=""


    def __init__(self):
        self.p_xCount=STARTING_COUNTER #initializes object with starting values
        self.p_yCount=STARTING_COUNTER
        self.p_xIntProb=50
        self.p_xGenerated=""
        self.p_yGenerated=""
        self.xxMatch=STARTING_COUNTER
        self.xyMismatch=STARTING_COUNTER
        self.yxMismatch=STARTING_COUNTER
        self.yyMatch=STARTING_COUNTER
        self.totalSuccessMatches=STARTING_COUNTER
        

    def behaviorGeneration(self):
        randomizer = random.randint(LOWER_BOUND_RANDOM,UPPER_BOUND_RANDOM) - 1 #generating a random number from 0 to 100 produces 101 numbers, so we subtract 1 

        if randomizer < self.p_xIntProb: #similar to Target object, generates true/false events based
            self.p_xGenerated = True #on an x probability, initially 50, adapting after
            self.p_yGenerated = False
        else:
            self.p_xGenerated = False
            self.p_yGenerated = True


    def tallyPursuer(self): #tallying x,y event counts of Pursuer
        if self.p_xGenerated==True:
            self.p_xCount=self.p_xCount+COUNT_STEP
        if self.p_yGenerated==True:
            self.p_yCount=self.p_yCount+COUNT_STEP


    def tallySuccessful(self,targXBhvr): #each interaction is displayed, taking the target behavior as a parameter to check matches
                                         #tallies successful matches and mismatches to feed into probability shift method
        if targXBhvr==True and self.p_xGenerated==True:
            print("James behavior: x       Moji behavior: x        MATCH")
            self.xxMatch=self.xxMatch+1#if there is a x-x match, it increases its x probability in following method
            self.totalSuccessMatches=self.totalSuccessMatches+1
        
        elif targXBhvr==True and self.p_xGenerated==False:
            print("James behavior: x       Moji behavior: y        MISMATCH")
            self.xyMismatch=self.xyMismatch+1#if there is an x-y mismatch, increases its x probability in following method
        
        elif targXBhvr==False and self.p_xGenerated==True:
            print("James behavior: y       Moji behavior: x        MISMATCH")
            self.yxMismatch=self.yxMismatch+1#if there is a y-x mismatch, decreates x probability in following method
        
        elif targXBhvr==False and self.p_xGenerated==False:
            print("James behavior: y       Moji behavior: y        MATCH")
            self.yyMatch=self.yyMatch+1#if there is a y-y match, decreases x probability in following method
            self.totalSuccessMatches=self.totalSuccessMatches+1

    def probabilityShift(self): #algorithm for changing Pursuers x probability

            if self.xxMatch + self.xyMismatch > self.yyMatch + self.yxMismatch:
                self.p_xIntProb=self.p_xIntProb+10 #if there is a x-x match, x-y mismatch, it increases its x probability
            else:
                self.p_xIntProb=self.p_xIntProb-10 #if there is a y-y match, y-x mismatch, it decreases its x probability


    def displayEnd(self,interactions,xCount,yCount): #tallies all final results
        print("")
        print("Final Analysis\n==============")
        print("James Tam total x count:",xCount, "|   total y count: ",yCount)
        print("Moji total x count:",self.p_xCount, "|   total y count: ",self.p_yCount)
        self.successRate=self.totalSuccessMatches/interactions
        self.successRate=self.successRate*100
        print("Number of successful dates: ",self.totalSuccessMatches)
        print("Success rate:","%.2f"%self.successRate,"%")
        if self.successRate>50:
            print("Moji successfully dated James! ;)")
        else:
            print("Moji failed his dates and got rejected...:C")