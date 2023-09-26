//
//  Note.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/20/23.
//

import Foundation

struct Note {
    let pitch: Pitch
    var midiNoteNumber: Int { self.pitch.midiNote }
    var pitchClass: Int { self.pitch.pitchClass }
    let accidentalStyle: AccidentalStyle = .natural
    var octave: Int {
        return Int(midiNoteNumber) / 12
    }
    var noteName: NoteName {
        switch accidentalStyle {
        case .sharp:
            switch self.pitchClass {
            case 0: return .C
            case 1: return .C
            case 2: return .D
            case 3: return .D
            case 4: return .E
            case 5: return .F
            case 6: return .F
            case 7: return .G
            case 8: return .G
            case 9: return .A
            case 10: return .A
            case 11: return .B
            default: return .C
            }
        case .flat:
            switch self.pitchClass {
            case 0: return .C
            case 1: return .D
            case 2: return .D
            case 3: return .E
            case 4: return .E
            case 5: return .F
            case 6: return .G
            case 7: return .G
            case 8: return .A
            case 9: return .A
            case 10: return .B
            case 11: return .B
            default: return .C
            }
        case .natural:
            switch self.pitchClass {
            case 0: return .C
            case 1: return .C
            case 2: return .D
            case 3: return .D
            case 4: return .E
            case 5: return .F
            case 6: return .F
            case 7: return .G
            case 8: return .G
            case 9: return .A
            case 10: return .A
            case 11: return .B
            default: return .C
            }
        }
    }
    
    /// 0 is middle c, positive numbers are lines on treble clef, negative numbers of lines on bass clef
    var staffPosition: Int {
        if octave > 4 {
            return ((noteName.rawValue) + (octave - 5) * 7) / 2
        } else {
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
//            let numberOfLedgerLines = ((noteName.rawValue - 5) + (octave - 6) * 7 + 2) / 2
//            return numberOfLedgerLines
            return staffPosition - 5
        case .bass:
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
