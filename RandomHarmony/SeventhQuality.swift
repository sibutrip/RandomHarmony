//
//  SeventhQuality.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation
import Tonic

enum SeventhQuality {
    case major, minor, diminished
    var pitchClass: Int8 {
        switch self {
        case .major:
            return 11
        case .minor:
            return 10
        case .diminished:
            return 9
        }
    }
    func transposed(to root: Pitch) -> Int8 {
        return self.pitchClass + root.pitchClass
    }
}
