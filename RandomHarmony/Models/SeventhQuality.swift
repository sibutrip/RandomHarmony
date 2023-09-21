//
//  SeventhQuality.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum SeventhQuality {
    case major, minor, diminished
    var pitchClass: Int {
        switch self {
        case .major:
            return 11
        case .minor:
            return 10
        case .diminished:
            return 9
        }
    }
    func transposed(to root: Pitch) -> Int {
        return self.pitchClass + root.pitchClass
    }
}
