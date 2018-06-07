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
    window = Tk() #grey, c;pse/resize button part of the frame
    window.title("Tamj's gui example")   # Label the title bar
    aDrawingCanvas = Canvas(window,width=640,height=480,bg ="grey")
    # Shape's first four properties: Top LHS(x,y),Bottom RHS(x,y)
    aDrawingCanvas.create_rectangle(10,10,100,50) #x1,y1,x2,y2

    # Next two properties = strings to specify fill and outline
    # colors
    aDrawingCanvas.create_oval(50,100,200,90, fill = "red")
    aDrawingCanvas.create_rectangle(300,100,200,200,fill = "orange",outline="blue")

    # Draw window and start the gui
    aDrawingCanvas.pack()
    window.mainloop()


def start ():
    global aWindow
    global aButton

    aWindow.pack()
    aButton["text"] = "Press me"
    aButton["command"] = button_clicked
    aButton.grid(row=0, column=0)
    aWindow.mainloop()

start()
