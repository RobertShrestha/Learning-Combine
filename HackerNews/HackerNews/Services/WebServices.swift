//
//  WebServices.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import SwiftUI
import Combine
class WebServices {

    func getStoryById(storyId: Int) -> AnyPublisher<Story, Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyId).json?print=pretty") else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Story.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    private func mergeStories(ids storyIds: [Int]) -> AnyPublisher<Story, Error> {

        let storyIds = Array(storyIds.prefix(50))

        let initialPublisher = getStoryById(storyId: storyIds[0])
        let remainder = Array(storyIds.dropFirst())
        return remainder.reduce(initialPublisher) { combined, id in
            return combined.merge(with: getStoryById(storyId: id))
                .eraseToAnyPublisher()
        }
    }
    func getAllTopStories() -> AnyPublisher<[Story], Error> {
        guard let url = URL(string:"https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else { fatalError("Invalid URL")}
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap{ storyIds in
                return self.mergeStories(ids: storyIds)
            }
            .scan([]) { stories, story -> [Story] in
                return stories + [story]
            }
            .eraseToAnyPublisher()
    }
}
