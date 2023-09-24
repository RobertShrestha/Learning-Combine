//: [Previous](@previous)

import Foundation
import Combine

// MARK: - Section 2 Part 9 and 10 how publisher and subscriber work
func basicTutorial() {
    // Publisher and subscriber basic
    let notificationCenter = NotificationCenter.default
    let notification = Notification.Name("My Notification")
    let publisher = notificationCenter.publisher(for: notification)
    let subscriber = publisher.sink { _ in
        print("Got Notification")
    }
    notificationCenter.post(name: notification, object: nil)
    // when cancel is called the subscribtion to the publisher is cancelled so no other event is triggered in subscriber
    //subscriber.cancel()
    
    //notificationCenter.post(name: notification, object: nil)
    
}
basicTutorial()

// MARK: - Section 2 Part 11 Creating a subscriber
///*
class StringSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = Never
    func receive(subscription: Subscription) {
        print("Subscription Recieved")
        // if you to get only 3 data
        //subscription.request(.max(3))
        subscription.request(.unlimited)
    }
    // it increase in the demand
    func receive(_ input: String) -> Subscribers.Demand {
        print("Recieved Value", input)
        // if you wan to get all the data
        //return .unlimited
        // if you want to get none data
        return .none
        
        // This will increase the demand by 1
        // return .max(1)
    }
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
}
func usingSubscriber() {
    let publisher = ["A","B","C","D","E","F","G","H","I","J","K"].publisher
    
    let stringSubscriber = StringSubscriber()
    publisher.subscribe(stringSubscriber)
}
usingSubscriber()
//*/

// MARK: - Section 2 Part 12 Subjects

enum MyError: Error {
    case subscriberError
}

class StringSubscriberSubject: Subscriber {
    typealias Input = String
    typealias Failure = MyError
    func receive(subscription: Subscription) {
        print("Subscription Recieved")
        // if you to get only 3 data
        //subscription.request(.max(3))
        subscription.request(.unlimited)
    }
    // it increase in the demand
    func receive(_ input: String) -> Subscribers.Demand {
        print("Recieved Value", input)
        // if you wan to get all the data
        //return .unlimited
        // if you want to get none data
        return .none
        
        // This will increase the demand by 1
        // return .max(1)
    }
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completion")
    }
}

func usingSubjects() {
    let stringSubscriber = StringSubscriberSubject()
    let subject = PassthroughSubject<String, MyError>()
    subject.subscribe(stringSubscriber)
    let subscription = subject.sink { _ in
        print("Received Completion from sink")
    } receiveValue: { value in
        print("Received Completion from value \(value)")
    }
    subject.send("A")
    subject.send("B")
    // The subscribe will get all the value but subscription will get cancalled here so the two event will not be recieved in sink
    subscription.cancel()
    subject.send("C")
    subject.send("D")
}

usingSubjects()
