//
//  ObservableObjectTestView.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/23/23.
//

import SwiftUI

struct ObservableObjectTestView: View {
    @ObservedObject var fancyTime = FancyTimer()
    var body: some View {
        Text("\(fancyTime.value)")
            .font(.title)
    }
}

struct ObservableObjectTestView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObjectTestView()
    }
}
