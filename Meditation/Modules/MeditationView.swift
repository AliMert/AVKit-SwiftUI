//
//  MeditationView.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import SwiftUI

struct MeditationView: View {
    var body: some View {
        VStack(spacing: .zero) {
            Image("image-stones")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)

            // MARK: Meditation Detail

            ZStack {
                // MARK: Background
                Color(red: 24/255, green: 23/255, blue: 22/255)

                VStack(spacing: 24) {

                    // MARK: Type & Duration

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Music")
                        Text("0s")
                    }
                    .hLeading()
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)

                    // MARK: Title
                    Text("1 Minute Relaxing Meditation")
                        .font(.title)

                    // MARK: Description
                    Text("Clear your mind and slumber into nothingness. Allocate only a few moments for a quick breather.")

                    // MARK:  Play Button
                    Button {

                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }

                    Spacer()
                }
                .hLeading()

                .foregroundColor(.white)
                .padding(20)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 3)
        }
        .ignoresSafeArea()
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
