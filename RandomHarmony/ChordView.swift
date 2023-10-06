//
//  ChordView.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/21/23.
//

import SwiftUI
import Algorithms

struct ChordView: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    
    let chordFormat: ChordFormat
    var pitchFormats: [ChordFormat.PitchChordFormat] { chordFormat.pitchFormats }
    var accidentalOrder: [Pitch] { chordFormat.accidentalOrder }
    
    var body: some View {
        ZStack {
            ForEach(pitchFormats) { pitchFormat in
                NoteView(pitch: pitchFormat.pitch)
                    .if(pitchFormat.isOffset) { noteView in
                        noteView
                            .offset(x: -spaceHeight * 1.3)
                    }
            }
        }
    }
    init(pitches: [Pitch]) {
        self.chordFormat = ChordFormat.makeChordFormat(from: pitches)
    }
}

#Preview {
    ContentView()
}

