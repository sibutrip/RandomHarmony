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
    
    /// ordered indices of note locations on staff (B3,C4,D4...)
    var staffOrder: Int {
        let noteOffset = (noteName.rawValue + 5) % 7
//        return noteOffset * octave
        return noteOffset + octave * 7
    }
    
    /// ordered indices of order of solfege notes (Cbb,Cb,C,C#,C##,Dbb...)
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
    
    func isAdjacentTo(previousPitch: Pitch) -> Bool {
        /// adjacent B and C, separated by octave
        if (self.octave + 1 == previousPitch.octave) {
            if self.noteName == .B && previousPitch.noteName == .C {
                return true
            } else { return false }
            
            /// adjacent B and C, separated by octave
        } else if (self.octave - 1 == previousPitch.octave) {
            
            /// if C is middle C, not a cluster
            if self.octave == 4 { return false }
                
            if self.noteName == .C && previousPitch.noteName == .B {
                return true
            } else { return false }
            
            /// same octave, adjacent note
        } else if self.octave == previousPitch.octave {
            let octaveAdjustedDistance = (self.noteName.rawValue - previousPitch.noteName.rawValue + 7) % 7
            if abs(octaveAdjustedDistance) == 1 {
                return true
            } else { return false }
        } else {
            return false
        }
    }
    
    func staffOffset(spaceHeight: CGFloat, lineHeight: CGFloat) -> CGFloat {
        
        if self.octave >= 4 {
            let noteOffset = self.noteName.trebleClefPosition + 7 * (self.octave - 5)
            return -spaceHeight * 9 + -CGFloat(noteOffset) * (spaceHeight / 2 + lineHeight / 2)
        } else {
            let noteOffset = (self.noteName.trebleClefPosition - 1) + 7 * (self.octave - 4)
            return -CGFloat(noteOffset) * (spaceHeight / 2 + lineHeight / 2) - (spaceHeight + lineHeight)
        }
    }
}
