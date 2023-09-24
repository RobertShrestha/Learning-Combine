//
//  EnvironmentObjectTestView.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/23/23.
//

import SwiftUI

struct EnvironmentObjectTestView: View {
    @EnvironmentObject var userSettings: UserSetting

    var body: some View {
        VStack {
            Text("\(self.userSettings.count)")
                .font(.largeTitle)
            Button("Increment Score") {
                self.userSettings.count += 1
            }

            FancyScoreView()
        }
    }
}

struct EnvironmentObjectTestView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectTestView()
    }
}
