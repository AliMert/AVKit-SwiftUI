//
//  MeditationView.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import SwiftUI

struct MeditationView: View {
    @StateObject var meditationVM: MeditationViewModel
    @State private var showPlayer = false

    var body: some View {
        VStack(spacing: .zero) {
            Image(meditationVM.meditation.image)
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
                        Text(
                            DateComponentsFormatter.abbreviated.string(from: meditationVM.meditation.duration)
                            ?? meditationVM.meditation.duration.formatted() + "s"
                        )
                    }
                    .hLeading()
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)

                    // MARK: Title
                    Text(meditationVM.meditation.title)
                        .font(.title)

                    // MARK: Description
                    Text(meditationVM.meditation.description)

                    // MARK:  Play Button
                    Button {
                        showPlayer = true
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
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(meditationVM: meditationVM)
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView(meditationVM: .init(meditation: Meditation.data))
            .environmentObject(AudioManager())
    }
}
