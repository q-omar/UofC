#Safian Omar Qureshi
#ID 10086638
#TA: Mojtaba Komeili
#T03
#v1.60 (last modified 4:39pm, June 26, 2017)

#This file in conjunction with Target.py and Pursuer.py creates objects that interact with eachother.
#The Target object generates a user entered probability of a true/false event. The pursuer also
#generates a true false event that is initially set to 50/50. After each interaction, the Pursuer
#modifies its probability to create better matching results. A final statistic report is then displayed.

#Limitations: the ctrl+c break out of loop command is handled by the exception and so
#it doesn't break the loop. Can make it a little annoying to debug if needed to check the functions.

#I also had trouble getting a globals.py named constant file that could be read across all files. It would 
#convenient to have a seperate named constants file that but I tried that and didn't work. So I copy pasted
#my named constants at the top for all files. 


from Target import *
from Pursuer import *
LOWER_BOUND_RANDOM=0 #i tried to create a globals.py files with all the named constants
UPPER_BOUND_RANDOM=100#so that all files can use it simultanesouly but couldnt
COUNT_STEP=1#get it to work for some reason so i just repeated the starting constants
STARTING_COUNTER=0 #for each file 

def interactionsChecker(): #this function checks user input by recursion
    try:
        interactions=int(input("Enter amount of dates (1 or more): "))
        if interactions<1:
            print("Number must be greater than 0, try again!")
            interactions=interactionsChecker()
    except:
        print("Non numerical input - Try again!")
        interactions=interactionsChecker()
    return(interactions)


def probabilityChecker():#this function checks user input by recursion
    aTarget=Target()
    try:
        aTarget.xIntProb=int(input("Enter the probability of x (0 - 100): "))
        if aTarget.xIntProb<LOWER_BOUND_RANDOM or aTarget.xIntProb>UPPER_BOUND_RANDOM:
            print("Number must be between 0 - 100, try again!")
            aTarget.xIntProb=probabilityChecker()
    except:
        print("Non numerical input - Try again!")
        aTarget.xIntProb=probabilityChecker()
    return(aTarget.xIntProb)


def start():
    aTarget=Target() #initializes both objects
    aPursuer=Pursuer() 

    interactions=interactionsChecker() #calling these two functions to check user is stupid 
    aTarget.xIntProb=probabilityChecker()

    interactionsCount = STARTING_COUNTER
    numTotMatches=STARTING_COUNTER

    while (interactionsCount<interactions): #runs while interactions are all complete

        targXBhvr=aTarget.behaviorGeneration() #generates Target behavior, returns it is variable to pass
        xCount,yCount=aTarget.tallyTarget() #tallies results each loop, returns it as variable to pass

        aPursuer.behaviorGeneration() #generates Pursuer behavior
        aPursuer.tallyPursuer() #tally results each loop
        aPursuer.tallySuccessful(targXBhvr) #checks each interaction, tallies successful ones 
        aPursuer.probabilityShift() #calls shifting probability function from Pursuer to adjust x based on successful interactions

        interactionsCount=interactionsCount+1 #update loop control

    aPursuer.displayEnd(interactions,xCount,yCount) #finalresults after loop done
start()
