//: [Previous](@previous)

import UIKit
import Combine

struct Post: Codable {
    let title: String
    let body: String
}
///*
    func getPost()-> AnyPublisher<[Post], Error>{
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalide URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url).map{$0.data}
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    let cancellable = getPost().sink(receiveCompletion: { _ in }, receiveValue: { print($0)})
 //*/


guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
    fatalError("Invalide URL")
}

let request = URLSession.shared.dataTaskPublisher(for: url)
let subscription = request
    .handleEvents(receiveSubscription: { _ in print("receiveSubscription")},
                  receiveOutput: { _ in print("receiveOutput")},
                  receiveCompletion:{ _ in print("receiveCompletion")},
                  receiveCancel: {print("receiveCancel")},
                  receiveRequest: { _ in print("receiveRequest")})
    .sink(receiveCompletion: {print($0)}) { data , response in
    print(data)
}


