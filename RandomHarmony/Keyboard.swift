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
                selectedChordView
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
                    upperExtensionsButton(.eleven)
                    upperExtensionsButton(.sharpEleven)
                    upperExtensionsButton(.minorThirteen)
                    upperExtensionsButton(.thirteen)
                    upperExtensionsButton(.augmentedThirteen)
                }
            }
        }
    }
}

extension Keyboard {
    
    @ViewBuilder
    var selectedChordView: some View {
        HStack(spacing: 0) {
            Text(selectedChord.cleanedNote)
            Text(selectedChord.cleanedAccidental)
            if selectedChord.triadQuality == .diminished || selectedChord.triadQuality == .augmented {
                VStack {
                    Text(selectedChord.cleanedTriad)
                    Spacer()
                }
                .fixedSize()
            } else {
                VStack {
                    Spacer()
                    Text(selectedChord.cleanedTriad)
                        .font(.footnote)
                }
                .fixedSize()
            }
            if selectedChord.cleanedSeventh == "\u{E871}" {
                Text(selectedChord.cleanedSeventh)
                    .font(.custom("Bravura", size: 20))
            } else {
                VStack {
                    Text(selectedChord.cleanedSeventh)
                    Spacer()
                }
                .fixedSize()
            }
            HStack(alignment: .center, spacing: 0) {
                if selectedChord.upperExtensions?.count ?? 0 > 0 {
                    Text("\u{E879}")
                        .font(.custom("Bravura", size: 40))
                        .offset(y: 20)
                        .padding(.horizontal, 5)
                    ForEach(selectedChord.cleanedExtensions, id: \.self) { extensionGroup in
                        VStack {
                            ForEach(extensionGroup, id: \.self) { upperExtension in
                                Text(upperExtension)
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                    Text("\u{E87A}")
                        .font(.custom("Bravura", size: 40))
                        .offset(y: 20)
                        .padding(.horizontal, 5)
                }
            }
        }
    }
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
                if selectedChord.noteName != noteName {
                    selectedChord.noteName = noteName
                } else {
                    selectedChord = InputChord()
                }
            } label: {
                Text(noteName.description)
            }
        }
        .keyboardStyle(noteNameKeyboardStyle(for: noteName))
    }
    
    @ViewBuilder
    func accidentalButton(_ accidental: AccidentalStyle) -> some View {
        let keyboardStyle = accidentalKeyboardStyle(for: accidental)
        Button {
            selectedChord.accidental = accidental
        } label: {
            Image(accidental.iconName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: keypadSize.width,maxHeight:keypadSize.height)
                .keyboardStyle(keyboardStyle)
        }
        .disabled(keyboardStyle == .disabled)
    }
    
    @ViewBuilder
    func triadButton(_ triad: TriadQuality) -> some View {
        let keyboardStyle = triadQualityKeyboardStyle(for: triad)
        Button {
            selectedChord.triadQuality = triad
        } label: {
            Text(triad.rawValue)
                .keyboardStyle(keyboardStyle)
        }
        .disabled(keyboardStyle == .disabled)
    }
    
    @ViewBuilder
    func seventhButton(_ seventh: SeventhQuality) -> some View {
        let keyboardStyle = seventhQualityKeyboardStyle(for: seventh)
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
        Button {
            if selectedChord.seventhQuality == seventh {
                selectedChord.seventhQuality = nil
            } else {
                selectedChord.seventhQuality = seventh
            }
        } label: {
            Text(accidentalText)
                .keyboardStyle(keyboardStyle)
        }
        .disabled(keyboardStyle == .disabled)
    }
    
    @ViewBuilder
    func upperExtensionsButton(_ upperExtension: UpperExtension) -> some View {
        let keyboardStyle = upperExtensionKeyboardStyle(for: upperExtension)
        Button {
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
                    Image(upperExtension.accidentalSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: keypadSize.width * 0.5)
                }
                Text(upperExtension.scaleDegree)
            }
            .keyboardStyle(keyboardStyle)
        }
        .disabled(keyboardStyle == .disabled)
    }
}

#Preview {
    Keyboard()
}
