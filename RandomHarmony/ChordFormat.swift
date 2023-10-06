//
//  ChordFormat.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/6/23.
//

import Foundation

struct ChordFormat {
    let pitchFormats: [PitchChordFormat]
    let accidentalOrder: [Pitch]
    
    static func makeChordFormat(from pitches: [Pitch]) -> ChordFormat {
        let accidentalOrder = PitchChordFormat.createAccidentalOrder(from: pitches)
        let pitchChordFormats = PitchChordFormat.createChordFormats(from: pitches)
        return ChordFormat(pitchFormats: pitchChordFormats, accidentalOrder: accidentalOrder)
    }
    
    struct PitchChordFormat: Identifiable {
        var id: UUID { pitch.id }
        let pitch: Pitch
        var isCluster: Bool { clusterOrder != 0 }
        let clusterOrder: Int
        var accidental: Accidental { pitch.fixedSolfege.accidental }
        var clusterCount: Int = 0
        var offsetOddNumberOverride = false
        var isOffset: Bool {
            // if not in a cluster, not offset
            guard clusterCount > 0 else { return false }
            
            // IF # of notes in cluster is even,
            // OR if the previous note is NOT a 3rd below
            // THEN even ordered notes are offset
            if clusterCount % 2 == 0 || !offsetOddNumberOverride {
                return clusterOrder % 2 == 0
            }
            // if # of notes in cluster is odd, odd ordered notes are offset
            return clusterOrder % 2 == 1
        }
        
        static fileprivate func createAccidentalOrder(from pitches: [Pitch]) -> [Pitch] {
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
            return accidentalPitches
        }
        
        static fileprivate func createChordFormats(from pitches: [Pitch]) -> [PitchChordFormat] {
            let pitches = pitches.sorted {
                $0.noteOrder < $1.noteOrder
            }
            var clusterCounter = 0
            var pitchChordFormats = [PitchChordFormat]()
            pitches.enumerated().forEach { index, pitch in
                if index > 0 {
                    let previousPitch = pitches[index - 1]
                    if pitch.isAdjacentTo(previousPitch: previousPitch) {
                        clusterCounter += 1
                        return pitchChordFormats.append(PitchChordFormat(pitch: pitch, clusterOrder: clusterCounter))
                    } else if clusterCounter != 0 {
                        
                        var offsetOddNumberOverride = false
                        //if the previous pitch is a 3rd below, offset will ALWAYS be on odd clusterOrder notes
                        if (pitch.noteName.rawValue - previousPitch.noteName.rawValue + 7) % 7 == 2 {
                            offsetOddNumberOverride = true
                        }
                        // add cluster count to all notes in the cluster
                        (0...clusterCounter).forEach { counter in
                            pitchChordFormats[index - 1 - counter].clusterCount = clusterCounter
                            pitchChordFormats[index - 1 - counter].offsetOddNumberOverride = offsetOddNumberOverride
                        }
                        clusterCounter = 0
                    }
                }
                //                clusterCounter = 0
                pitchChordFormats.append(PitchChordFormat(pitch: pitch, clusterOrder: clusterCounter))
            }
            
            /// if sequence ends in cluster. add cluster counter to last notes
            if clusterCounter != 0 {
                var offsetOddNumberOverride = false
                if pitchChordFormats.count > 2 {
                    let lastPitch = pitchChordFormats[pitchChordFormats.count - 1].pitch
                    let secondToLastPitch = pitchChordFormats[pitchChordFormats.count - 2].pitch
                    if (lastPitch.noteName.rawValue - secondToLastPitch.noteName.rawValue + 7) % 7 == 2 {
                        offsetOddNumberOverride = true
                    }
                    /// add cluster count to all notes in the cluster
                    (0...clusterCounter).forEach { counter in
                        pitchChordFormats[pitchChordFormats.count - 1 - counter].clusterCount = clusterCounter
                        pitchChordFormats[pitchChordFormats.count - 1 - counter].offsetOddNumberOverride = offsetOddNumberOverride
                    }
                }
            }
            return pitchChordFormats
        }
    }
}
