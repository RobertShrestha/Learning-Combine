//
//  HelloBindingView.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/23/23.
//

import SwiftUI

struct HelloBindingView: View {
    @State var name: String = ""
    private func printName() {
        print(name)
    }
    var body: some View {
        VStack {
            Text(name)
            TextField("Enter the placholder", text: $name)
            Button {
                printName()
            } label: {
                Text("Print name")
            }

        }
    }
}

struct HelloBindingView_Previews: PreviewProvider {
    static var previews: some View {
        HelloBindingView()
    }
}
