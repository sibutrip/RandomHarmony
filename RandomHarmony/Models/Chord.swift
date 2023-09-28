//
//  HarmonyChord.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

struct Chord {
    let harmonies: [Pitch]
    let root: Pitch // root note
    
    func next(root: FixedSolfege, harmonies: Set<FixedSolfege>) -> Chord {
        let root = Pitch(fixedSolfege: root, octave: 3)
        let remainingNotes = harmonies
            .map { Pitch(fixedSolfege: $0, octave: 0) }
//        var closestNotes = [Int]()
        var closestNotes = [Pitch]()
        remainingNotes.forEach { transposedNote in
            var transposedNote = transposedNote
            var allDistancesAndNotes = [Int:[Pitch]]() // key: distance, value: transposedNote
            var distanceToNearestNote = Int.max
            while distanceToNearestNote > -6 {
                transposedNote.octave += 1
                let originalNotes = self.harmonies
                    .map { $0.midiNoteNumber }
                
                /// (distance, transposedNote) for each member in the triad
                let distancesAndNotes = originalNotes.reduce((Int.max,Pitch(fixedSolfege: .C, octave: 0))) { partialResult, originalNote in
                    let currentSmallestDistance = partialResult.0
                    let newDistance = originalNote - transposedNote.midiNoteNumber
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
            let closestDistancesAndNotes = allDistancesAndNotes.reduce((Int.max,[Pitch]())) { partialResult, distanceAndNote in
                if abs(partialResult.0) < abs(distanceAndNote.key) {
                    return partialResult
                } else {
                    return distanceAndNote
                }
            }
            let closestNote = closestDistancesAndNotes.1.first!
            closestNotes.append(closestNote)
        }
        return Chord(root: root, harmonies: closestNotes)
//        return NewChord(root: 0, upperVoices: [])
    }
    
    private init(root: Pitch, harmonies: [Pitch]) {
        self.root = root
        self.harmonies = harmonies
    }
    
    init(root: FixedSolfege, harmonies: [FixedSolfege]) {
        self.root = Pitch(fixedSolfege: root, octave: 3)
        self.harmonies = harmonies.map {Pitch(fixedSolfege: $0, octave: 4)}
    }
    
//    init(root: Int, triad: OLDTriadQuality, seventh: OLDSeventhQuality? = nil, upperExtensions: [OLDUpperExtension]? = nil) {
//        let root = Pitch(root)
//        self.root = root
//        let remainingNotes = (triad.transposed(to: root)
//        + [(seventh?.transposed(to: root))]
//        + (upperExtensions?.map { $0.transposed(to: root)} ?? []))
//            .compactMap { $0 }
//        self.upperVoices = remainingNotes.map { Pitch($0) }
//    }
}
