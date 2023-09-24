import UIKit
import Combine

// MARK: - Section 3 Part 1 Transforming operator
// Map operator
struct Point {
    let x: Int
    let y: Int
}
// flatMap operator
struct School {
    let name:String
    let noOfStudent: CurrentValueSubject<Int, Never>
    init(name: String , noOfStudent: Int) {
        self.name = name
        self.noOfStudent = CurrentValueSubject(noOfStudent)
    }
}

func usingTransformingOperator() {
    // MARK:  Collect operator
    print("<==== Collect operator ====>")
    // in this sink only return a single value from the array i.e one int value at a time
    [1,2,3,4,5,6].publisher.sink { value in
        print(value)
    }
    // in this sink only return the whole array
    [1,2,3,4,5,6].publisher.collect().sink { value in
        print(value)
    }
    
    // in this sink only return array with size of 3
    [1,2,3,4,5,6].publisher.collect(3).sink { value in
        print(value)
    }
    
    // MARK:  Map operator
    print("<==== Map operator ====>")
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    [123,45,34].publisher.map {
        formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
    }.sink { value in
        print(value)
    }
    
    let publisher = PassthroughSubject<Point, Never>()
    
    publisher.map(\.x, \.y).sink { x, y in
        print("x is \(x) and y is \(y)")
    }
    publisher.send(Point(x: 2, y: 10))
    
    // MARK:  flatMap operator
    print("<==== flatMap operator ====>")
    let citySchool = School(name: "City School", noOfStudent: 100)
    let school = CurrentValueSubject<School,Never>(citySchool)
    
    /*
     school.sink {
     print($0)
     }
     */
    school
        .flatMap{$0.noOfStudent}
        .sink { print($0)}
    
    let townSchool = School(name: "Town School", noOfStudent: 50)
    school.value = townSchool
    
    // does not trigger school.sink
    citySchool.noOfStudent.value += 1
    
    
    // so to get the change use flatmap so if we now change noOfStuden the Subject will recieve the event
    townSchool.noOfStudent.value += 10
    
    // MARK: ReplaceNil operator
    print("<==== ReplaceNil operator ====>")
    [1,2,nil,4].publisher.replaceNil(with: 0).sink { print($0)}
    
    // MARK:  Empty operator
    print("<==== Empty operator ====>")
    let empty = Empty<Int, Never>()
    empty.replaceEmpty(with: 1)
        .sink { print($0) } receiveValue: { print($0) }
    
    // MARK:  Scan operator
    print("<==== Scan operator ====>")
    let scanOperator = (1...10).publisher
    scanOperator.scan([]) { numbers, value -> [Int]in
        numbers + [value]
    }.sink { value in
        print(value)
    }
}
usingTransformingOperator()


// MARK: - Section 3 Part 2 Filter operator
func usingFilterOperator() {
    // MARK:  Filter operator
    print("<==== Filter operator ====>")
    let numbers = (1...20).publisher
    numbers.filter { $0 % 2 == 0 }
        .sink(receiveValue: {print($0)})
    
    // MARK:  RemoveDuplicates operator
    print("<==== RemoveDuplicates operator ====>")
    let words = "apple apple fruit fruit apple apple mango watermelon apple".components(separatedBy: " ").publisher
    words.removeDuplicates()
        .sink { print($0) }
    
    // MARK:  Compact map operator
    print("<==== CompactMap operator ====>")
    let strings = ["a", "1.24", "b", "3.45", "6.7"].publisher
        .compactMap{ Float($0)}
        .sink { print($0)}
    
    // MARK:  ignoreOutput operator
    print("<==== IgnoreOutput operator ====>")
    let newNumbers = (1...100).publisher
    // Just return the finish event and ignore the outputs
    newNumbers.ignoreOutput().sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
    
    // MARK:  first where operator
    print("<==== First where operator ====>")
    numbers.first(where: {$0 % 2 == 0})
        .sink { print($0) }
    
    // MARK:  last where operator
    print("<==== Last where operator ====>")
    numbers.last(where: {$0 % 2 == 0})
        .sink { print($0) }
    
    // MARK:  drop operator
    print("<==== Drop operator ====>")
    numbers.dropFirst(5).sink { print($0)}
    
    // MARK:  drop while operator
    print("<==== Drop While operator ====>")
    // it will drop until the condition is met then it will stop dropping
    numbers.drop(while: { $0 % 3 != 0}).sink { print($0) }
    
    // MARK:  drop until operator
    print("<==== Drop untilOutputFrom operator ====>")
    let isReady = PassthroughSubject<Void, Never>()
    let taps = PassthroughSubject<Int, Never>()
    
    taps.drop(untilOutputFrom: isReady).sink { print($0)}
    
    (1...10).forEach { n in
        // it will not send any event because taps is dropping everything till isReady is trigger
        taps.send(n)
        
        if n == 3 {
            isReady.send()
        }
    }
    
    // MARK:  prefix operator
    print("<==== Prefix operator ====>")
    // Get first two element
    numbers.prefix(2).sink { print($0) }
    //Get element from front which satisfy the condition
    numbers.prefix(while: { $0 < 3}).sink { print($0) }
    
    // Challenge
    
    /*
     For 1 to 100
     Drop first 50 values
     Then take 20 values
     Only take even
     
     Create an example that publishes a collection of numbers from 1 through 100, and use filtering
     operators to:
     1. Skip the first 50 values emitted by the upstream publisher.
     2. Take the next 20 values after those first 50 values.
     3. Only take even numbers.
     
     */
    let challengeNumbers = (1...100).publisher
    
    challengeNumbers.dropFirst(50).prefix(20).filter({$0 % 2 == 0}).sink { print($0) }
    
}
usingFilterOperator()

// MARK: - Section 3 Part 3 Combination operator

func usingCombinationOperator() {
    // MARK:  Prepend operator
    let numbers = (1...5).publisher
    let publisher2 = (500...510).publisher
    print("<==== Prepend operator ====>")
    numbers.prepend(100,101)
        .prepend(-1,-2)
        .prepend([45,53])
        .prepend(publisher2)
        .sink{ print($0)}
    
    // MARK:  Append operator
    print("<==== Append operator ====>")
    numbers.append(6,7)
        .append([8,9])
        .append(publisher2)
        .sink{ print($0)}
    
    // MARK:  SwitchToLatest operator
    print("<==== SwitchToLatest operator ====>")
    let publisher1 = PassthroughSubject<String, Never>()
    let publisher3 = PassthroughSubject<String, Never>()
    let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()
    
    publishers.switchToLatest().sink { print($0) }
    
    publishers.send(publisher1)
    publisher1.send("Publisher 1 - Value 1")
    publisher1.send("Publisher 1 - Value 2")
    
    publishers.send(publisher3)
    publisher3.send("Publisher 3 - Value 1")
    // This will not be called because publishers has the latest publisher3
    publisher1.send("Publisher 1 - Value 3")
    
    // MARK:  Merge operator
    print("<==== Merge operator ====>")
    let publisher4 = PassthroughSubject<String, Never>()
    let publisher5 = PassthroughSubject<String, Never>()
    publisher4.merge(with: publisher5).sink { print($0) }
    publisher4.send("1")
    publisher4.send("2")
    
    publisher5.send("3")
    publisher5.send("4")
    
    // MARK:  AllSatisfy operator
    print("<==== AllSatisfy operator ====>")
    let publisher7 = [12,2,4,6,8].publisher
    
    publisher7.allSatisfy { $0 % 2 == 0 }.sink { allEven in
        print(allEven)
    }
    
    // MARK:  print operator
    publisher7.print("Debugger").sink { print($0) }
    
    
    // MARK:  breakPoint operator Note: It does not work on playground because playground has not breakpoint feature
    let publisher8 = (1...10).publisher
    publisher8
        .breakpointOnError()
        .sink { print($0) }
    // MARK:  breakPoint operator Note: It does not work on playground because playground has not breakpoint feature
    // In this break point will hit when the value is greater than 9
    publisher8
        .breakpoint(receiveOutput: { value in
            return value > 9 })
        .sink { print($0) }
}
usingCombinationOperator()
/*
//Does not work inside a function
// MARK:  SwitchToLatest operator
print("<==== SwitchToLatest operator ====>")
var images = ["cat", "dog", "tiger"]
var index = 0
func getImage() -> AnyPublisher<String?, Never> {
    return Future<String?, Never> { promise in
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
            promise(.success(images[index]))
        }
    }
    .map { $0 }
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
}
// tap a button
let taps = PassthroughSubject<Void, Never>()
// Mapping Tap Publisher with AnyPublisher<UIImage?, Never>
let subscriptions = taps.map { _ in
    getImage()
}
    .switchToLatest()
    .sink { print($0) }

taps.send() // image1 with publisher

DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
    index += 1
    taps.send() // image2 with publisher
}
DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
    index += 1
    taps.send() // image 3 with publisher
}
*/

