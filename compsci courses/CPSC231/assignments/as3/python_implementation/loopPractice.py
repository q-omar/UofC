#Safian Omar Qureshi
#ID 10086638
#TA:  Mojtaba Komeili
#T03

#Takes user input for age: 
#If age is less than 0, outputs nonsense message and repeatedly prompts for age again.
#If age is greater than or equal to 0 but less than 18, repeatedly prompts for age again.
#If age is greater than or equal to 18, outputs final message and exits

#Limitations: does not handle non numerical character input from stupid user

age = int(input("What is your age in whole years?: ")) 
while (age<18): 
    if (age<0):
        print("Liar liar pants on fire!")
    age = int(input("What is your age in whole years?: "))
print("You are an adult! Get a job and move out")