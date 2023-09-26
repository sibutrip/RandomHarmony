//
//  Accidental.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum Accidental: Int {
    case doubleFlat, flat, natural, sharp, doubleSharp
    var addingFlat: Accidental {
        switch self {
        case .doubleFlat:
            fatalError("triple flats not supported")
        case .flat:
            return .doubleFlat
        case .natural:
            return .flat
        case .sharp:
            return .natural
        case .doubleSharp:
            return .sharp
        }
    }
    var addingSharp: Accidental {
        switch self {
        case .doubleFlat:
            return .flat
        case .flat:
            return .natural
        case .natural:
            return .sharp
        case .sharp:
            return .doubleSharp
        case .doubleSharp:
            fatalError("triple sharps not supported")
        }
    }
}

enum AccidentalStyle {
    case sharp, flat, natural
    static func from(_ accidental: Accidental) -> AccidentalStyle {
        switch accidental {
        case .doubleFlat, .doubleSharp:
            fatalError("double flat/sharp roots not supported")
        case .flat:
            return .flat
        case .natural:
            return .natural
        case .sharp:
            return .sharp
        }
    }
}
