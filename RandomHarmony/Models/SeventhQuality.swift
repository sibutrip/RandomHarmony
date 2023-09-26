//
//  SeventhQuality.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum OLDSeventhQuality {
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

enum SeventhQuality {
    case major, minor, diminished
    var pitchClass: Interval {
        switch self {
        case .major:
            return .majorSeventh
        case .minor:
            return .minorSeventh
        case .diminished:
            return .majorSixth // fudging because solfege for this is ehhh
        }
    }
//    func transposed(to root: Pitch) -> Int {
//        return self.pitchClass + root.pitchClass
//    }
}
