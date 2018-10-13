//: [Back to page 2 of 3 ...](@previous)

//: ## Classes and Structures
//:

//: Write a class `IntegerStack` that represents a stack of integers, with push() and pop() methods.
//: _(7 points)_


//: Test your IntegerStack class to show that it works

//: Extend the `String` class to add the method `reverseWords()`. 
//:
//: You should then be able to get an output of `true` for the following input:
//:
//: `"mary had a little lamb".reverseWords() == "lamb little a had mary"`
//:
//: _(8 points)_

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
        // Nothing here yet
    }
}
//: [You are done! Return to first page ...](Overview)
