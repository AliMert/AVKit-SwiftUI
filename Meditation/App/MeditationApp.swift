//
//  MeditationApp.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import SwiftUI

@main
struct MeditationApp: App {
    @StateObject var audioManager = AudioManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
