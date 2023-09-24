//
//  StoryDetailViewModel.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import Foundation
import Combine

class StoryDetailViewModel: ObservableObject {

    private var subscriber = Set<AnyCancellable>()
    @Published private var story = Story.placeholder()

    
    func fetchStoryDetails(storyId: Int) {
        WebServices().getStoryById(storyId: storyId)
            .catch({ _ in Just(Story.placeholder())})
                .sink(receiveCompletion: {print($0)}) { story in
                self.story = story
            }.store(in: &subscriber)
    }
}
extension StoryDetailViewModel {
    var title: String {
        return story.title
    }

    var url: String {
        return self.story.url
    }
}
