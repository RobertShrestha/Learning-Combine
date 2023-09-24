//
//  StoryListView.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import SwiftUI

struct StoryListView: View {
    @ObservedObject var storiesViewModel = StoryListViewModel()
    var body: some View {
        NavigationView {

                List(self.storiesViewModel.stories, id: \.id) { storyVM in
                    NavigationLink {
                        StoryDetailView(storyId: storyVM.id)
                    } label: {
                        Text("\(storyVM.story.title)")
                    }
                }
            .navigationTitle("Hacker News")
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
