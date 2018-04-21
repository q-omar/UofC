# Author:  James Tam
# Version: September 29, 2014

# Maps a numeric value to the name of the month
# Error message displayed if an invalid numeric value entered.


month = int(input("Enter month (1 - 12): "))
while ((month>12) or (month<1)):
  print("Months only range from 1 - 12")
  month = int(input("Enter month (1 - 12): "))

print("Month is...", end="")
if (month == 1):
  print("January")
elif (month == 2):
  print("February")
elif (month == 3):
  print("March")
elif (month == 4):
  print("April")
elif (month == 5):
  print("May")
elif (month == 6):
  print("June")
elif (month == 7):
  print("July")
elif (month == 8):
  print("August")
elif (month == 9):
  print("September")
elif (month == 10):
  print("October")
elif (month == 11):
  print("November")
elif (month == 12):
  print("December")
