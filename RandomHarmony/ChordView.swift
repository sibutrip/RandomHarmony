//
//  ChordView.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/21/23.
//

import SwiftUI

struct PitchChordFormat: Identifiable {
    var id: UUID { pitch.id }
    let pitch: Pitch
    var isCluster: Bool { clusterOrder != 0 }
    let clusterOrder: Int
    var accidental: Accidental { pitch.fixedSolfege.accidental }
    var clusterCount: Int = 0
    var offsetOddNumberOverride = false
    var isOffset: Bool {
        // if not in a cluster, not offset
        guard clusterCount > 0 else { return false }
        
        // if # of notes in cluster is even, even ordered notes are offset
        if clusterCount % 2 == 0 && !offsetOddNumberOverride { //TODO: OR if the previous note is a 3rd below

            return clusterOrder % 2 == 0
        }
        // if # of notes in cluster is odd, odd ordered notes are offset
        return clusterOrder % 2 == 1
    }

    static func createChordFormats(from pitches: [Pitch]) -> [PitchChordFormat] {
        let pitches = pitches.sorted {
            $0.noteOrder < $1.noteOrder
        }
        var clusterCounter = 0
        var pitchChordFormats = [PitchChordFormat]()
        pitches.enumerated().forEach { index, pitch in
            if index > 0 {
                let previousPitch = pitches[index - 1]
                if pitch.isAdjacentTo(otherPitch: previousPitch) {
                    clusterCounter += 1
                    return pitchChordFormats.append(PitchChordFormat(pitch: pitch, clusterOrder: clusterCounter))
                } else if clusterCounter != 0 {
                    
                    var offsetOddNumberOverride = false
                    //if the previous pitch is a 3rd below, offset will ALWAYS be on odd clusterOrder notes
                    if (pitch.noteName.rawValue - previousPitch.noteName.rawValue + 7) % 7 == 2 {
                        offsetOddNumberOverride = true
                    }
                    // add cluster count to all notes in the cluster
                    (0...clusterCounter).forEach { counter in
                        pitchChordFormats[index - 1 - counter].clusterCount = clusterCounter
                        pitchChordFormats[index - 1 - counter].offsetOddNumberOverride = offsetOddNumberOverride
                    }
                }
            }
            clusterCounter = 0
            return pitchChordFormats.append(PitchChordFormat(pitch: pitch, clusterOrder: clusterCounter))
        }
        return pitchChordFormats
    }
}

struct ChordView: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpaceq
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    
    let pitchChordFormats: [PitchChordFormat]
    
    var body: some View {
        ZStack {
            ForEach(pitchChordFormats) { pitchChordFormat in
                NoteView(pitch: pitchChordFormat.pitch)
                    .if(pitchChordFormat.isOffset) { noteView in
                        noteView
                            .offset(x: -spaceHeight * 1.3)
                    }
            }
        }
    }
    init(pitches: [Pitch]) {
        let formats = PitchChordFormat.createChordFormats(from: pitches)
        self.pitchChordFormats = formats
    }
}

#Preview {
    ContentView()
}
