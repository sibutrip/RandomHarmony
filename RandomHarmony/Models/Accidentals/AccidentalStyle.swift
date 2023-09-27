//
//  AccidentalStyle.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/27/23.
//

import Foundation

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
