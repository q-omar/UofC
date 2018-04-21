MIN_AGE = 1
MAX_AGE = 114

def agePrompt():
    print("Enter age (%d-%d): " %(MIN_AGE,MAX_AGE), end="")
    age = int(input())
    if (age<MIN_AGE or age>MAX_AGE):
        print("age out of range")
        age = agePrompt()

    return(age)

def runPromptCodeOmar(): #my attempt
    prompt=input("another age? y or n")
    if prompt=="y"
        agePrompt()


def runPromptCode():
    age = agePrompt()
    print("Your age %d: " %age)
    rep =input("Want to repeat? y or n: ")
    if rep=="y":
        runPromptCode()



def main():
    age = -1
    age = agePrompt()
    print("Your age %d" %age)
    prompt=input("another age? y or n")
    while (prompt=="y"):
        age = agePrompt()
        print("Your age %d" %age)
        prompt=input("another age? y or n")

main()
