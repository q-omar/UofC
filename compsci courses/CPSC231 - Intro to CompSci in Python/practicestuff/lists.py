# Author:  James Tam
# Version: November 2016
# Exercise 1: modifying list elements


def start():
     list = [1,2,3,4]
     print(list)
     index = int(input("Enter index of element to change: "))
     while((index<0) or (index>3)):
         index = int(input("Invalid index! Enter again: ")) #here we check if the index is valid given the size of the list
     newValue = int(input("Enter the new integer value for element: "))
     while (newValue<0):
         newValue = int(input("Enter non negative value: "))
     list[index]=newValue

     print(list)
start()
