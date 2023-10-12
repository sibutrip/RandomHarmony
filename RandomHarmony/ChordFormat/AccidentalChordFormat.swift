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
            var accidentalChordFormats = [AccidentalChordFormat]()
            accidentalPitches.enumerated().forEach { index, accidentalPitch in
                if index > 0 {
                    let previousAccidentalPitch = accidentalPitches[index - 1]
                    let closestPreviousAccidental = stackedAccidentals + [previousAccidentalPitch]
                    let firstAccidentalClusterDistance = stackedAccidentals.reduce(Int.max) { lastDistance, pitch in
                        let distance = min(lastDistance, abs(accidentalPitch.staffOrder - pitch.staffOrder))
                        return distance
                    }
                    let staffDistance = closestPreviousAccidental.reduce(Int.max) { lastDistance, pitch in
                        let newDistance = abs(accidentalPitch.staffOrder - pitch.staffOrder)
                        return min(lastDistance,newDistance)
                    }
                    if firstAccidentalClusterDistance >= 5 {
                        stackedAccidentals.append(accidentalPitch)
                        accidentalChordFormats.insert(AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: 1.7), at: 1)
                    } else {
                        let accidentalOffset = Self.xOffset(accidentalPitch: accidentalPitch.fixedSolfege.accidental, lastPitch: previousAccidentalPitch.fixedSolfege.accidental, staffDistance: staffDistance)
                        totalAccidentalOffset += accidentalOffset
                        accidentalChordFormats.append(AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: totalAccidentalOffset))
                    }
                } else {
                    totalAccidentalOffset += 1.7
                    accidentalChordFormats.append(AccidentalChordFormat(pitch: accidentalPitch, offsetMultiplier: 1.7))
                    stackedAccidentals.append(accidentalPitch)
                }
            }
            return accidentalChordFormats
        }
        
        /// sharps and flats only. fatal error on any other Accidental
        private static func xOffset(accidentalPitch: Accidental, lastPitch: Accidental, staffDistance: Int) -> CGFloat {
            switch accidentalPitch {
            case .doubleFlat:
                fatalError("not supported yet")
            case .flat:
                switch lastPitch {
                case .doubleFlat:
                    fatalError("not supported yet")
                case .flat:
                    return flatAfterFlat(staffDistance: staffDistance)
                case .natural:
                    fatalError("not supported yet")
                case .sharp:
                    return flatAfterSharp(staffDistance: staffDistance)
                case .doubleSharp:
                    fatalError("not supported yet")
                }
            case .natural:
                fatalError("not supported yet")
            case .sharp:
                switch lastPitch {
                case .doubleFlat:
                    fatalError("not supported yet")
                case .flat:
                    return sharpAfterFlat(staffDistance: staffDistance)
                case .natural:
                    fatalError("not supported yet")
                case .sharp:
                    return sharpAfterSharp(staffDistance: staffDistance)
                case .doubleSharp:
                    fatalError("not supported yet")
                }
            case .doubleSharp:
                fatalError("not supported yet")
            }
            return 0
        }
        
        
        /// previous note is a flat. following note is a flat
        private static func flatAfterFlat(staffDistance: Int) -> CGFloat {
            switch staffDistance {
            case 0:
                fatalError("unisons not handled yet")
            case 1:
                return 1.1
            case 2:
                return 1.1
            case 3:
                return 0.7
            case 4:
                return 0.7
            case 5:
                return 0.4
            case 6:
                return 0
            case 7...Int.max:
                return 0
            default:
                fatalError("staff distance should not be outside of this range (0...Int.max)")
            }
        }
        /// previous note is a sharp. following note is a flat
        private static func flatAfterSharp(staffDistance: Int) -> CGFloat {
            switch staffDistance {
            case 0:
                fatalError("unisons not handled yet")
            case 1:
                return 1.2
            case 2:
                return 1.2
            case 3:
                return 1.1
            case 4:
                return 0.7
            case 5:
                return 0.6
            case 6:
                return 0.4
            case 7...Int.max:
                return 0
            default:
                fatalError("staff distance should not be outside of this range (0...Int.max)")
            }
        }
        
        /// previous note is a flat. following note is a sharp
        private static func sharpAfterFlat(staffDistance: Int) -> CGFloat {
            switch staffDistance {
            case 0:
                fatalError("unisons not handled yet")
            case 1:
                return 1.2
            case 2:
                return 1.2
            case 3:
                return 1.1
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7...Int.max:
                return 0
            default:
                fatalError("staff distance should not be outside of this range (0...Int.max)")
            }
        }
        
        /// previous note is a sharp. following note is a flat
        private static func sharpAfterSharp(staffDistance: Int) -> CGFloat {
            switch staffDistance {
            case 0:
                fatalError("unisons not handled yet")
            case 1:
                return 1.25
            case 2:
                return 1.25
            case 3:
                return 1.25
            case 4:
                return 1.1
            case 5:
                return 1
            case 6:
                return 0
            case 7...Int.max:
                return 0
            default:
                fatalError("staff distance should not be outside of this range (0...Int.max)")
            }
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
                StaffRow()
//                StaffRow(debugStaffRow: .flatflat)
//                StaffRow(debugStaffRow: .flatsharp)
//                StaffRow(debugStaffRow: .sharpflat)
//                StaffRow(debugStaffRow: .sharpsharp)
            }
            .environment(\.staffHeight, staffHeight)
            .environment(\.staffSpace, staffSpace)
            .environment(\.lineHeight, lineHeight)
            .environment(\.spaceHeight, spaceHeight)
        }
    }
}
