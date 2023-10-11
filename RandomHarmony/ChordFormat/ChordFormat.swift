//
//  ChordFormat.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/6/23.
//

import Foundation

struct ChordFormat {
    let pitchFormats: [PitchChordFormat]
    let accidentalPitches: [AccidentalChordFormat]
    
    static func makeChordFormat(from pitches: [Pitch]) -> ChordFormat {
        let accidentalOrder = AccidentalChordFormat.createAccidentalOrder(from: pitches)
        let pitchChordFormats = PitchChordFormat.createChordFormats(from: pitches)
        return ChordFormat(pitchFormats: pitchChordFormats, accidentalPitches: accidentalOrder)
    }
}
