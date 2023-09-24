//
//  Post.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/22/23.
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    var title: String
    var description: String = ""
    var isPublished: Bool = false

    static func getAllPost() -> [Post] {
        return [
            Post(title: "Hello",
                 description: "Hello this is description",
                 isPublished: true),
            Post(title: "Hello 1",
                 description: "Hello this is description 1",
                 isPublished: false),
            Post(title: "Hello 2",
                 description: "Hello this is description 2",
                 isPublished: false)

        ]
    }
}
