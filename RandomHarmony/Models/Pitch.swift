//
//  Pitch+Extension.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

struct Pitch {
    let midiNote: Int
    var pitchClass: Int {
        midiNote % 12
    }
    init(_ midiNote: Int) {
        self.midiNote = midiNote
    }
}

extension Pitch {
    var accidentalStyle: AccidentalStyle {
        switch self.pitchClass {
        case 0:
            return .sharp
        case 1:
            return .flat
        case 2:
            return .sharp
        case 3:
            return .flat
        case 4:
            return .sharp
        case 5:
            return .flat
        case 6:
            return .flat
        case 7:
            return .sharp
        case 8:
            return .flat
        case 9:
            return .sharp
        case 10:
            return .flat
        case 11:
            return .sharp
        default:
            return .sharp
        }
    }
}
