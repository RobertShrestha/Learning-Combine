//
//  StoryListViewModel.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import Foundation
import Combine
class StoryListViewModel: ObservableObject {
    @Published var stories: [StoryViewModel] = []
    var subscriber = Set<AnyCancellable>()

    init() {
        getStories()
    }
    private func getStories() {
        WebServices().getAllTopStories().map { stories in
            stories.map { StoryViewModel(story: $0)}
        }
            .sink(receiveCompletion: {print($0)}) { stories in
            self.stories = stories
            }.store(in: &subscriber)
    }

}
struct StoryViewModel {
    var story: Story
    var id: Int {
        return story.id
    }
    var url: String {
        return story.url
    }
}
