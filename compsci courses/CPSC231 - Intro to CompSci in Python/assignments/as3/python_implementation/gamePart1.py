#Safian Omar Qureshi
#ID 10086638
#TA:  Mojtaba Komeili
#T03
#v1.40 (last modified 4:00m, June 2, 2017)

#A text-based game involving three doors written in Python. Upon running the game, the user is transported to a middle
#entrance room. The user has three numerical options which they can input; try the front door which is initally locked
#or enter the kicthen/pantry which are adjacent rooms. If upon entering a non valid numerical, repeatedly prompts user
#for proper numerical input. When entering adjacent rooms, the user has the option for turning two keys. When the right
#key combination is attained in the adjacent doors, the main door in the entrace is unlocked and the user can open it to win the game.

#Limitations: can not handle non numerical character input from stupid user


win=False   #starting the main while loop, checks if game is won or not
cond1=False #conditions for keys, false initially so main entrance door is locked
cond2=False
ind1="center"      #indicators to show current position of key each time in the room
ind2="left"

while (win==False): #main while loop that contains the game, loops while game has not been won
    print("Room: Entrance\n--------------\nYou're in the entrance hallway. The door that brought you in from the outside is gone! In front of you there is a door that leads deeper into the house. To your left is an entranceway into the kitchen. To your right is an entranceway into the pantry.")
    print("")
    print("Room Options:")
    print("1: Try to open the door")
    print("2: Go through the left entryway")
    print("3: Go through the right entryway")
    room = int(input("Your selection (must be 1, 2 or 3): "))  #asks user input to try main door or enter adjacent rooms
    print("")

    while ((room<=0) or (room>3)):
        room = int(input("Invalid selction! Must be 1, 2 or 3: ")) #repeatedly ask for user input if non valid selection, I could have reprinted the entire room description/options here again but didn't think it was necessary

    while (room==1): #room that checks conditions to see if game won or not, updates win variable if appropriate to end game
        if ((cond1==True) and (cond2==True)):
            print("The tumblers click and the door is unlocked!")
            print("")
            win=True
            room=room-1 #loop control updates to exit this 'room'
        else:
            print("You try the door but it remains locked...")
            print("")
            room=room-1

    while (room==2):  #kitchen room with 4 options
        print("Room: Kitchen\n--------------\nYou're in a kitchen with many modern appliances. In front of you is gold lock with 3 positions: left, center and right. Behind you is the doorway to the entranceway.")
        if (ind1=="left"): #branches that print current position of key
            print("The key is currently in the left position")
        elif (ind1=="right"):
            print("The key is currently in the right position")
        elif (ind1=="center"):
            print("The key is currently in the center position")
        print("")
        print("Room Options:")
        print("1: Turn the gold key to the left position")
        print("2: Turn the gold key to the right position")
        print("3: Turn the gold key to the center position")
        print("4: Don't change the position! Return to entranceway")
        selection =int(input("Your selection (must be 1, 2, 3 or 4): ")) #selection variable to execute branches or exit the room
        print("")

        while ((selection<=0) or (selection>=5)): #prompts user repeatedly for valid selection, I could have put the room actions here to print again but didn't feel it was necessary
            selection = int(input("Invalid selction! Must be 1, 2, 3 or 4: "))
        if (selection==1): #branches to update condition and indicator variables dependant on user input
            print("You turn the gold key to the left position")
            cond1=True
            ind1="left"
        elif (selection==2):
            print("You turn the gold key to the right position")
            cond1=False
            ind1="right"
        elif (selection==3):
            print("You turn the gold key to the center position")
            cond1=False
            ind1="center"
        elif (selection==4):
            room=0
            print("You have returned to entrance")

    while (room==3): #pantry room with functionality identical to kitchen
        print("Room: Pantry\n--------------\nYou're in the pantry that contains the usual foodstuffs. In front of you is a silver lock with 3 positions: left, center and right. Behind you is the doorway to the entranceway.")
        if (ind2=="left"):
            print("The silver key is currently in the left position")
        elif (ind2=="right"):
            print("The silver key is currently in the right position")
        elif (ind2=="center"):
            print("The silver key is currently in the center position")
        print("")
        print("Room Options:")
        print("1: Turn the silver key to the left position")
        print("2: Turn the silver key to the right position")
        print("3: Turn the silver key to the center position")
        print("4: Don't change the position! Return to entranceway")
        selection =int(input("Your selection (must be 1, 2, 3 or 4) "))
        print("")

        while ((selection<=0) or (selection>=5)):
            selection = int(input("Invalid selction! Must be 1, 2, 3 or 4: "))
        if (selection==1):
            print("You turn the gold key to the  left position")
            cond2=False
            ind2="left"
        elif (selection==2):
            print("You turn the silver key to the right position")
            cond2=True
            ind2="right"
        elif (selection==3):
            print("You turn the silver key to the center position")
            cond2=False
            ind2="center"
        elif (selection==4):
            room=0
            print("You have returned to entrance")

print("You have won! Tune in on June 12, 2017 to play part 2!") #end game message
