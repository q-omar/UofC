//: [Back to Overview ...](@previous)
//:
//: ## Basics
//:
//: Declare a variable called 'string' that holds the value "This is my string!".
//: _(1 point)_
var string: String = "This is my string!"
//: Print the length of variable 'string'.
//: _(1 point)_
print(string.count)
//: Print the first character in 'string'.
//: _(1 point)_
var charIndex = string.index(string.startIndex, offsetBy: 0)
print(string[charIndex])
//: Print the 9th character in 'string'
//: _(1 point)_
charIndex = string.index(string.startIndex, offsetBy: 9)
print(string[charIndex])
//: Print the first 4 characters in 'string'.
//: _(2 points)_
print(string.prefix(4))
//: Print the last 5 characters in 'string'.
//: _(2 points)_
print(string.suffix(5))
//: Print the last 6 characters in 'string', but in reverse order.
//: _(2 points)_
print(String(string.suffix(6).reversed()))
//: Print the 3rd word in 'string'.
//: _(2 point)_
let stringArray:Array = string.split(separator:" ")
print(stringArray[2])
//: Create an array that contains "a", "b", "c", called 'myArray'.
//: _(1 point)_
let myArray:Array = ["a","b","c"]
//: Get the length of 'myArray'.
//: _(1 point)_
let length:Int = myArray.count
//: Get the 2nd item in 'myArray'.
//: _(1 point)_
myArray[1]
//: Print "long" if the length of 'myArray' is more than 5, else print "short".
//: _(2 point)_
if myArray.count > 5{
    print("long")
} else {
    print("short")
}
//: Print each element in 'myArray' on a line by itself.
//: _(2 point)_
for element in myArray{
    print(element)
}
//: Create a constant array called 'myStrings' that contains the strings: "these" "are" "my" "strings".
//: _(1 point)_
let myStrings:Array = ["these", "are", "my", "strings"]
//: Print the index of "my" in 'myStrings', if it is in the array
//: _(2 point)_
var index:Int = 0
for words in myStrings{
    if (words=="my"){
        print(index)
        
    }
    index += 1
}
//: Print each key and value in the following dictionary. Sort your output alphabetically by the capital cities.
//: _(2 point)_
let capitals = ["Israel": "Jerusalem", "Germany": "Berlin", "France": "Paris", "England": "London", "Canada": "Ottawa"]
let sortedCapitals = capitals.sorted(by: {$0.value < $1.value } )
print(sortedCapitals)
//: Add "a" to the value in the key "hello" in this dictionary. You can only add one line of code!
//: _(2 point)_
var someDictionary = ["hello": ["b", "c"]]
someDictionary["hello"]!.insert("a", at: 0)
//print(someDictionary) //this line of code isn't necessarily needed, just wanted to check if my output is correct
//: [To page 2 of 3 ...](@next)
