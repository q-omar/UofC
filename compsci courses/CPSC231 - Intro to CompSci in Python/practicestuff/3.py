def kitchenOps():
    print("You are in Kitchen\nYou have 4 options")

def kitchen():
    kitchenOps()
    selection = int(input("Your selection: "))
    while ((selection<=0) or (selection>=5)):
        room = int(input("Invalid! Selection: "))
    if (selection==1):
        print("Gold is left")
        cond1=True
        return (cond1)

def pantryOps():
    print("You are in pantry\nYou have 4 options")

def pantry():
    pantryOps()
    selection = int(input("Your selection: "))
    while ((selection<=0) or (selection>=5)):
        room = int(input("Invalid! Selection: "))
    if (selection==2):
        print("Silver is right")
        cond2=True
        return (cond2)

def entrance():
    entranceOps()
    room = int(input("Your selection: "))
    while ((room<=0) or (room>3)):
        room = int(input("Invalid! Selection: "))
    if (room==2):
        kitchen()
    elif (room==3):
        pantry()

def entranceOps():
    print("You are in Entrance\nYou have 3 options")


def start():
    gameWin1=False
    while (gameWin1==False):
        entrance()

start()
