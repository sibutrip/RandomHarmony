//
//  StaffDistance.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/13/23.
//

import Foundation
import SwiftUI

enum IntervalDirection {
    enum AccidentalInterval: Int {
        case unison, second, third, fourth, fifth, sixth, seventh, greaterThanSeventh
        fileprivate static func from(_ staffDistance: Int) -> AccidentalInterval {
            let staffDistance = abs(staffDistance)
            return switch staffDistance {
            case 0:
                    .unison
            case 1:
                    .second
            case 2:
                    .third
            case 3:
                    .fourth
            case 4:
                    .fifth
            case 5:
                    .sixth
            case 6:
                    .seventh
            case 7...Int.max:
                    .greaterThanSeventh
            default:
                fatalError("should not be calculating interval from negative int value")
            }
        }
        
        private func descendingOffset(from previousAccidental: Accidental, to currentAccidental: Accidental) -> CGFloat {
            switch previousAccidental {
            case .doubleFlat:
                fatalError("not handled yet")
            case .flat:
                switch currentAccidental {
                case .doubleFlat:
                    fatalError("not handled yet")
                case .flat:
                    return descendingFlatToFlat()
                case .natural:
                    fatalError("not handled yet")
                case .sharp:
                    return descendingFlatToSharp()
                case .doubleSharp:
                    fatalError("not handled yet")
                }
            case .natural:
                fatalError("not handled yet")
            case .sharp:
                switch currentAccidental {
                case .doubleFlat:
                    fatalError("not handled yet")
                case .flat:
                    return descendingSharpToFlat()
                case .natural:
                    fatalError("not handled yet")
                case .sharp:
                    return descendingSharpToSharp()
                case .doubleSharp:
                    fatalError("not handled yet")
                }
            case .doubleSharp:
                fatalError("not handled yet")
            }
        }
        private func ascendingOffset(from previousAccidental: Accidental, to currentAccidental: Accidental) -> CGFloat {
            switch previousAccidental {
            case .doubleFlat:
                fatalError("not handled yet")
            case .flat:
                switch currentAccidental {
                case .doubleFlat:
                    fatalError("not handled yet")
                case .flat:
                    ascendingFlatToFlat()
                case .natural:
                    fatalError("not handled yet")
                case .sharp:
                    ascendingFlatToSharp()
                case .doubleSharp:
                    fatalError("not handled yet")
                }
            case .natural:
                fatalError("not handled yet")
            case .sharp:
                switch currentAccidental {
                case .doubleFlat:
                    fatalError("not handled yet")
                case .flat:
                    ascendingSharpToFlat()
                case .natural:
                    fatalError("not handled yet")
                case .sharp:
                    ascendingSharpToSharp()
                case .doubleSharp:
                    fatalError("not handled yet")
                }
            case .doubleSharp:
                fatalError("not handled yet")
            }
        }
        
        private func descendingFlatToFlat() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.1
            case .third:
                1.1
            case .fourth:
                0.7
            case .fifth:
                0.7
            case .sixth:
                0.4
            case .seventh:
                0
            case .greaterThanSeventh:
                0
            }
        }
        
        private func descendingFlatToSharp() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.2
            case .third:
                1.2
            case .fourth:
                1.1
            case .fifth:
                1.1
            case .sixth:
                1.1
            case .seventh:
                1.1
            case .greaterThanSeventh:
                0
            }
        }
        
        private func descendingSharpToFlat() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.2
            case .third:
                1.2
            case .fourth:
                1.5
            case .fifth:
                0.7
            case .sixth:
                0.6
            case .seventh:
                0.4
            case .greaterThanSeventh:
                0
            }
        }
        
        private func descendingSharpToSharp() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.25
            case .third:
                1.25
            case .fourth:
                1.25
            case .fifth:
                1.1
            case .sixth:
                1
            case .seventh:
                0
            case .greaterThanSeventh:
                0
            }
        }
        
        private func ascendingFlatToFlat() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.2
            case .third:
                1.2
            case .fourth:
                1.1
            case .fifth:
                1.0
            case .sixth:
                0.6
            case .seventh:
                0.4
            case .greaterThanSeventh:
                0
            }
        }
        
        private func ascendingFlatToSharp() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.2
            case .third:
                1.2
            case .fourth:
                1.1
            case .fifth:
                1.1
            case .sixth:
                1.1
            case .seventh:
                1.1
            case .greaterThanSeventh:
                0
            }
        }
        
        private func ascendingSharpToFlat() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.2
            case .third:
                1.2
            case .fourth:
                1.1
            case .fifth:
                0.7
            case .sixth:
                0.6
            case .seventh:
                0.4
            case .greaterThanSeventh:
                0
            }
        }
        
        private func ascendingSharpToSharp() -> CGFloat {
            switch self {
            case .unison:
                fatalError("unisons not handled yet")
            case .second:
                1.25
            case .third:
                1.25
            case .fourth:
                1.25
            case .fifth:
                1.1
            case .sixth:
                1
            case .seventh:
                0
            case .greaterThanSeventh:
                0
            }
        }
        
        
        fileprivate func offset(from previousAccidental: Accidental, to currentAccidental: Accidental, in direction: IntervalDirection) -> CGFloat {
            switch direction {
            case .ascending(let intervalType):
                intervalType.ascendingOffset(from: previousAccidental, to: currentAccidental)
            case .descending(let intervalType):
                intervalType.descendingOffset(from: previousAccidental, to: currentAccidental)
            }
        }
    }
    
    case ascending(AccidentalInterval)
    case descending(AccidentalInterval)
    
    public static func offset(from firstAccidental: Accidental, to currentAccidental: Accidental, over staffDistance: Int) -> CGFloat {
        let interval = IntervalDirection.AccidentalInterval.from(staffDistance)
        let direction: IntervalDirection = staffDistance > 0 ? .ascending(interval) : .descending(interval)
        let distance = interval.offset(from: firstAccidental, to: currentAccidental, in: direction)
        return distance
    }
}

struct IntervalDirection_Previews: PreviewProvider {
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
