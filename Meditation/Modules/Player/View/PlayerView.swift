//
//  PlayerView.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import SwiftUI

struct PlayerView: View {
    var meditationVM: MeditationViewModel

    @State private var value: Double = .zero
    @State private var isFavourite = false
    @State private var isEditing = false

    @EnvironmentObject var audioManager: AudioManager
    @Environment(\.dismiss) var dismiss

    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            // MARK: Background Image
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width)
                .ignoresSafeArea()

            // MARK: Blur View

            Rectangle()
                .background(.ultraThinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()

            VStack(spacing: 32) {

                // MARK: Dismiss Button

                Button {
                    audioManager.stop()
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                }
                .hLeading()

                // MARK: Title
                Text(meditationVM.meditation.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 0.1, x: 0.2, y: 0.2)

                // MARK: Playback
                VStack(spacing: 5) {
                    // MARK: Playback Timeline
                    Slider(value: $value, in: 0...audioManager.getDuration()) { isEditingDone in
                        isEditing = isEditingDone

                        if !isEditingDone {
                            audioManager.setCurrentTime(by: value)
                        }
                    }
                    .tint(.white)

                    // MARK: Playback Time
                    HStack {
                        Text(audioManager.getFormattedCurrentTime())
                        Spacer()
                        Text(audioManager.getFormattedRemainigTime())
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 0.3, x: 0.3, y: 0.3)
                }
                .vBottom()

                // MARK: Playback Controls

                HStack {
                    // MARK: Repeat Button
                    PlaybackControlButton(
                        systemName: "repeat",
                        color: audioManager.isOnRepeat ? .teal : .white
                    ) {
                        audioManager.toogleIsOnRepeat()
                    }
                    Spacer()

                    // MARK: Backward Button
                    PlaybackControlButton(systemName: "gobackward.10") {
                        audioManager.goBackward(by: 10)
                    }
                    Spacer()

                    // MARK: Play Pause Button
                    PlaybackControlButton(
                        systemName: audioManager.isPlaying
                        ? "pause.circle.fill" : "play.circle.fill"
                        , fontSize: 44
                    ) {
                        audioManager.playPause()
                    }
                    Spacer()

                    // MARK: Forward Button
                    PlaybackControlButton(systemName: "goforward.10"){
                        audioManager.goForward(by: 10)
                    }

                    Spacer()
                    // MARK: Favourite Button
                    PlaybackControlButton(
                        systemName: isFavourite ? "heart.fill" : "heart",
                        color: isFavourite ? .red : .white,
                        action: {
                            isFavourite.toggle()
                        }
                    )
                }
                .shadow(color: .black, radius: 1, x: 0.8, y: 0.8)
            }
            .vTop()
            .padding(20)
        }
        .onAppear {
            audioManager.startPlayer(track: meditationVM.meditation.track)
        }
        .onReceive(timer) { _ in
            guard !isEditing else {
                return
            }
            value = audioManager.getCurrentTime()
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(meditationVM: .init(meditation: .data))
            .environmentObject(AudioManager())
    }
}
