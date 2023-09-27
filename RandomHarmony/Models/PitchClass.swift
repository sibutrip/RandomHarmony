//
//  PitchClass.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/21/23.
//

import Foundation

enum PitchClass: CaseIterable {
    case zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven
//    func fixedSolfege(as accidentalStyle: AccidentalStyle) -> FixedSolfege {
//        switch accidentalStyle {
//        case .sharp:
//            switch self {
//            case .one:
//                return .Csharp
//            case .three:
//                return .Dsharp
//            case .six:
//                return .Fsharp
//            case .eight:
//                return .Gsharp
//            case .ten:
//                return .Asharp
//            default:
//                break
//            }
//        case .flat:
//            switch self {
//            case .one:
//                return .Db
//            case .three:
//                return .Eb
//            case .six:
//                return .Gb
//            case .eight:
//                return .Ab
//            case .ten:
//                return .Bb
//            default:
//                break
//            }
//        case .natural:
//            switch self {
//            case .zero:
//                return .C
//            case .two:
//                return .D
//            case .four:
//                return .E
//            case .five:
//                return .F
//            case .seven:
//                return .G
//            case .nine:
//                return .A
//            case .eleven:
//                return .B
//            default:
//                break
//            }
//        }
//        fatalError("unexpected case")
//    }
    
    var sharpScale: Scale {
        switch self {
        case .zero:
            Scale.C
        case .one:
            Scale.Csharp
        case .two:
            Scale.D
        case .three:
            Scale.Dsharp
        case .four:
            Scale.E
        case .five:
            Scale.F
        case .six:
            Scale.Fsharp
        case .seven:
            Scale.G
        case .eight:
            Scale.Gsharp
        case .nine:
            Scale.A
        case .ten:
            Scale.Asharp
        case .eleven:
            Scale.B
        }
    }
    
    var flatScale: Scale {
        switch self {
        case .zero:
            Scale.C
        case .one:
            Scale.Db
        case .two:
            Scale.D
        case .three:
            Scale.Eb
        case .four:
            Scale.E
        case .five:
            Scale.F
        case .six:
            Scale.Gb
        case .seven:
            Scale.G
        case .eight:
            Scale.Ab
        case .nine:
            Scale.A
        case .ten:
            Scale.Bb
        case .eleven:
            Scale.B
        }
    }
    
    func chord(triad: TriadQuality, seventh: SeventhQuality? = nil, upperExtensions: [UpperExtension]? = nil) -> (root: FixedSolfege, harmonies: Set<FixedSolfege>) {
        let solfeges = Set(
            (triad.pitchClasses
             + [(seventh?.pitchClass)]
             + (upperExtensions?.map { $0.pitchClass } ?? []))
        ) .compactMap { $0 }
        let scale = selectFlatOrSharpScale(in: solfeges)
        return scale.chord(triad: triad, seventh: seventh, upperExtensions: upperExtensions)
    }
    
    func selectFlatOrSharpScale(in solfeges: [Interval]) -> Scale {
        let sharpPreference = self.sharpScale.preferredAccidentalStyle(with: solfeges)
        let flatPreference = self.flatScale.preferredAccidentalStyle(with: solfeges)
        print("sharp preference: \(sharpPreference), flat preference: \(flatPreference)")
        /// select scale with less accidentals
        if abs(sharpPreference) < abs(flatPreference) {
            return self.sharpScale
        } else {
            return self.flatScale
        }
    }
}
