//
//  HarmonyVm.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/17/23.
//

import Foundation
import SwiftUI

class HarmonyVm: ObservableObject {
//    @Published var currentChord: NewChord
//    var raw: String {
//        return ([currentChord.root.fixedSolfege.rawValue] + currentChord.harmonies.map { $0.fixedSolfege.rawValue }).reversed().joined(separator: "\n")
//    }
    func makeChord(root: PitchClass, triad: TriadQuality, seventh: SeventhQuality? = nil, upperExtensions: [UpperExtension]? = nil) {
//        let triad = TriadQuality.allCases.randomElement()!
//        let seventh = SeventhQuality.allCases.randomElement()!
//        let root = PitchClass.allCases.randomElement()!
//        let chord = root.chord(triad: triad, seventh: seventh, upperExtensions: upperExtensions)
//        let currentChord = chord.next(root: chord.root, harmonies: chord.harmonies)
//        let root = (currentChord.root.fixedSolfege.rawValue,currentChord.root.octave)
//        let harmonies = currentChord.harmonies.map { ($0.fixedSolfege.rawValue,$0.octave) }
//        print(root, harmonies, triad.rawValue, seventh.rawValue)
    }
}
