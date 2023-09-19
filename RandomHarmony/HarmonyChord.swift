//
//  HarmonyChord.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation
import Tonic

struct HarmonyChord {
    let upperVoices: [Pitch]
    let root: Pitch // root note
    
    func next(root: Int8, triad: TriadQuality, seventh: SeventhQuality? = nil, upperExtensions: [UpperExtension]? = nil) -> HarmonyChord {
        let root = Pitch(root)
        let remainingNotes = (triad.transposed(to: root)
        + [(seventh?.transposed(to: root))]
        + (upperExtensions?.map { $0.transposed(to: root)} ?? []))
            .compactMap { $0 }
        var closestNotes = [Int8]()
        remainingNotes.forEach { transposedNote in
            var transposedNote = transposedNote
            var allDistancesAndNotes = [Int8:[Int8]]() // key: distance, value: transposedNote
            var distanceToNearestNote = Int8.max
            while distanceToNearestNote > -6 {
                transposedNote += 12
                let originalNotes = self.upperVoices
                    .map { $0.midiNoteNumber }
                
                /// (distance, transposedNote) for each member in the triad
                let distancesAndNotes = originalNotes.reduce((Int8.max,Int8.max)) { partialResult, originalNote in
                    let currentSmallestDistance = partialResult.0
                    let newDistance = originalNote - transposedNote
                    if abs(newDistance) < abs(currentSmallestDistance) {
                        return (newDistance,transposedNote)
                    } else {
                        return partialResult
                    }
                }
                distanceToNearestNote = distancesAndNotes.0
                if let currentTransposedNote = allDistancesAndNotes[distancesAndNotes.0] {
                    allDistancesAndNotes[distancesAndNotes.0] = currentTransposedNote + [distancesAndNotes.1]
                } else {
                    allDistancesAndNotes[distancesAndNotes.0] = [distancesAndNotes.1]
                }
            }
            let closestDistancesAndNotes = allDistancesAndNotes.reduce((Int8.max,[Int8]())) { partialResult, distanceAndNote in
                if abs(partialResult.0) < abs(distanceAndNote.key) {
                    return partialResult
                } else {
                    return distanceAndNote
                }
            }
            let closestNote = closestDistancesAndNotes.1.first!
            closestNotes.append(closestNote)
        }
        return HarmonyChord(root: root.midiNoteNumber, upperVoices: closestNotes)
    }
    init(root: Int8, upperVoices: [Int8]) {
        self.upperVoices = upperVoices.map { Pitch($0) }
        self.root = Pitch(root)
    }
}
