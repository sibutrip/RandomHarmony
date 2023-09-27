//
//  RandomHarmonyApp.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/17/23.
//

import SwiftUI

@main
struct RandomHarmonyApp: App {
    @State var currentChord: NewChord
    var raw: String {
        return ([currentChord.root.fixedSolfege.rawValue] + currentChord.harmonies.map { $0.fixedSolfege.rawValue }).joined(separator: " ")
    }
    var body: some Scene {
        WindowGroup {
            Button {
                let scale = Scale.all.randomElement()!
                let triad = TriadQuality.allCases.randomElement()!
                let seventh = SeventhQuality.allCases.randomElement()!
                let chord = scale.chord(triad: triad, seventh: seventh)
                currentChord = currentChord.next(root: chord.root, harmonies: chord.harmonies)
                let root = (currentChord.root.fixedSolfege.rawValue,currentChord.root.octave)
                let harmonies = currentChord.harmonies.map {($0.fixedSolfege.rawValue,$0.octave)}
                print(root, harmonies, triad.rawValue, seventh.rawValue)
            } label: {
                Text(raw)
            }
            
        }
    }
    init() {
        _currentChord = .init(initialValue: NewChord(root: .C, harmonies: [.E,.G]))
    }
}
