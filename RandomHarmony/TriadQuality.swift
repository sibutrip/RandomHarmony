//
//  TriadQuality.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation
import Tonic

enum TriadQuality {
    case major, minor, diminished, augmented, sus
    var pitchClasses: [Int8] {
        switch self {
        case .major:
            return [0,4,7]
        case .minor:
            return [0,3,7]
        case .diminished:
            return [0,6,6]
        case .augmented:
            return [0,4,8]
        case .sus:
            return [0,5,7]
        }
    }
    func transposed(to root: Pitch) -> [Int8] {
        return self.pitchClasses.map { $0 + root.pitchClass }
    }
}
