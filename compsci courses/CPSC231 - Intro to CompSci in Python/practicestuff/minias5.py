# Author:  James Tam
# Version: November 21, 2013
#
# Change the text in the button to "Press me"
# When the botton pressed change the text to "Stop pressing me!"

from tkinter import *

aWindow = Frame()
aButton = Button(aWindow)

# Since the parameter list is pre-defined passing aButton into the function
# is problematic (created as a global).
def button_clicked() :
    window = Tk()
    aDrawingCanvas = Canvas(window,width=640,height=480,bg ="white")

    # Draw window and start the gui
    aDrawingCanvas.pack()
    window.mainloop()


def start ():
    global aWindow
    global aButton

    aWindow.pack()
    aButton["text"] = "Press me" #the button has text on it
    aButton["command"] = button_clicked #what the button does 
    aButton.grid(row=0, column=0)
    aWindow.mainloop()

start()
