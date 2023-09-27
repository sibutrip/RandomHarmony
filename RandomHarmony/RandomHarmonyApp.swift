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
        return ([currentChord.root.fixedSolfege.rawValue] + currentChord.harmonies.map { $0.fixedSolfege.rawValue }).reversed().joined(separator: "\n")
    }
    var body: some Scene {
        WindowGroup {
            Button {
//                let triad = TriadQuality.allCases.randomElement()!
//                let seventh = SeventhQuality.allCases.randomElement()!
                let pc = PitchClass.allCases.randomElement()!
                let triad = TriadQuality.diminished
                let seventh = SeventhQuality.diminished
//                let pc = PitchClass.one
                let chord = pc.chord(triad: triad, seventh: seventh)
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
