//
//  KeyboardStyle.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/28/23.
//

import SwiftUI

struct KeyboardStyle: ViewModifier {
    let keyboardButtonStyle: KeyboardButtonStyle
    let backgroundColor: Color
    let textColor: Color
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding(15)
            .foregroundStyle(textColor)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(backgroundColor)
                    .shadow(color: .black, radius: 1, x: 0, y: 0.3)
            }
            .animation(.easeInOut.speed(2), value: keyboardButtonStyle)
    }
    init(keyboardButtonStyle: KeyboardButtonStyle) {
        let colorScheme = UIScreen.main.traitCollection.userInterfaceStyle
        self.keyboardButtonStyle = keyboardButtonStyle
        var textColor: Color {
            switch colorScheme {
            case .light, .unspecified:
                switch keyboardButtonStyle {
                case .notSelected:
                    return Color.black
                case .selected:
                    return Color.white
                case .disabled:
                    return .gray
                }
            case .dark:
                switch keyboardButtonStyle {
                case .notSelected:
                    return Color.white
                case .selected:
                    return Color.black
                case .disabled:
                    return .gray
                }
            @unknown default:
                switch keyboardButtonStyle {
                case .notSelected:
                    return Color.black
                case .selected:
                    return Color.white
                case .disabled:
                    return .gray
                }
            }
        }
        var backgroundColor: Color {
            switch colorScheme {
            case .light, .unspecified:
                switch keyboardButtonStyle {
                case .notSelected:
                    return Color.white
                case .selected:
                    return Color.black
                case .disabled:
                    return .white
                }
            case .dark:
                switch keyboardButtonStyle {
                case .notSelected:
                    return Color.black
                case .selected:
                    return Color.white
                case .disabled:
                    return .black
                }
                // default to light mode
            @unknown default:
                switch keyboardButtonStyle {
                case .notSelected:
                    return Color.black
                case .selected:
                    return Color.white
                case .disabled:
                    return .gray
                }
            }
        }
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}

extension View {
    func keyboardStyle(_ keyboardButtonStyle: KeyboardButtonStyle) -> some View {
        ModifiedContent(content: self, modifier: KeyboardStyle(keyboardButtonStyle: keyboardButtonStyle))
    }
}
