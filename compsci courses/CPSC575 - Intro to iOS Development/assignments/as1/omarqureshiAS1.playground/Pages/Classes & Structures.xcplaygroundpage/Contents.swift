//: [Back to page 2 of 3 ...](@previous)

//: ## Classes and Structures
//:

//: Write a class `IntegerStack` that represents a stack of integers, with push() and pop() methods.
//: _(7 points)_
class IntegerStack{
    var intArray:Array = [Int]()
    
    func push(intToPush: Int){
        self.intArray.append(intToPush)
        print(intArray, "<-- rightmost element is ToS")
    }
    
    func pop() -> Int? {
        if self.intArray.last != nil {
            let intToReturn = self.intArray.last
            self.intArray.removeLast()
            print("You popped \(intToReturn ?? 0)")
            return intToReturn!
        } else {
            return nil
        }
    }
}

//: Test your IntegerStack class to show that it works
var myStack = IntegerStack()

myStack.push(intToPush:2)
myStack.push(intToPush:4)
myStack.push(intToPush:34)
myStack.pop()
myStack.push(intToPush:3)
myStack.pop()
//: Extend the `String` class to add the method `reverseWords()`. 
//:
//: You should then be able to get an output of `true` for the following input:
//:
//: `"mary had a little lamb".reverseWords() == "lamb little a had mary"`
//:
//: _(8 points)_
extension String {
    func reverseWords() -> String {
        let words:Array = self.split(separator:" ")
        var stringArray:Array = [String]()
        
        for word in words{
            stringArray.insert(String(word), at:0)
        }
        
        return stringArray.joined(separator: " ")
    }
}

"mary had a little lamb".reverseWords() == "lamb little a had mary"
//: Add a subclass of Vehicle called Car which implements makeNoise()
//:
//: Car should be initializable like this:
//:
//: `let car = Car(seats: 5)`
//: `car.motionType == Vehicle.MotionType.Driving`
//:
//: _(9 points)_
class Vehicle {
    enum MotionType { case Driving, Flying, Sailing }
    let motionType: MotionType
    
    init(motionType: MotionType) {
        self.motionType = motionType
    }
    
    func makeNoise() {
        print("overridden function") //string does not print since function is overridden/implemented in subclass
    }
}


class Car:Vehicle {
    var seats:Int
    
    init(seats: Int){
        self.seats = seats
        super.init(motionType: Vehicle.MotionType.Driving)
    }
    
    override func makeNoise() {
        print("vroom vroom!")
    }
}

let car = Car(seats: 5)
car.motionType == Vehicle.MotionType.Driving
car.makeNoise()
//: [You are done! Return to first page ...](Overview)
