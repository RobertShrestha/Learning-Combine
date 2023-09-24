//
//  HackerNewsApp.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import SwiftUI

@main
struct HackerNewsApp: App {
    fileprivate func setupNavigationbarColor() {
        UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 255/255, green: 102/255, blue: 0/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }

    init() {
        setupNavigationbarColor()
    }
    var body: some Scene {
        WindowGroup {
            StoryListView()
        }
    }
}
