//
//  StateFilterView.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/22/23.
//

import SwiftUI

struct StateFilterView: View {
    @State var posts: [Post] = Post.getAllPost()
    @State var isPublished = false
    var body: some View {
        List {
            Toggle(isOn: $isPublished) {
                Text("Published")
                    .font(.body)
            }
            ForEach(posts.filter { $0.isPublished == self.isPublished }) { post in
                HStack(alignment: .center ) {
                    VStack(alignment: .leading ) {
                        Text(post.title)
                            .font(.title)
                        Text(post.description)
                            .font(.subheadline)
                    }
                    Spacer()
                    Text(post.isPublished ? "Published" : "Not Published")
                }
            }
        }
    }
}

struct StateFilterView_Previews: PreviewProvider {
    static var previews: some View {
        StateFilterView()
    }
}
