//
//  FancyTimer.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/23/23.
//

import Foundation

class FancyTimer: ObservableObject {
    @Published var value = 0

    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.value += 1
        }
    }
}
