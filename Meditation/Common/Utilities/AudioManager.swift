//
//  AudioManager.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import Foundation
import AVKit


final class AudioManager: NSObject, ObservableObject {
    private var player: AVAudioPlayer?

    @Published private(set) var isPlaying = false
    @Published private(set) var isOnRepeat = false

    private var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    func startPlayer(track: String) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default) // prevents muting on silent mode
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self

            if isPreview {
                player?.prepareToPlay()
            } else {
                playPause()
            }
        } catch {
            print("Failed to initialize player: ", error)
        }
        
    }

    func playPause() {
        guard let player = player else {
            return
        }

        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }

        isPlaying = player.isPlaying
    }

    func stop() {
        guard let player = player else {
            return
        }

        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }

    func goForward(by value: Int) {
        guard let player = player else {
            return
        }
        player.currentTime += Double(value)
    }

    func goBackward(by value: Int) {
        guard let player = player else {
            return
        }
        player.currentTime -= Double(value)
    }

    func toogleIsOnRepeat() {
        guard let player = player else {
            return
        }
        isOnRepeat.toggle()

        let repeatForever = -1
        player.numberOfLoops = isOnRepeat ? repeatForever : .zero
    }

    func setCurrentTime(by value: TimeInterval) {
        player?.currentTime = value
    }

    func getCurrentTime() -> TimeInterval {
        player?.currentTime ?? .zero
    }

    func getDuration() -> TimeInterval {
        player?.duration ?? .zero
    }

    func getFormattedCurrentTime() -> String {
        let currentTime = player?.currentTime ?? 0
        let formattedCurrentTime = DateComponentsFormatter.positional.string(from: currentTime)
        return formattedCurrentTime ?? "0:00"
    }

    func getFormattedRemainigTime() -> String {
        let duration = player?.duration ?? 0
        let currentTime = player?.currentTime ?? 0
        let remainingTime = duration - currentTime

        let formattedCurrentTime = DateComponentsFormatter.positional.string(from: remainingTime)
        return formattedCurrentTime ?? "0:00"
    }

}

extension AudioManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying  = !flag
    }


}
