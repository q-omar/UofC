//: [Back to page 1 of 3 ...](@previous)
//: ## Functions & Closures
//:
func calculator(a: Int, b: Int) -> Int {
    return a + b
}
//: Call the `calculator()` function with 1 and 2
//: _(1 point)_
calculator(a:1, b:2)
//: Change `calculator` to return both a + b and a * b
//: _(2 points)_
func calculator2(a: Int, b: Int) -> (sum: Int, product: Int) {
    let sum:Int = a+b
    let product:Int = a*b
    return (sum, product)
}
//: Write a function `average()` to calculate the average value of an Integer array.
//: _(2 point)_
func average(intArray: [Int]) -> Int{
    var sum:Int = 0
    for index in intArray{
        sum = index+sum
    }
    sum = sum/(intArray.count)
    return sum
}

//average(intArray: [45,2,3,4])//testing purposes
//: Write a function `greet` that takes an array of names (as strings) and a `greeter` function with signature String -> String, so that, for example, a call of `greet(["Alice", "Bob"], greeting: greeter)` prints "Hello, Alice!" and "Hello, Bob!".
//: _(6 points)_
func greeter(person:String) -> String{
    return person+"!"
}

func greet(nameArray:[String], greeting: String){
    for name in nameArray{
        print(greeting+greeter(person: name))
    }
}
greet(nameArray:["Alice", "Bob"], greeting: "Hello, ")
//: Use the map function on the following array of numbers to create an array of strings with the respective lengths.
//: _(2 points)_
var primeNumbers = [2, 3, 5, 7, 11, 13]
let primePoo = primeNumbers.map{
    String(repeating: "💩", count: $0)}

print(primePoo)
//: Write a function `updateEntry` that receives an array of integers and a closure to change the value of each entry in the array to a new value.
//: _(5 points)_
//:
func updateEntry(_: [Int], closure: (Int) -> Int) -> [Int]{
    for i in primeNumbers{
        primeNumbers.append(closure(i))
        primeNumbers.remove(at:0)
    }
    return primeNumbers
}
//: Use the following code to see whether your implementation works.
//: _(1 point)_
//:
//: `let results = updateEntry(primeNumbers) { $0 * $0 }`
//: `print(results)`
let results = updateEntry(primeNumbers) { $0 * $0 }
print(results)
//: Create an enum of `TimeUnit` with appropriate values Second, Minute, Hour, Day and Week.
//: Add a method for converting between them, so that one could call:  `TimeUnit.Day.convertTo(TimeUnit.Hour) == 24.0`.
//: _(6 points)_
enum TimeUnit:Double {
    case second = 1
    case minute = 60
    case hour = 3600
    case day = 86400
    case week = 604800
    
    func convertTo(aTimeUnit: TimeUnit) -> Double{
        switch aTimeUnit{
        case .second:
            return (self.rawValue/1)
        case .minute:
            return (self.rawValue/60)
        case .hour:
            return (self.rawValue/3600)
        case .day:
            return (self.rawValue/86400)
        case .week:
            return (self.rawValue/604800)
        }
    }
}

print(TimeUnit.day.convertTo(aTimeUnit:TimeUnit.hour))
//: [To page 3 of 3 ...](@next)
