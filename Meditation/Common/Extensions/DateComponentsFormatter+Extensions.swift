//
//  DateComponentsFormatter+Extensions.swift
//  Meditation
//
//  Created by Ali Mert Özhayta on 5.05.2022.
//

import Foundation

extension DateComponentsFormatter {

    static var abbreviated: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()

        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        return formatter
    }

    static var positional: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()

        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter
    }
}
