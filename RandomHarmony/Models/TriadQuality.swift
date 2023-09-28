//
//  TriadQuality.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum TriadQuality: String, CaseIterable {
    case major, minor, diminished, augmented, sus
    var pitchClasses: [Interval] {
        switch self {
        case .major:
            return [.unison,.majorThird,.perfectFifth]
        case .minor:
            return [.unison,.minorThird,.perfectFifth]
        case .diminished:
            return [.unison,.minorThird,.diminishedFifth]
        case .augmented:
            return [.unison,.majorThird,.augmentedFifth]
        case .sus:
            return [.unison,.perfectFouth,.perfectFifth]
        }
    }
}

extension TriadQuality: Identifiable {
    var id: String {
        return self.rawValue
    }
}
