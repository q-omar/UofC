import random

SIZE = 4
EMPTY = " "
PERSON = "P"
PET = "T"
POOP = "O"
ERROR = "!"
CLEANED = "."

'''
Students write
'''
# clean()
# @arg(world: a reference to a 2D list of Strings of length one)
# @return(none)
def clean(world):
    print("Scooping the poop")

'''
Students write
'''
# count()
# @arg(world: a reference to a 2D list of Strings of length one)
# @return(string,int):
#   @first return value = single string character entered by the user
#   @second return value = the number of times that the string was found in the list
def count(world):
    print("Counting number of occurances of a character")
    number = 0
    element = input("Enter character: ")
    return(element,number)

# createElement()
# @args: none
# @return: a String of length one
# Randomly generates an 'occupant' for a location in the world
def createElement():
    tempNum = random.randrange(10)+1

    # 50% chance empty
    if ((tempNum >= 1) and (tempNum <= 5)):
        tempElement = EMPTY

    # 20% of a person
    elif ((tempNum >= 6) and (tempNum <= 7)):
        tempElement = PERSON

    # 10% chance of pet
    elif (tempNum == 8):
        tempElement = PET

    # 20% chance of poop in that location (lots in this world)
    elif ((tempNum >= 9) and (tempNum <= 10)):
        tempElement = POOP

    # In case there's a bug in the random number genrator
    else:
        tempElement = ERROR

    return(tempElement)

# createWorld()
# @args: none
# @return: a randomly initialized 2D list
# Creates the SIZExSIZE world. Randomly populates it with the
# return values from function createElement
def createWorld():
    world = [] #  Create a variable that refers to a 1D list.
    r = 0

    #  Outer 'r' loop traverses the rows.
    # Each iteration of the outer loop creates a new 1D list.
    while (r < SIZE):
        world.append([])  # Create new empty row
        c = 0
        # The inner 'c' loop traverses the columns of the newly
        # created 1D list creating and initializing each element
        # to the value returned by createElement()
        while (c < SIZE):
            element = createElement()
            world[r].append(element)
            c = c + 1
        r = r + 1
    return(world)

# Shows the elements of the world. All the elements in a row will
# appear on the same line.
def display(world):
    print("OUR WORLD")
    print("========")
    r = 0
    while (r < SIZE): # Each iteration accesses a single row
        c = 0
        while (c < SIZE):  # Each iteration accesses an element in a row
            print(world[r][c], end="")
            c = c + 1
        print()  # Done displaying row, move output to the next line
        r = r + 1

def start():
    world = createWorld()
    display(world)
    element,number = count(world)
    print("# occurances of %s=%d" %(element,number))
    clean(world)
    display(world)

start()
