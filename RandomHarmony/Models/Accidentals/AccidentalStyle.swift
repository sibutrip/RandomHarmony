//
//  AccidentalStyle.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/27/23.
//

import Foundation

enum AccidentalStyle: String, CaseIterable {
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
    var iconName: String {
        switch self {
        case .flat:
            return "flat"
        case .natural:
            return "natural"
        case .sharp:
            return "sharp"
        }
    }
    var iconScale: CGSize {
        switch self {
        case .flat:
            return CGSize(width: 6, height: 16)
        case .natural:
            return CGSize(width: 5, height: 19)
        case .sharp:
            return CGSize(width: 7, height: 19)
        }
    }
}

extension AccidentalStyle: Identifiable {
    var id: String {
        self.rawValue
    }
}
