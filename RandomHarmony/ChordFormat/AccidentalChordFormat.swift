//
//  AccidentalChordFormat.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/6/23.
//

import Foundation
import SwiftUI

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
            
            let accidentalsToAddToStack = pitches.enumerated().compactMap { index, pitch in
                let pitchShouldBeInCluster = accidentalPitches.reduce(true) { currentState, existingClusterPitch in
                    if abs(pitch.staffOrder - existingClusterPitch.staffOrder) >= 6 && currentState {
                        return true
                    } else {
                        return false
                    }
                }
                if pitchShouldBeInCluster {
                    pitches.remove(at: index)
                    return pitch
                } else { return nil }
            }
            
            accidentalPitches += accidentalsToAddToStack
            let stackedAccidentals = accidentalPitches
            
            // (Int,[Pitch]) is (numberOfGoodDistances, sequence)
            let remainingPitchesPermutations = pitches.permutations()
            let remainingPitches = remainingPitchesPermutations
                .reduce((numberOfGoodDistances: Int.min, pitches: [Pitch]())) { partialResult, pitches in
                    let numberOfGoodDistances: Int = pitches.enumerated().map { index, pitch in
                        if index > 0 {
                            let lastPitch = index > 0 ? pitches[index - 1] : accidentalPitches.last
                            let staffOrder = pitch.staffOrder
                            let previousStaffOrder = lastPitch?.staffOrder ?? pitch.staffOrder
                            let staffOrderDifference = (previousStaffOrder - staffOrder) >= 3 ? 1 : 0
                            return staffOrderDifference
                        } else {
                            let staffOrder = pitch.staffOrder
                            let staffOrderDifference = accidentalPitches.reduce(true) { previousResult, previousPitch in
                                if !previousResult { return false }
                                let previousStaffOrder = previousPitch.staffOrder
                                return (previousStaffOrder - staffOrder) >= 5 ? true : false
                            }
                            return staffOrderDifference ? 1 : 0
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
//            var lastStaffDistance = 1
            var totalAccidentalOffset = Double() // if accidentals are stacked, next non-stacked note should have its spacing determined by the closest note to it.
            var accidentalChordFormats = [AccidentalChordFormat]()
            accidentalPitches.enumerated().forEach { index, accidentalPitch in
                if index > 0 {
                    let previousAccidentalPitch = accidentalPitches[index - 1]
                    let previousPreviousAccidentalPitch = index > 1 ? accidentalPitches[index - 2] : previousAccidentalPitch
                    var closestPreviousAccidental = stackedAccidentals // + [previousAccidentalPitch]
                    var closestPreviousPreviousAccidental = stackedAccidentals // + [previousAccidentalPitch]
                    if !stackedAccidentals.contains(where: { $0 == previousAccidentalPitch }) {
                        closestPreviousAccidental = [previousAccidentalPitch]
                    } else if stackedAccidentals.contains(where: { $0 == accidentalPitch} ) {
                        closestPreviousAccidental = closestPreviousAccidental.filter {
                            $0 != accidentalPitch
                        }
                    }
                    if index > stackedAccidentals.count {
                        closestPreviousPreviousAccidental = [previousPreviousAccidentalPitch]
                    } else {
                        closestPreviousPreviousAccidental = closestPreviousAccidental
                    }
                    let (staffDistance,previousAccidental) = closestPreviousAccidental.reduce((Int.max, Accidental.natural)) { lastDistance, previousPitch in
                        let newDistance = previousPitch.staffOrder - accidentalPitch.staffOrder
                        if abs(lastDistance.0) < abs(newDistance) {
                            return lastDistance
                        } else {
                            return (newDistance, previousPitch.fixedSolfege.accidental)
                        }
                    }
                    let (lastStaffDistance,previousPreviousAccidental) = closestPreviousPreviousAccidental.reduce((Int.max, Accidental.natural)) { lastDistance, previousPitch in
                        let newDistance = previousPitch.staffOrder - accidentalPitch.staffOrder
                        if abs(lastDistance.0) < abs(newDistance) {
                            return lastDistance
                        } else {
                            return (newDistance, previousPitch.fixedSolfege.accidental)
                        }
                    }
                    let currentOffset = Self.xOffset(first: previousAccidental, second: accidentalPitch.fixedSolfege.accidental, staffDistance: staffDistance)
                    let lastOffset = Self.xOffset(first: previousPreviousAccidental, second: accidentalPitch.fixedSolfege.accidental, staffDistance: lastStaffDistance)
//                    let currentOffset = Self.xOffset(accidentalPitch: accidentalPitch.fixedSolfege.accidental, lastPitch: previousAccidentalPitch.fixedSolfege.accidental, staffDistance: staffDistance)
//                    let lastOffset = Self.xOffset(accidentalPitch: accidentalPitch.fixedSolfege.accidental, lastPitch: previousPreviousAccidentalPitch.fixedSolfege.accidental, staffDistance: lastStaffDistance)
                    var accidentalOffset: CGFloat
                    
                    // conditions for accidental spacing to avoid collision with previousPrevious accidental
                    if lastOffset > currentOffset {
                        let offsetDifference = lastOffset - currentOffset
                        if offsetDifference > currentOffset {
                            accidentalOffset = offsetDifference
                        } else { accidentalOffset = currentOffset }
                    } else {
                        accidentalOffset = currentOffset
                    }
                    totalAccidentalOffset += accidentalOffset
                    accidentalChordFormats.append(AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: totalAccidentalOffset))
                } else {
                    if index == 0 {
                        totalAccidentalOffset += 1.9
                    }
                    accidentalChordFormats.append(AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: 1.9))
                }
            }
            return accidentalChordFormats
        }
        
        /// sharps and flats only. fatal error on any other Accidental
        private static func xOffset(first: Accidental, second: Accidental, staffDistance: Int) -> CGFloat {
            return IntervalDirection.offset(from: first, to: second, over: staffDistance)
        }
    }
}

struct AccidentalChordFormat_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            let height: CGFloat = geo.size.height
            let staveCount = CGFloat(6)
            let staffRatio = min(0.6, staveCount * -0.013 + 0.7)
            let staffSpace = (1 - staffRatio) * height / (staveCount + 1) * 1.8
            let staffHeight = staffRatio * height / staveCount - (staffSpace / staveCount)
            let lineHeight = staffHeight / 63
            let spaceHeight = staffHeight / 9
            VStack {
                StaffRow()
//                                StaffRow(debugStaffRow: .flatflat)
//                                StaffRow(debugStaffRow: .flatsharp)
//                                StaffRow(debugStaffRow: .sharpflat)
//                                StaffRow(debugStaffRow: .sharpsharp)
            }
            .environment(\.staffHeight, staffHeight)
            .environment(\.staffSpace, staffSpace)
            .environment(\.lineHeight, lineHeight)
            .environment(\.spaceHeight, spaceHeight)
        }
    }
}
