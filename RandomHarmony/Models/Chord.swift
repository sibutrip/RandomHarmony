//
//  HarmonyChord.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

struct Chord {
    let upperVoices: [Pitch]
    let root: Pitch // root note
    
    func next(root: Int, triad: OLDTriadQuality, seventh: OLDSeventhQuality? = nil, upperExtensions: [OLDUpperExtension]? = nil) -> Chord {
        let root = Pitch(root)
        let remainingNotes = (triad.transposed(to: root)
        + [(seventh?.transposed(to: root))]
        + (upperExtensions?.map { $0.transposed(to: root)} ?? []))
            .compactMap { $0 }
        var closestNotes = [Int]()
        remainingNotes.forEach { transposedNote in
            var transposedNote = transposedNote
            var allDistancesAndNotes = [Int:[Int]]() // key: distance, value: transposedNote
            var distanceToNearestNote = Int.max
            while distanceToNearestNote > -6 {
                transposedNote += 12
                let originalNotes = self.upperVoices
                    .map { $0.midiNote }
                
                /// (distance, transposedNote) for each member in the triad
                let distancesAndNotes = originalNotes.reduce((Int.max,Int.max)) { partialResult, originalNote in
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
            let closestDistancesAndNotes = allDistancesAndNotes.reduce((Int.max,[Int]())) { partialResult, distanceAndNote in
                if abs(partialResult.0) < abs(distanceAndNote.key) {
                    return partialResult
                } else {
                    return distanceAndNote
                }
            }
            let closestNote = closestDistancesAndNotes.1.first!
            closestNotes.append(closestNote)
        }
        return Chord(root: root.midiNote, upperVoices: closestNotes)
    }
    
    private init(root: Int, upperVoices: [Int]) {
        self.root = Pitch(root)
        self.upperVoices = upperVoices.map { Pitch($0) }
    }
    
    init(root: Int, triad: OLDTriadQuality, seventh: OLDSeventhQuality? = nil, upperExtensions: [OLDUpperExtension]? = nil) {
        let root = Pitch(root)
        self.root = root
        let remainingNotes = (triad.transposed(to: root)
        + [(seventh?.transposed(to: root))]
        + (upperExtensions?.map { $0.transposed(to: root)} ?? []))
            .compactMap { $0 }
        self.upperVoices = remainingNotes.map { Pitch($0) }
    }
}
