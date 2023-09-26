//
//  Solfege.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/25/23.
//

import Foundation

enum IntervalType: Int {
    case unison, second, third, fourth, fifth, sixth, seventh
}

enum Interval {
    case unison, augmentedUnison, minorSecond, majorSecond, augmentedSecond, minorThird, majorThird, perfectFouth, augmentedFourth, diminishedFifth, perfectFifth, augmentedFifth, minorSixth, majorSixth, diminishedSeventh, minorSeventh, majorSeventh
}

enum FixedSolfege: String {
    case C, Csharp, Db, D, Dsharp, Eb, E, F, Fsharp, Gb, G, Gsharp, Ab, A, Asharp, Bb, B
    
    var noteName: NoteName {
        switch self {
        case .C, .Csharp:
            return .C
        case .Db, .D, .Dsharp:
            return .D
        case .Eb, .E:
            return .E
        case .F, .Fsharp:
            return .F
        case .Gb, .G, .Gsharp:
            return .G
        case .Ab, .A, .Asharp:
            return .A
        case .Bb, .B:
            return .B
        }
    }
    
//    static func from(noteName: NoteName, with accidentalStyle: AccidentalStyle) -> FixedSolfege {
//        return FixedSolfege.A
//    }
    
    static func from(root: PitchClass, with accidentalStyle: AccidentalStyle) -> FixedSolfege {
        switch accidentalStyle {
        case .sharp:
            switch root {
            case .one:
                return .Csharp
            case .three:
                return .Dsharp
            case .six:
                return .Fsharp
            case .eight:
                return .Gsharp
            case .ten:
                return .Asharp
            default:
                break
            }
        case .flat:
            switch root {
            case .one:
                return .Db
            case .three:
                return .Eb
            case .six:
                return .Gb
            case .eight:
                return .Ab
            case .ten:
                return .Bb
            default:
                break
            }
        case .natural:
            switch root {
            case .zero:
                return .C
            case .two:
                return .D
            case .four:
                return .E
            case .five:
                return .F
            case .seven:
                return .G
            case .nine:
                return .A
            case .eleven:
                return .B
            default:
                break
            }
        }
        fatalError("PitchClass and AccidentalStyle when making FixedSolfege")
    }
}
