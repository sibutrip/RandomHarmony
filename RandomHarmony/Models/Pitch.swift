//
//  Pitch+Extension.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation


struct Pitch: Identifiable {
    let id = UUID()
    let fixedSolfege: FixedSolfege
    var octave: Int
    var midiNoteNumber: Int {
        (fixedSolfege.pitchClass + 12) * (octave + 1)
    }
    
    var noteName: NoteName {
        fixedSolfege.noteName
    }
    
    init(fixedSolfege: FixedSolfege, octave: Int) {
        self.fixedSolfege = fixedSolfege
        self.octave = octave
    }
    
    var ledgerLineCount: Int {
        if octave > 6 { fatalError("additional ledger lines not supported")}
        if octave == 6 {
            switch noteName {
            case .G, .A:
                return 4
            case .B:
                return 5
            case .C, .D:
                return 2
            case .E, .F:
                return 3
            }
        } else if octave == 5 {
            switch noteName {
            case .A, .B:
                return 1
            case .C, .D, .E, .F, .G:
                return 0
            }
        } else if octave == 4 && noteName == .C {
            return 1 // middle c
        } else if octave == 4 {
            return 0
        } else if octave == 2 {
            switch noteName {
            case .F, .G, .A, .B:
                return 0
            case .C:
                return 2
            case .D, .E:
                return 1
            }
        } else if octave == 1 {
            switch noteName {
            case .G, .A:
                return 3
            case .B:
                return 2
            case .C, .D:
                return 5
            case .E, .F:
                return 4
            }
        } else {
            fatalError("additional lower ledger lines not supported")
        }
    }
}

/// view-related
extension Pitch {
    
    /// used to check if notes are adjacent on staff
    var staffOrder: Int {
        let noteOffset = (noteName.rawValue + 5) % 7
        return noteOffset * octave
    }
    
    var noteOrder: Int {
        return fixedSolfege.order + (octave * 35)
    }
    
    var ledgerLine: LedgerLine? {
        if octave > 6 { fatalError("additional ledger lines not supported")}
        if octave == 6 {
            return .treble
        } else if octave == 5 {
            switch noteName {
            case .A, .B:
                return .treble
            case .C, .D, .E, .F, .G:
                return nil
            }
        } else if octave == 4 && noteName == .C {
            return .middleC
        } else if octave == 4 {
            return nil
        } else if octave == 3 {
            return nil
        } else if octave == 2 {
            switch noteName {
            case .F, .G, .A, .B:
                return nil
            case .C, .D, .E:
                return .bass
            }
        } else if octave == 1 {
            return .bass
        } else {
            fatalError("additional lower ledger lines not supported")
        }
    }
    
    func isAdjacentTo(otherPitch: Pitch) -> Bool {
        /// adjacent B and C, separated by octave
        if (self.octave + 1 == otherPitch.octave) {
            if self.noteName == .B && otherPitch.noteName == .C {
                return true
            } else { return false }
            
            /// adjacent B and C, separated by octave
        } else if (self.octave - 1 == otherPitch.octave) {
            if self.noteName == .C && otherPitch.noteName == .B {
                return true
            } else { return false }
            
            /// same octave, adjacent note
        } else if self.octave == otherPitch.octave {
            if abs(self.noteName.rawValue - otherPitch.noteName.rawValue) == 1 {
                return true
            } else { return false }
        } else {
            return false
        }
    }
}
