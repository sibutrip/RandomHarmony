//
//  Keyboard.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/27/23.
//

import SwiftUI

enum KeyboardButtonStyle {
    case notSelected, selected, disabled
}

struct Keyboard: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var keypadSize = CGSize.zero
    @State private var selectedChord = InputChord()
    var body: some View {
        ZStack {
            Color("list.background")
            VStack {
                Spacer()
                Text(selectedChord.raw)
                    .foregroundStyle(Color.red)
                Spacer()
                HStack {
                    ForEach(NoteName.allCases) { noteName in
                        let keyboardButtonStyle: KeyboardButtonStyle = selectedChord.noteName == noteName ? .selected : .notSelected
                        ChildSizeReader(size: $keypadSize) {
                            Button {
                                selectedChord.noteName = noteName
                            } label: {
                                Text(noteName.description)
                            }
                        }
                        .keyboardStyle(keyboardButtonStyle: keyboardButtonStyle)
                    }
                }
                HStack {
                    Spacer()
                    ForEach(AccidentalStyle.allCases) { accidental in
                        Button {
                            selectedChord.accidental = accidental
                        } label: {Image(accidental.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: keypadSize.width,maxHeight:keypadSize.height)
                                .keyboardStyle(keyboardButtonStyle: .notSelected)
                        }
                        
                    }
                    Text(TriadQuality.major.rawValue)
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                    Text(TriadQuality.minor.rawValue)
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                    Spacer()
                }
                HStack {
                    Text(TriadQuality.diminished.rawValue)
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                    Text(TriadQuality.augmented.rawValue)
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                    Text(TriadQuality.sus.rawValue)
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                }
                HStack {
                    HStack(alignment: .top, spacing: 0) {
                        Image("flat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: keypadSize.width * 0.5)
                        Text("7")
                    }
                    .keyboardStyle(keyboardButtonStyle: .notSelected)
                    Text("7")
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                    HStack(spacing: 1) {
                        Image("sharp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: keypadSize.width * 0.5)
                        Text("7")
                    }
                    .keyboardStyle(keyboardButtonStyle: .notSelected)
                    HStack(alignment: .top, spacing: 0) {
                        Image("flat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: keypadSize.width * 0.5)
                        Text("9")
                    }
                    .keyboardStyle(keyboardButtonStyle: .notSelected)
                    Text("9")
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                    HStack(spacing: 1) {
                        Image("sharp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: keypadSize.width * 0.5)
                        Text("9")
                    }
                    .keyboardStyle(keyboardButtonStyle: .notSelected)
                }
                HStack {
                    HStack(alignment: .top, spacing: 0) {
                        Image("flat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: keypadSize.width * 0.5)
                        Text("13")
                    }
                    .keyboardStyle(keyboardButtonStyle: .notSelected)
                    Text("13")
                        .keyboardStyle(keyboardButtonStyle: .notSelected)
                    HStack(spacing: 1) {
                        Image("sharp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: keypadSize.width * 0.5)
                        Text("13")
                    }
                    .keyboardStyle(keyboardButtonStyle: .notSelected)
                }
            }
        }
    }
}

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
    func keyboardStyle(keyboardButtonStyle: KeyboardButtonStyle) -> some View {
        ModifiedContent(content: self, modifier: KeyboardStyle(keyboardButtonStyle: keyboardButtonStyle))
    }
}

#Preview {
    Keyboard()
}
