//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/22/23.
//

import SwiftUI

struct ContentView: View {
    @State var name = "Robert"
    var body: some View {
        ZStack {
            Color.green
                .cornerRadius(10)
            VStack {
                Text("Hello")
                Text("World")
                HStack {
                    Text("A")
                    Spacer()
                    Text("B")
                }.padding()
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                .padding()
                Text(name)
                Button(role: .none) {
                    name = "Named changes"
                } label: {
                    Text("Change name")
                }.padding(5)

            }
            
        }.frame(width: 200, height: 100)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
