//
//  Pitch+Extension.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation


struct Pitch {
    let fixedSolfege: FixedSolfege
    var octave: Int
    var midiNoteNumber: Int {
        fixedSolfege.pitchClass + 12 * octave
    }
    
    init(fixedSolfege: FixedSolfege, octave: Int) {
        self.fixedSolfege = fixedSolfege
        self.octave = octave
    }
}
