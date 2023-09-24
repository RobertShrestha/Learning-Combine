import Foundation

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


    let texts = ["R", "O", "B"]
    var index = 0

    func getResults() -> AnyPublisher<String?, Never> {
        return Future<String?, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                promise(.success(texts[index]))
            }
        }
        .map { $0 }
        //        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    let taps = PassthroughSubject<Void, Never>()
    let subscriptions = taps.map { _ in getResults()}
        .print()
        .switchToLatest().sink { value in
            print(value as Any)
        }

    let subscription = taps.map { _ in getResults() }
        .switchToLatest().print().sink {
            print("Here")
            print($0 as Any)
        }
    // R
    taps.send()

    //0
    DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
        index += 1
        taps.send()
    }
    //B
    DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
        index += 1
        taps.send()
    }
}
usingCombinationOperator()
