//
//  NotationComponent.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/29/23.
//

enum NotationComponent {
    case flat, sharp, natural
    var name: String {
        switch self {
        case .flat:
            "\u{266D}"
        case .sharp:
            "\u{266F}"
        case .natural:
            "\u{266E}"
        }
    }
}
