from Adventurer import *

def start():
    aAdventurer = Adventurer("","")
    print("Adventurer name is: %s" %(aAdventurer.name))
    print("Adventurer health is: %d" %(aAdventurer.health))
    
    aAdventurer.name="Balin"
    aAdventurer.gainLevel()
    print("Adventurer name is: %s" %(aAdventurer.name))
    print("Adventurer health is: %d" %(aAdventurer.health))

start()