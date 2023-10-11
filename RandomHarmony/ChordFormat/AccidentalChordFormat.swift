//
//  AccidentalChordFormat.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/6/23.
//

import Foundation

extension ChordFormat {
    struct AccidentalChordFormat: Identifiable {
        var id: UUID { pitch.id }
        let pitch: Pitch
        private var offsetMultiplier: Double
        func offset(multipliedBy staffSpace: CGFloat) -> CGFloat {
            return offsetMultiplier * staffSpace
        }
        
        static func createAccidentalOrder(from pitches: [Pitch]) -> [AccidentalChordFormat] {
            guard !pitches.isEmpty else { return [] }
            var pitches = pitches
                .sorted { $0.noteOrder < $1.noteOrder }
                .filter { $0.fixedSolfege.accidental != .natural }
            
            let accidentalPitchesEnumerated = pitches
                .enumerated()
                .reversed() // so that the top note will always be first in the accidentalPitches array
            var accidentalPitches = accidentalPitchesEnumerated
                .compactMap { index, pitch in
                    if index == 0 || index == (accidentalPitchesEnumerated.count - 1) {
                        pitches.remove(at: index)
                        return pitch
                    } else {
                        return nil
                    }
                }
            
            // (Int,[Pitch]) is (numberOfGoodDistances, sequence)
            let remainingPitchesPermutations = pitches.permutations()
            let remainingPitches = remainingPitchesPermutations
                .reduce((numberOfGoodDistances: 0, pitches: [Pitch]())) { partialResult, pitches in
                    let numberOfGoodDistances = pitches.enumerated().map { index, pitch in
                        if index > 0 {
                            let lastPitch = index > 0 ? pitches[index - 1] : accidentalPitches.last
                            let staffOrder = pitch.staffOrder
                            let previousStaffOrder = lastPitch?.staffOrder ?? pitch.staffOrder
                            let staffOrderDifference = abs(staffOrder - previousStaffOrder) >= 3 ? 1 : 0
                            return staffOrderDifference
                        } else {
                            return 0
                        }
                    }
                        .reduce(0, +)
                    if numberOfGoodDistances > partialResult.0 {
                        return (numberOfGoodDistances, pitches)
                    } else {
                        return partialResult
                    }
                }
                .pitches
            accidentalPitches += remainingPitches
            
            let accidentalChordFormats: [AccidentalChordFormat] = accidentalPitches.enumerated().map { index, accidentalPitch in
                if index > 0 {
                    let previousAccidentalPitch = accidentalPitches[index - 1]
                    let staffDistance = abs(accidentalPitch.staffOrder - previousAccidentalPitch.staffOrder)
                    let accidentalOffset = switch staffDistance {
                    case 0:
                        1.5
                    case 1...2:
                        1.5
                    case 3...5:
                        0.5
                    case 6...Int.max:
                        0.0
                    default:
                        1.5
                    }
                    return AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: accidentalOffset)
                } else {
                    return AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: 1.5)
                }
            }
            return accidentalChordFormats
        }
    }
}
