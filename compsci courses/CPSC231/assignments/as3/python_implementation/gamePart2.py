#Safian Omar Qureshi
#ID 10086638
#TA: Mojtaba Komeili
#T03
#v1.40 (last modified 4:00pm, June 12, 2017)

#A text-based game involving six rooms written in Python. Upon running the game, the user is transported to a middle
#entrance room. The user has three numerical options which they can input; try the front door which is initally locked
#or enter the kicthen/pantry which are adjacent rooms. If upon entering a non valid numerical, repeatedly prompts user
#for proper numerical input. When entering adjacent rooms, the user has the option for turning two keys. When the right
#key combination is attained in the adjacent doors, the main door in the entrace is unlocked and the user enters the second part.

#The second part involves an additional three doors, starting with the living room. User must explore the attic and bedroom 
#for objects to be put into inventory and interact with a pot of plant. With the right combination of actions, the plant
#grows into a vine and the user wins the game.

#Limitations: can not handle non numerical character input from stupid user

KITCHEN = "Room: Kitchen"   #creating some named constants to be used for rooms 
PANTRY = "Room: Pantry"
ENTRANCE = "Room: Entrance"
LIVING = "Room: Living Room"
ATTIC = "Room: Attic"
BEDROOM = "Room: Bedroom"


def kitchenOps(ind1):
    print(KITCHEN)
    goldKeyIndicator(ind1)
    print("--------------\n")
    print("Options:")
    print("1: Turn the gold key to the left position")
    print("2: Turn the gold key to the right position")
    print("3: Turn the gold key to the center position")
    print("4: Don't change the position! Return to entranceway")


def pantryOps(ind2):
    print(PANTRY)
    silverKeyIndicator(ind2)
    print("--------------\n")
    print("Options:")
    print("1: Turn the silver key to the left position")
    print("2: Turn the silver key to the right position")
    print("3: Turn the silver key to the center position")
    print("4: Don't change the position! Return to entranceway")


def entranceOps():
    print(ENTRANCE)
    print("--------------\n")
    print("Options:")
    print("1: Try to open the door")
    print("2: Go through the left entryway")
    print("3: Go through the right entryway")


def goldKeyIndicator(ind1):
    if (ind1=="left"):
        print("Gold key is currently in left position")
    elif (ind1=="right"):
        print("Gold key is currently in right position")
    elif (ind1=="center"):
        print("Gold key is currently in center position")


def silverKeyIndicator(ind2):
    if (ind2=="left"):
        print("Silver key is currently in left position")
    elif (ind2=="right"):
        print("Silver key is currently in right position")
    elif (ind2=="center"):
        print("Silver key is currently in center position")


def livingRoomOps(ropeObtained):
    if (ropeObtained==False): #living room option function using branching to display appropriate choices
        print(LIVING)
        print("--------------")
        print("You see in this room:\n*A pot of soil\n*Stairs going up\n*A dark doorway\n*A ball of string\n")
        print("Options:")
        print("1: Look at plant")
        print("2: Take the stairs up")
        print("3: Go through dark doorway")
        print("4: Pick up the ball of string")
    else:
        print(LIVING)
        print("--------------")
        print("You see in this room:\n\n*A pot of soil\n*Stairs going up\n*A dark doorway\n")
        print("Options:")
        print("1: Look at plant")
        print("2: Take the stairs up")
        print("3: Go through dark doorway")


def atticOps(rope):
    if (rope==True):#attic room option function using branching to display appropriate choices
        print(ATTIC)
        print("--------------")
        print("You see in this room:\n*Stairs going down\n*A small hole leading down..\n*Some cheese on the counter\n")
        print("Options:")
        print("1: Take the stairs back down")
        print("2: Try dropping the cheese down the hole")
        print("3: Picking cheese off the counter")
        print("4: Try dropping ball of string down the hole")
    else:
        print(ATTIC)
        print("--------------")
        print("You see in this room:\n*Stairs going down\n*A small hole leading down..\n*Some cheese on the counter\n")
        print("Options:")
        print("1: Take the stairs back down")
        print("2: Try dropping the cheese down the hole")
        print("3: Picking cheese off the counter")


def dangleOps(): #subfunction of bedroomOps function for repeated code 
    print(BEDROOM)
    print("--------------")
    print("You see in this room:\n*Dark entrance way back\n*A cat near a small mouse hole...\n")
    print("Options:")
    print("1: Go back to the living room")
    print("2: Dangle string in front of cat")


def noDangleOps():
    print(BEDROOM)
    print("--------------")
    print("You see in this room:\n*Dark entrance way back\n*A cat near a small mouse hole...\n")
    print("Options:")
    print("1: Go back to the living room")


def bedroomOps(rope,mouseActive,cheese): #this function uses branching to display appropriate options in the bedroom
        if (rope==False) and (mouseActive==False) and (cheese==False):
            noDangleOps()
        elif (rope==True):
            dangleOps()
        elif (rope==False) and (mouseActive==True) and (cheese==False):
            print(BEDROOM)
            print("--------------")
            print("You see in this room:\n*Dark entrance way back\n*The cat chased the ball of string and a mouse has appeared!\n")
            print("Options:")
            print("1: Go back to the living room")
        elif (rope==False) and (mouseActive==True) and (cheese==True):
            print(BEDROOM)
            print("--------------")
            print("You see in this room:\n*Dark entrance way back\n*The cat chased the ball of string and a mouse has appeared!\n")
            print("Options:")
            print("1: Go back to the living room")
            print("2: Give mouse some cheese!")
        elif (rope==False) and (mouseActive==False) and (cheese==True):
            noDangleOps()
        elif (rope==True) and (mouseActive==False) and (cheese==True):
            dangleOps()


def selectionChecker1(selection): #these two selection functions check if user entered appropriate selection
    while ((selection<1) or (selection>4)):
        selection = int(input("Invalid selection! Must be 1, 2, 3 or 4: "))
    return(selection)


def selectionChecker2(selection):
    while ((selection<1) or (selection>3)):
        selection = int(input("Invalid selection! Must be 1, 2 or 3: "))
    return(selection)


def kitchen(cond1,ind1): #kitchen along with pantry take two arguments to handle the keys appropriately 
    exitKitchen = 0
    while (exitKitchen==0):
        kitchenOps(ind1)
        selection = int(input("Your selection (1, 2, 3 or 4): "))
        print("")
        selection = selectionChecker1(selection)
        
        if (selection==1):
            cond1=True
            ind1="left"
        elif (selection==2):
            cond1=False
            ind1="right"
        elif (selection==3):
            cond2=False
            ind1="center"
        elif (selection==4):
            return(cond1,ind1)


def pantry(cond2,ind2):
    exitPantry = 0
    while (exitPantry==0):
        pantryOps(ind2)
        selection = int(input("Your selection (1, 2, 3 or 4): "))
        print("")
        selection = selectionChecker1(selection)
        
        if (selection==1):
            cond2=False
            ind2="left"
        elif (selection==2):
            cond2=True
            ind2="right"
        elif (selection==3):
            cond2=False
            ind2="center"
        elif (selection==4):
            return(cond2,ind2)


def entrance(): #previous assignment game with 3 rooms
    gameWin1=False
    cond1=True #starting conditions are true by default to enter living room quickly
    cond2=True
    ind1="left"
    ind2="right"
    
    while (gameWin1==False):
        entranceOps()
        selection = int(input("Your selection (1, 2 or 3): "))
        print("")
        selection = selectionChecker2(selection)
        print("")
        
        if (selection==1):
            if ((cond1==True) and (cond2==True)):
                print("The tumblers click and the door unlocks, you have entered the living room!")
                print("But the door behind you fades into the darkness...\n")
                gameWin1=True
            else:
                print("The door to the living room remains locked...")
        if (selection==2):
            cond1,ind1 = kitchen(cond1,ind1)
        if (selection==3):
            cond2,ind2 = pantry(cond2,ind2)


def subAttic(selection,cheese): #breaking down the attic for repeated code
    
    if (selection==2):
        if (cheese==False):
            print("You aren't holding any cheese to drop!\n")
        elif (cheese==True):
            print("The cheese is too big to fit in the small hole...\n")
    if (selection==3):
        print("You got cheese, and there still remains some to spare!\n")
        cheese=True

    return(cheese)


def attic(rope,cheese,mouseActive): #attic room takes 3 arguments which determine how the logic varies in the room
    exitAttic = 0 #exitAttic variable used to stay in the attic until return is called to living room 
    while (exitAttic==0):
        
        if(rope==False): #when string is not carried, only 3 options
            atticOps(rope)
            selection = int(input("Your selection (1, 2 or 3): "))
            selection = selectionChecker2(selection)
            if (selection==1):
                return(rope,cheese,mouseActive)
            cheese=subAttic(selection,cheese)

        if(rope==True): #4 options now
            atticOps(rope)
            selection = int(input("Your selection (1, 2, 3 or 4): "))
            selection = selectionChecker1(selection)
            if (selection==1):
                return(rope,cheese,mouseActive)
            if (selection==2 or selection==3):
                cheese=subAttic(selection,cheese)
            if (selection==4): #if the string is rolled down, a new variable mouseActive initiates 
                print("Ball in the hole! The string rolls down!\n")
                rope=False
                mouseActive = True


def bedroomDangle(): #breaking down bedroom function into more subfunctions to handle repeated logic
    exitBedroom=0
    while(exitBedroom==0):
        selection=int(input("Your selection (1 or 2): "))
        while ((selection<1) or (selection>2)):
            selection = int(input("Invalid selection! Must be 1 or 2: "))
        
        if (selection==1):
            return
        if (selection==2):
            print("You dangle the string but the cat seems uninterested...")


def bedroomNoDangle(): #breaking down bedroom function into more subfunctions to handle repeated logic
    selection=int(input("Your selection (1): "))
    while ((selection!=1)):
        selection = int(input("Invalid selection! Must be 1: "))
    if (selection==1):
        return


def bedroom(rope,cheese,mouseActive,winCond): #bedroom function takes 4 arguments which determine its logic in the room
    exitBedroom=0 #exitbedroom variable used to stay in bedroom until return is called to living room 
    while(exitBedroom==0):
    
        if (rope==True): #branching used to take into consideration if mouse active, string options, cheese in inventory or not
            bedroomOps(rope,mouseActive,cheese)
            bedroomDangle()
            return(winCond,cheese)

        elif ((rope==False) and (cheese==True) and (mouseActive==True)):
            bedroomOps(rope,mouseActive,cheese)
            selection=int(input("You selection (1 or 2): "))
            while ((selection<1) or (selection>2)):
                selection = int(input("Invalid selection! Must be 1 or 2: "))
            if (selection==1):
                return (winCond,cheese)
            if (selection==2):
                print("You feed the mouse, it runs to the living room!\nThen it comes back, maybe it wants more cheese...")
                winCond=True
                cheese=False
         
        else:
            bedroomOps(rope,mouseActive,cheese)
            bedroomNoDangle()
            return(winCond,cheese)


def livingRoom(gameWon,cheese,rope,ropeObtained,mouseActive,winCond): #main function that runs as long as game is not won
    while (ropeObtained==False): #a ropeObtained variable is used to check if user has gotten string or not
        livingRoomOps(ropeObtained)
        selection = int(input("Your selection (1, 2, 3 or 4): "))
        selection = selectionChecker1(selection)
        
        if (selection==1): #since game cannot be won without string, selection 1 in this loop always give not win message
            print("The plant looks withered and dry...\n")
        elif (selection==2):
            rope, cheese, mouseActive = attic(rope,cheese,mouseActive)
        elif (selection==3):
            bedroom(rope,cheese,mouseActive,winCond)
        elif (selection==4):
                print("You put the ball of string in your pocket!\n")
                rope=True
                ropeObtained=True

    while ((ropeObtained==True)): #if rope is obtained, option to pick more is gone 
        livingRoomOps(ropeObtained)
        selection = int(input("Your selection (1, 2 or 3): "))
        selection = selectionChecker2(selection)
        
        if (selection==1): #checks win condition that is returned by the bedroom function, initially false
            if (winCond==True):
                print("The mouse fertlized the plant and a vine has grown!\nYou climb and escape!!\n")
                gameWon=True
                return (ropeObtained,gameWon)
            else:
                print("The plant looks withered and dry...")
        elif (selection==2):
            rope, cheese, mouseActive = attic(rope,cheese,mouseActive)
        elif (selection==3):
            winCond,cheese = bedroom(rope,cheese,mouseActive,winCond)


def start():
    entrance()

    gameWon=False
    cheese=False
    rope=False
    ropeObtained=False
    mouseActive=False
    winCond=False

    while (gameWon==False): #runs main livingroom function as long as game has not been won, if it has, breaks loop to end program
        ropeObtained,gameWon = livingRoom(gameWon,cheese,rope,ropeObtained,mouseActive,winCond)


start()
print("Thanks for playing, please give me a 4.0 Moji!")
print("\a")