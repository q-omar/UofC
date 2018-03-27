class Adventurer:
    name = ""
    health = ""

    def __init__(self,aName,aHealth):
        self.name = "nameless"
        self.health = -1
    
    def gainLevel(self):
        print("\nCongratulations, you leveled up!\n")
        self.health= self.health+5

    