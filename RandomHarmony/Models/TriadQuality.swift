//
//  TriadQuality.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum OLDTriadQuality {
    case major, minor, diminished, augmented, sus
    var pitchClasses: [Int] {
        switch self {
        case .major:
            return [0,4,7]
        case .minor:
            return [0,3,7]
        case .diminished:
            return [0,3,6]
        case .augmented:
            return [0,4,8]
        case .sus:
            return [0,5,7]
        }
    }
    func transposed(to root: Pitch) -> [Int] {
        return self.pitchClasses.map { $0 + root.pitchClass }
    }
}

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
