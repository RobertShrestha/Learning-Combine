//
//  PodcastPlayerView.swift
//  SwiftUITest
//
//  Created by Robert Shrestha on 9/23/23.
//

import SwiftUI

struct PodcastPlayerView: View {
    @State var episode: Episode = Episode(name: "Macbreak Weekly", track: "WWDC 2019")
    @State var isPlaying = false
    var body: some View {
        VStack {
            Text(episode.name)
                .font(.title)
                .foregroundColor(isPlaying ? .green : .black)
            Text(episode.track)
                .foregroundColor(.gray)
            PlayButton(isPlaying: $isPlaying)
        }
    }
}
struct PlayButton: View {
    @Binding var isPlaying: Bool
    var body: some View {
        Button {
            isPlaying.toggle()
        } label: {
            Text(isPlaying ? "Pause" : "Play")
        }.padding()
    }
}

struct PodcastPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastPlayerView()
    }
}
