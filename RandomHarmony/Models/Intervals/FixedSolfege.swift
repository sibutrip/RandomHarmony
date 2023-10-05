//
//  FixedSolfege.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/27/23.
//

import Foundation

enum FixedSolfege: String, CaseIterable {
    case Cbb, Cb, C, Csharp, CdoubleSharp,
         Dbb, Db, D, Dsharp, DdoubleSharp,
         Ebb, Eb, E, Esharp, EdoubleSharp,
         Fbb, Fb, F, Fsharp, FdoubleSharp,
         Gbb, Gb, G, Gsharp, GdoubleSharp,
         Abb, Ab, A, Asharp, AdoubleSharp,
         Bbb, Bb, B, Bsharp, BdoubleSharp
    
    var pitchClass: Int {
        switch self {
        case .C, .Dbb, .Bsharp:
            return 0
        case .Csharp, .Db, .BdoubleSharp:
            return 1
        case .D, .CdoubleSharp, .Ebb:
            return 2
        case .Dsharp, .Eb, .Fbb:
            return 3
        case .E, .DdoubleSharp, .Fb:
            return 4
        case .F, .Esharp, .Gbb:
            return 5
        case .Fsharp, .Gb, .EdoubleSharp:
            return 6
        case .G, .FdoubleSharp, .Abb:
            return 7
        case .Gsharp, .Ab:
            return 8
        case .A, .GdoubleSharp, .Bbb:
            return 9
        case .Asharp, .Bb, .Cbb:
            return 10
        case .B, .Cb, .AdoubleSharp:
            return 11
        }
    }
    
    var accidental: Accidental {
        switch self {
        case .Cbb,.Dbb,.Ebb,.Fbb,.Gbb,.Abb,.Bbb:
            return .doubleSharp
        case .CdoubleSharp,.DdoubleSharp,.EdoubleSharp,.FdoubleSharp,.GdoubleSharp,.AdoubleSharp,.BdoubleSharp:
            return .doubleSharp
        case .Csharp,.Dsharp,.Esharp,.Fsharp,.Gsharp,.Asharp,.Bsharp:
            return .sharp
        case .Cb, .Db,.Eb,.Fb,.Gb,.Ab,.Bb:
            return .flat
        case .C,.D,.E,.F,.G,.A,.B:
            return .natural
        }
    }
    
    var noteName: NoteName {
        switch self {
        case .Cbb, .Cb, .C, .Csharp, .CdoubleSharp:
            return .C
        case .Dbb, .Db, .D, .Dsharp, .DdoubleSharp:
            return .D
        case .Ebb, .Eb, .E, .Esharp, .EdoubleSharp:
            return .E
        case .Fbb, .Fb, .F, .Fsharp, .FdoubleSharp:
            return .F
        case .Gbb, .Gb, .G, .Gsharp, .GdoubleSharp:
            return .G
        case .Abb, .Ab, .A, .Asharp, .AdoubleSharp:
            return .A
        case .Bbb, .Bb, .B, .Bsharp, .BdoubleSharp:
            return .B
        }
    }
    
    static func from(root: PitchClass, with accidental: Accidental) -> FixedSolfege {
        switch accidental {
        case .sharp:
            switch root {
            case .zero:
                return .Bsharp
            case .one:
                return .Csharp
            case .three:
                return .Dsharp
            case .five:
                return .Esharp
            case .six:
                return .Fsharp
            case .eight:
                return .Gsharp
            case .ten:
                return .Asharp
            default:
                fatalError("sharp not found")
            }
        case .flat:
            switch root {
            case .one:
                return .Db
            case .three:
                return .Eb
            case .four:
                return .Fb
            case .six:
                return .Gb
            case .eight:
                return .Ab
            case .ten:
                return .Bb
            case .eleven:
                return .Cb
            default:
                fatalError("flat not found")
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
                fatalError("natural not found")
            }
        case .doubleFlat:
            switch root {
            case .zero:
                return .Dbb
            case .two:
                return .Ebb
            case .three:
                return .Fbb
            case .five:
                return .Gbb
            case .seven:
                return .Abb
            case .nine:
                return .Bbb
            case .ten:
                return .Cbb
            default:
                fatalError("double flat not found")
            }
        case .doubleSharp:
            switch root {
            case .one:
                return .BdoubleSharp
            case .two:
                return .CdoubleSharp
            case .four:
                return .DdoubleSharp
            case .six:
                return .EdoubleSharp
            case .seven:
                return .FdoubleSharp
            case .nine:
                return .GdoubleSharp
            case .eleven:
                return .AdoubleSharp
            default:
                fatalError("double sharp not found")
            }
        }
    }
    var order: Int {
        switch self {
        case .Cbb:
            0
        case .Cb:
            1
        case .C:
            2
        case .Csharp:
            3
        case .CdoubleSharp:
            4
        case .Dbb:
            5
        case .Db:
            6
        case .D:
            7
        case .Dsharp:
            8
        case .DdoubleSharp:
            9
        case .Ebb:
            10
        case .Eb:
            11
        case .E:
            12
        case .Esharp:
            13
        case .EdoubleSharp:
            14
        case .Fbb:
            15
        case .Fb:
            16
        case .F:
            17
        case .Fsharp:
            18
        case .FdoubleSharp:
            19
        case .Gbb:
            20
        case .Gb:
            21
        case .G:
            22
        case .Gsharp:
            23
        case .GdoubleSharp:
            24
        case .Abb:
            25
        case .Ab:
            26
        case .A:
            27
        case .Asharp:
            28
        case .AdoubleSharp:
            29
        case .Bbb:
            30
        case .Bb:
            31
        case .B:
            32
        case .Bsharp:
            33
        case .BdoubleSharp:
            34
        }
    }
}
