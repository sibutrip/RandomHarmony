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
    
    func chordTone(with accidental: Accidental) -> FixedSolfege {
        switch self {
        case .C:
            switch accidental {
            case .doubleFlat:
                return .Cbb
            case .flat:
                return .Cb
            case .natural:
                return .C
            case .sharp:
                return .Csharp
            case .doubleSharp:
                return .CdoubleSharp
            }
        case .D:
            switch accidental {
            case .doubleFlat:
                return .Dbb
            case .flat:
                return .Db
            case .natural:
                return .D
            case .sharp:
                return .Dsharp
            case .doubleSharp:
                return .DdoubleSharp
            }
        case .E:
            switch accidental {
            case .doubleFlat:
                return .Ebb
            case .flat:
                return .Eb
            case .natural:
                return .E
            case .sharp:
                return .Esharp
            case .doubleSharp:
                return .EdoubleSharp
            }
        case .F:
            switch accidental {
            case .doubleFlat:
                return .Fbb
            case .flat:
                return .Fb
            case .natural:
                return .F
            case .sharp:
                return .Fsharp
            case .doubleSharp:
                return .FdoubleSharp
            }
        case .G:
            switch accidental {
            case .doubleFlat:
                return .Gbb
            case .flat:
                return .Gb
            case .natural:
                return .G
            case .sharp:
                return .Gsharp
            case .doubleSharp:
                return .GdoubleSharp
            }
        case .A:
            switch accidental {
            case .doubleFlat:
                return .Abb
            case .flat:
                return .Ab
            case .natural:
                return .A
            case .sharp:
                return .Asharp
            case .doubleSharp:
                return .AdoubleSharp
            }
        case .B:
            switch accidental {
            case .doubleFlat:
                return .Bbb
            case .flat:
                return .Bb
            case .natural:
                return .B
            case .sharp:
                return .Bsharp
            case .doubleSharp:
                return .BdoubleSharp
            }
        }
    }
}
