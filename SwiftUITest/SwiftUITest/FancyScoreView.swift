//
//  FancyScoreView.swift
//  ObservableObjectAnotherExample
//
//  Created by Mohammad Azam on 8/3/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct FancyScoreView: View {
    
    @EnvironmentObject var userSettings: UserSetting
    
    var body: some View {
        VStack {
            Text("\(self.userSettings.count)")
            Button("Increment Score") {
                self.userSettings.count += 1
            }.padding().background(Color.green)
            
        }.padding().background(Color.orange)
    }
}

#if DEBUG
struct FancyScoreView_Previews: PreviewProvider {
    static var previews: some View {
        FancyScoreView()
    }
}
#endif
