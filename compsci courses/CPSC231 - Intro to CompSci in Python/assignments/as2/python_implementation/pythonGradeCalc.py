#Safian Omar Qureshi

#Takes user input grades for mini assignments, full assignments, midterm and final
#Converts each grade appropriately, outputs weighted grades for each section as well as full final grade out of 4

#Limitations: does not handle non numerical character input from stupid user

print("Entering mini-assignments")
miniA1 = float(input("What is your grade (0-4) for mini assignment #1?: ")) #converts user inputs to floating point to be used in formula
miniA2 = float(input("What is your grade (0-4) for mini assignment #2?: "))
miniA3 = float(input("What is your grade (0-4) for mini assignment #3?: "))
miniA4 = float(input("What is your grade (0-4) for mini assignment #4?: "))

miniA1_weighted = (0.5/100)*(miniA1) #formula for converting grade to weighted
miniA2_weighted = (0.5/100)*(miniA2)
miniA3_weighted = (0.5/100)*(miniA3)
miniA4_weighted = (0.5/100)*(miniA4)
sumweights_miniassigns = miniA1_weighted + miniA2_weighted + miniA3_weighted + miniA4_weighted #sums all weights, to be used in GPA

print("")
print("Entering full assignments")
fullA1 = float(input("What is your grade (0-4) for full assignment #1?: "))
fullA2 = float(input("What is your grade (0-4) for full assignment #2?: "))
fullA3 = float(input("What is your grade (0-4) for full assignment #3?: "))
fullA4 = float(input("What is your grade (0-4) for full assignment #4?: "))
fullA5 = float(input("What is your grade (0-4) for full assignment #5?: "))

fullA1_weighted = (0.04)*(fullA1)
fullA2_weighted = (0.06)*(fullA2)
fullA3_weighted = (0.06)*(fullA3)
fullA4_weighted = (0.1)*(fullA4)
fullA5_weighted = (0.07)*(fullA5)


sumweights_fullassigns = fullA1_weighted + fullA2_weighted + fullA3_weighted + fullA4_weighted + fullA5_weighted

print("")
print("Entering examinations")
midterm = float(input("What is your grade (0-4) for the midterm?: "))
final = float(input("What is your grade (0-4) for the final?: "))

midterm_weighted = (0.25)*(midterm)
final_weighted = (0.40)*(final)


finalGPA = sumweights_miniassigns + sumweights_fullassigns + midterm_weighted + final_weighted #summing all sections to produce final grade
print("")
print("Weighted grade points")
print("---------------")
print("Mini-assignments")
print("Weighted mini assignment grade #1: " '%3.3f'%(miniA1_weighted)) #prints weighted grades for each section formatted to 3 decimal precision
print("Weighted mini assignment grade #2: " '%3.3f'%(miniA2_weighted))
print("Weighted mini assignment grade #3: " '%3.3f'%(miniA3_weighted))
print("Weighted mini assignment grade #4: " '%3.3f'%(miniA4_weighted))
print("")

print("Full assignments")
print("Weighted full assignment grade #1: " '%3.3f'%(fullA1_weighted))
print("Weighted full assignment grade #2: " '%3.3f'%(fullA2_weighted))
print("Weighted full assignment grade #3: " '%3.3f'%(fullA3_weighted))
print("Weighted full assignment grade #4: " '%3.3f'%(fullA4_weighted))
print("Weighted full assignment grade #5: " '%3.3f'%(fullA5_weighted))
print("")

print("Exams")
print("Weighted midterm grade: " '%3.3f' %(midterm_weighted))
print("Weighted final grade: " '%3.3f' %(final_weighted))
print("========================================")
print("Weighted term grade: " '%3.3f' %(finalGPA))
if (finalGPA==4):
    print("Woo hoo, you got an A!")