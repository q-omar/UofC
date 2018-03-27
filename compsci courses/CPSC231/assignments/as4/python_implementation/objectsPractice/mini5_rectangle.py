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
    window.title("Drawing a pretty rectangle")
    aDrawingCanvas = Canvas(window,width=640,height=480,bg ="white")
    #creating a rectangle, first 2 numbers indicate topleft corner, second two numbers indicate bottom right
    aDrawingCanvas.create_rectangle(50,50,250,200,fill = "pink",outline="gold")

    # Draw window and start the gui
    aDrawingCanvas.pack()
    window.mainloop()


def start ():
    global aWindow
    global aButton

    aWindow.pack()
    aButton["text"] = "Press me ;)"
    aButton["command"] = button_clicked
    aButton.grid(row=0, column=0)
    aWindow.mainloop()

start()