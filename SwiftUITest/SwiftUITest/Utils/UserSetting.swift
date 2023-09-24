//
//  UserSetting.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/23/23.
//

import Foundation

class UserSetting: ObservableObject {
    @Published var count = 1

    func incrementCount() {
        count += 1
    }
}
