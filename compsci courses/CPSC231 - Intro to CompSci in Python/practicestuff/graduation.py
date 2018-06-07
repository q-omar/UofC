grade = int(input("What grade are you in?: "))

while ((grade>13) or (grade<0)):
  grade = int(input("Please input grade again (between 1-13)"))

if (grade==13):
    print("you have graduated!")
else:
    print("you have not get graduated")
