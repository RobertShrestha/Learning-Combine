//
//  StateTest.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/22/23.
//

import SwiftUI


struct StateTest: View {
    @State var posts = [Post]()

    var body: some View {
        List {
            Button(action: addPost) {
                Text("Add")
            }
            ForEach(posts) { post in
                Text(post.title)
            }
        }
    }
    private func addPost() {
        self.posts.append(Post(title: "Hello is this"))
    }
}

struct StateTest_Previews: PreviewProvider {
    static var previews: some View {
        StateTest()
    }
}
