//
//  MeditationViewModel.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import Foundation

final class MeditationViewModel: ObservableObject {

    private(set) var meditation: Meditation

    init(meditation: Meditation) {
        self.meditation = meditation
    }
}
