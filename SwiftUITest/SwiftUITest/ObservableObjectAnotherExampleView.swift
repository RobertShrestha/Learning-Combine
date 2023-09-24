//
//  ObservableObjectAnotherExampleView.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/23/23.
//

import SwiftUI

struct ObservableObjectAnotherExampleView: View {
    @ObservedObject var setting = UserSetting()
    var body: some View {
        VStack {
            Text("\(setting.count)")
            Button {
                setting.incrementCount()
            } label: {
                Text("Increment count")
            }
        }
    }
}

struct ObservableObjectAnotherExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObjectAnotherExampleView()
    }
}
