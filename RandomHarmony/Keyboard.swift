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
                        noteNameButton(noteName)
                    }
                }
                HStack {
                    ForEach(AccidentalStyle.allCases) { accidental in
                        accidentalButton(accidental)
                    }
                    triadButton(.major)
                    triadButton(.minor)
                }
                HStack {
                    triadButton(.diminished)
                    triadButton(.augmented)
                    triadButton(.sus)
                    
                }
                HStack {
                    seventhButton(.diminished)
                    seventhButton(.minor)
                    seventhButton(.major)
                    upperExtensionsButton(.minorNine)
                    upperExtensionsButton(.nine)
                    upperExtensionsButton(.augmentedNine)
                }
                HStack {
                    upperExtensionsButton(.minorThirteen)
                    upperExtensionsButton(.thirteen)
                    upperExtensionsButton(.augmentedThirteen)
                }
            }
        }
    }
}

extension Keyboard {
    // MARK: - Keyboard Button Styles
    func noteNameKeyboardStyle(for noteName: NoteName) -> KeyboardButtonStyle {
        selectedChord.noteName == noteName ? .selected : .notSelected
    }
    
    func accidentalKeyboardStyle(for accidental: AccidentalStyle) -> KeyboardButtonStyle {
        guard selectedChord.noteName != nil else { return .disabled }
        return selectedChord.accidental == accidental ? .selected : .notSelected
    }
    
    func triadQualityKeyboardStyle(for triad: TriadQuality) -> KeyboardButtonStyle {
        guard selectedChord.noteName != nil else { return .disabled }
        return selectedChord.triadQuality == triad ? .selected : .notSelected
    }
    
    func seventhQualityKeyboardStyle(for seventh: SeventhQuality) -> KeyboardButtonStyle {
        guard selectedChord.noteName != nil else { return .disabled }
        return selectedChord.seventhQuality == seventh ? .selected : .notSelected
    }
    
    func upperExtensionKeyboardStyle(for upperExtension: UpperExtension) -> KeyboardButtonStyle {
        guard selectedChord.noteName != nil else { return .disabled }
        return (selectedChord.upperExtensions?.contains { $0 == upperExtension } ?? false) ? .selected : .notSelected
    }
    
    // MARK: - Button Views
    func noteNameButton(_ noteName: NoteName) -> some View {
        ChildSizeReader(size: $keypadSize) {
            Button {
                selectedChord.noteName = noteName
            } label: {
                Text(noteName.description)
            }
        }
        .keyboardStyle(noteNameKeyboardStyle(for: noteName))
    }
    
    func accidentalButton(_ accidental: AccidentalStyle) -> some View {
        Button {
            selectedChord.accidental = accidental
        } label: {
            Image(accidental.iconName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: keypadSize.width,maxHeight:keypadSize.height)
                .keyboardStyle(accidentalKeyboardStyle(for: accidental))
        }
    }
    
    func triadButton(_ triad: TriadQuality) -> some View {
        Button {
            selectedChord.triadQuality = triad
        } label: {
            Text(triad.rawValue)
                .keyboardStyle(triadQualityKeyboardStyle(for: triad))
        }
    }
    
    func seventhButton(_ seventh: SeventhQuality) -> some View {
        var accidentalText: String {
            switch seventh {
            case .major:
                return "△7"
            case .minor:
                return "7"
            case .diminished:
                return "°7"
            }
        }
        return Button {
            selectedChord.seventhQuality = seventh
        } label: {
            Text(accidentalText)
                .keyboardStyle(seventhQualityKeyboardStyle(for: seventh))
        }
    }
    
    func upperExtensionsButton(_ upperExtension: UpperExtension) -> some View {
        var accidentalSymbol: String {
            switch upperExtension {
            case .minorNine, .minorThirteen:
                return "flat"
            case .nine, .eleven, .thirteen:
                return ""
            case .augmentedNine, .sharpEleven, .augmentedThirteen:
                return "sharp"
            }
        }
        return Button {
            if var upperExtensions = selectedChord.upperExtensions {
                if upperExtensions.contains(where: { $0 == upperExtension })  {
                    selectedChord.upperExtensions = upperExtensions.filter { $0 != upperExtension }
                } else {
                    upperExtensions.append(upperExtension)
                    selectedChord.upperExtensions = upperExtensions
                }
            } else {
                selectedChord.upperExtensions = [upperExtension]
            }
        } label: {
            HStack(spacing: 0) {
                if ![UpperExtension.nine, UpperExtension.eleven, UpperExtension.thirteen].contains(where: { $0 == upperExtension}) {
                    Image(accidentalSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: keypadSize.width * 0.5)
                }
                Text(upperExtension.scaleDegree)
            }
            .keyboardStyle(upperExtensionKeyboardStyle(for: upperExtension))
        }
    }
}

#Preview {
    Keyboard()
}
