//
//  SeventhQuality.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum SeventhQuality: String, CaseIterable {
    case major, minor, diminished
    var pitchClass: Interval {
        switch self {
        case .major:
            return .majorSeventh
        case .minor:
            return .minorSeventh
        case .diminished:
            return .diminishedSeventh
        }
    }
}
