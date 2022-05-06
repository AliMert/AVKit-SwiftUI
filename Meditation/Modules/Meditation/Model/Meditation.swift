//
//  Meditation.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import Foundation

struct Meditation {
    let id = UUID()
    let title: String
    let description: String
    let duration: TimeInterval
    let track: String
    let image: String

    static let data = Meditation(title: "5 Minute Relaxing Meditation", description: "Clear your mind and slumber into nothingness. Allocate only a few moments for a quick breather.", duration: 289, track: "meditation1", image: "image-stones")
}
