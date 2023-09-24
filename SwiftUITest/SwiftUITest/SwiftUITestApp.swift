//
//  SwiftUITestApp.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/22/23.
//

import SwiftUI

@main
struct SwiftUITestApp: App {
    var body: some Scene {
        WindowGroup {
            let userSettings = UserSetting()
            EnvironmentObjectTestView()
                .environmentObject(userSettings)
        }
    }
}
