//
//  StoryDetailView.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import SwiftUI

struct StoryDetailView: View {
    let storyId: Int
    @ObservedObject var storyDetailViewModel: StoryDetailViewModel
    init(storyId: Int) {
        self.storyId = storyId
        self.storyDetailViewModel = StoryDetailViewModel()
    }
    var body: some View {
        VStack {
            Text("\(storyDetailViewModel.title)")
            WebView(url: storyDetailViewModel.url)
        }

            .onAppear {
                self.storyDetailViewModel.fetchStoryDetails(storyId: storyId)
            }
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(storyId: 886)
    }
}
