//
//  NoteName.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/21/23.
//

import Foundation

enum NoteName: Int {
    case C, D, E, F, G, A, B
    var trebleClefPosition: Int {
        switch self {
        case .C:
            return 0
        case .D:
            return 1
        case .E:
            return 2
        case .F:
            return 3
        case .G:
            return 4
        case .A:
            return 5
        case .B:
            return 6
        }
    }
    var bassClefPosition: Int {
        switch self {
        case .C:
            return -7
        case .D:
            return -6
        case .E:
            return -5
        case .F:
            return -4
        case .G:
            return -3
        case .A:
            return -2
        case .B:
            return -1
        }
    }
    
    func adding(interval: IntervalType) -> NoteName {
        let noteNameValue = (self.rawValue + interval.rawValue) % 7
        switch noteNameValue {
        case 0:
            return .C
        case 1:
            return .D
        case 2:
            return .E
        case 3:
            return .F
        case 4:
            return .G
        case 5:
            return .A
        case 6:
            return .B
        default:
            fatalError("undefined note name distance. pitch should never be outside A-G.")
        }
    }
    
    /// i think this is it!!!
    func chordTone(with accidental: Accidental) -> FixedSolfege {
        switch self {
        case .C:
            switch accidental {
            case .doubleFlat:
                return .Bb
            case .flat:
                return .B
            case .natural:
                return .C
            case .sharp:
                return .Csharp
            case .doubleSharp:
                return .D
            }
        case .D:
            switch accidental {
            case .doubleFlat:
                return .C
            case .flat:
                return .Db
            case .natural:
                return .D
            case .sharp:
                return .Dsharp
            case .doubleSharp:
                return .E
            }
        case .E:
            switch accidental {
            case .doubleFlat:
                return .D
            case .flat:
                return .Eb
            case .natural:
                return .E
            case .sharp:
                return .F
            case .doubleSharp:
                return .Fsharp
            }
        case .F:
            switch accidental {
            case .doubleFlat:
                return .Eb
            case .flat:
                return .E
            case .natural:
                return .F
            case .sharp:
                return .Fsharp
            case .doubleSharp:
                return .G
            }
        case .G:
            switch accidental {
            case .doubleFlat:
                return .F
            case .flat:
                return .Gb
            case .natural:
                return .G
            case .sharp:
                return .Gsharp
            case .doubleSharp:
                return .A
            }
        case .A:
            switch accidental {
            case .doubleFlat:
                return .G
            case .flat:
                return .Ab
            case .natural:
                return .A
            case .sharp:
                return .Asharp
            case .doubleSharp:
                return .B
            }
        case .B:
            switch accidental {
            case .doubleFlat:
                return .A
            case .flat:
                return .Bb
            case .natural:
                return .B
            case .sharp:
                return .C
            case .doubleSharp:
                return .Csharp
            }
        }
    }
    
//    private func adding(intervalTypeValue: Int) -> NoteName {
//        let noteNameValue = (self.rawValue + intervalTypeValue) % 7
//        switch noteNameValue {
//        case 0:
//            return .C
//        case 1:
//            return .D
//        case 2:
//            return .E
//        case 3:
//            return .F
//        case 4:
//            return .G
//        case 5:
//            return .A
//        case 6:
//            return .B
//        default:
//            fatalError("undefined note name distance. pitch should never be outside A-G.")
//        }
//    }
    
    
    
//    static func fromAccidental(_ accidental: Accidental) -> FixedSolfege {
//        let accidentalStyle = AccidentalStyle.from(accidental)
//        switch self {
//        case .C:
//            switch accidentalStyle {
//            case .sharp:
//                <#code#>
//            case .flat:
//                fatalError("c flat not supported")
//            case .natural:
//                <#code#>
//            }
//        case .D:
//            switch accidentalStyle {
//            case .sharp:
//                <#code#>
//            case .flat:
//                <#code#>
//            case .natural:
//                <#code#>
//            }
//        case .E:
//            switch accidentalStyle {
//            case .sharp:
//                fatalError("e sharp not supported")
//            case .flat:
//                <#code#>
//            case .natural:
//                <#code#>
//            }
//        case .F:
//            switch accidentalStyle {
//            case .sharp:
//                <#code#>
//            case .flat:
//                fatalError("f flat not supported")
//            case .natural:
//                <#code#>
//            }
//        case .G:
//            switch accidentalStyle {
//            case .sharp:
//                <#code#>
//            case .flat:
//                <#code#>
//            case .natural:
//                <#code#>
//            }
//        case .A:
//            switch accidentalStyle {
//            case .sharp:
//                <#code#>
//            case .flat:
//                <#code#>
//            case .natural:
//                <#code#>
//            }
//        case .B:
//            switch accidentalStyle {
//            case .sharp:
//                fatalError("b sharp not supported")
//            case .flat:
//                <#code#>
//            case .natural:
//                <#code#>
//            }
//        }
//    }
}
extension NoteName {
    static func += (lhs: inout Self, rhs: Self) {
        
    }
}
