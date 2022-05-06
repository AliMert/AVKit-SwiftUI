//
//  ContentView.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MeditationView(meditationVM: .init(meditation: .data))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioManager())
    }
}
