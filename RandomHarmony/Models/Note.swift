//
//  Note.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/20/23.
//

import Foundation

struct Note {
    let pitch: Pitch
    var midiNoteNumber: Int { self.pitch.midiNoteNumber }
    var pitchClass: FixedSolfege { self.pitch.fixedSolfege }
    let accidentalStyle: AccidentalStyle = .natural
    var octave: Int {
        return Int(midiNoteNumber) / 12
    }
    
    var noteName: NoteName {
        self.pitch.fixedSolfege.noteName
    }
    
    /// 0 is middle c, positive numbers are lines on treble clef, negative numbers of lines on bass clef
    var staffPosition: Int {
        if octave > 4 {
            //TODO: started note name at A instead of C. fix this
            return ((noteName.rawValue) + (octave - 5) * 7) / 2
        } else {
            //TODO: started note name at A instead of C. fix this
            return ((noteName.rawValue) + (octave - 4) * 7) / 2
        }
    }
    
    var ledgerLine: LedgerLine? {
        if staffPosition > 5 {
            return .treble
        } else if staffPosition == 0 {
            return .middleC
        } else if staffPosition < -5 {
            return .bass
        } else {
            return nil
        }
    }
    
    var ledgerLineCount: Int {
        switch ledgerLine {
        case .treble:
            //TODO: started note name at A instead of C. fix this

//            let numberOfLedgerLines = ((noteName.rawValue - 5) + (octave - 6) * 7 + 2) / 2
//            return numberOfLedgerLines
            return staffPosition - 5
        case .bass:
            //TODO: started note name at A instead of C. fix this
//            let numberOfLedgerLines = ((noteName.rawValue - 2) + (2 - octave) * 7 + 2) / 2
//            return numberOfLedgerLines
            return -staffPosition - 5
        case .middleC:
            return 1
        case nil:
            return 0
        }
    }
}
