//
//  Accidental.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum Accidental {
    case doubleFlat, flat, natural, sharp, doubleSharp
//    static let selectable: [Accidental] = [
//        .flat,
//        .natural,
//        .sharp
//    ]
    var iconName: String {
        switch self {
        case .doubleFlat:
            return "double.flat"
        case .flat:
            return "flat"
        case .natural:
            return "natural"
        case .sharp:
            return "sharp"
        case .doubleSharp:
            return "doubleSharp"
        }
    }
    var iconScale: CGSize {
        switch self {
        case .doubleFlat:
            return CGSize(width: 10, height: 17)
        case .flat:
            return CGSize(width: 6, height: 16)
        case .natural:
            return CGSize(width: 5, height: 19)
        case .sharp:
            return CGSize(width: 7, height: 19)
        case .doubleSharp:
            return CGSize(width: 7, height: 7)
        }
    }
    var rawValue: Int {
        switch self {
        case .doubleFlat:
            return -2
        case .flat:
            return -1
        case .natural:
            return 0
        case .sharp:
            return 1
        case .doubleSharp:
            return 2
        }
    }
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
    
    var addingTwoFlats: Accidental {
        switch self {
        case .doubleFlat, .flat:
            fatalError("triple and quadruple flats not supported")
        case .natural:
            return .doubleFlat
        case .sharp:
            return .flat
        case .doubleSharp:
            return .natural
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

extension Accidental: Identifiable {
    var id: Int {
        self.rawValue
    }
}
