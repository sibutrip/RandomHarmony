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
            
            // (Int,[Pitch]) is (numberOfGoodDistances, sequence)
            let remainingPitchesPermutations = pitches.permutations()
            let remainingPitches = remainingPitchesPermutations
                .reduce((numberOfGoodDistances: Int.min, pitches: [Pitch]())) { partialResult, pitches in
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
            
            var totalAccidentalOffset = Double() // if accidentals are stacked, next non-stacked note should have its spacing determined by the closest note to it.
            var stackedAccidentals = [Pitch]()
            let accidentalChordFormats: [AccidentalChordFormat] = accidentalPitches.enumerated().map { index, accidentalPitch in
                if index > 0 {
                    let previousAccidentalPitch = accidentalPitches[index - 1]
                    let closestPreviousAccidental = stackedAccidentals + [previousAccidentalPitch]
                    let staffDistance = closestPreviousAccidental.reduce(Int.max) { lastDistance, pitch in
                        let newDistance = abs(accidentalPitch.staffOrder - pitch.staffOrder)
                        return min(lastDistance,newDistance)
                    }
                    if staffDistance >= 6 {
                        stackedAccidentals.append(previousAccidentalPitch)
                    }
                    let accidentalOffset = Self.xOffset(accidentalPitch: accidentalPitch.fixedSolfege.accidental, lastPitch: previousAccidentalPitch.fixedSolfege.accidental, staffDistance: staffDistance)
                    totalAccidentalOffset += accidentalOffset
                    return AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: totalAccidentalOffset)
                } else {
                    totalAccidentalOffset += 1.7
                    return AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: 1.7)
                }
            }
            return accidentalChordFormats
        }
        
        /// sharps and flats only. fatal error on any other Accidental
        static func xOffset(accidentalPitch: Accidental, lastPitch: Accidental, staffDistance: Int) -> CGFloat {
            let lastAccidentalSpacing: CGFloat = switch lastPitch {
            case .doubleFlat:
                fatalError()
            case .flat:
                switch staffDistance {
                case 0:
                    fatalError("unison accidentals not handled yet")
                case 1:
                    1.1
                case 2:
                    1.1
                case 3:
                    0.8
                case 4:
                    0.6
                case 5...Int.max:
                    0.0
                default:
                    fatalError("should not have interval outside of 0...Int.max")
                }
            case .natural:
                fatalError()
            case .sharp:
                switch staffDistance {
                case 0:
                    fatalError("unison accidentals not handled yet")
                case 1:
                    1.3
                case 2:
                    1.3
                case 3:
                    1.3
                case 4:
                    0.8
                case 5:
                    0.5
                case 6:
                    0.3
                case 7...Int.max:
                    0.0
                default:
                    fatalError("should not have interval outside of 0...Int.max")
                }
            case .doubleSharp:
                fatalError()
            }
            
            let currentAccidentalSpacing: CGFloat  = switch accidentalPitch {
            case .doubleFlat:
                fatalError()
            case .flat:
                0
            case .natural:
                fatalError()
            case .sharp:
                if lastPitch == .flat {
                    switch staffDistance {
                    case 1...3:
                        0.3
                    case 4:
                        0.1
                    default:
                        0
                    }
                } else if lastPitch == .sharp {
                    switch staffDistance {
                    case 4...5:
                        0.3
                    case 6:
                        -0.3
                    default:
                        0
                    }
                } else {
                    0.0
                }
            case .doubleSharp:
                fatalError()
            }
            return lastAccidentalSpacing + currentAccidentalSpacing
        }
    }
}

//switch staffDistance {
//case 0:
//    fatalError("unison accidentals not handled yet")
//case 1:
//    1.1
//case 2:
//    1.0
//case 3:
//    0.9
//case 4:
//    0.7
//case 5...Int.max:
//    0.0
//default:
//    fatalError("should not have interval outside of 0...Int.max")
//}

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
                StaffRow(debugStaffRow: .flatflat)
                StaffRow(debugStaffRow: .flatsharp)
                StaffRow(debugStaffRow: .sharpflat)
                StaffRow(debugStaffRow: .sharpsharp)
            }
                .environment(\.staffHeight, staffHeight)
                .environment(\.staffSpace, staffSpace)
                .environment(\.lineHeight, lineHeight)
                .environment(\.spaceHeight, spaceHeight)
        }
    }
}
