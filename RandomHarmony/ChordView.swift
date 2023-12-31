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
    var accidentalFormats: [ChordFormat.AccidentalChordFormat] { chordFormat.accidentalPitches }
//    var accidentalPitches: [Pitch] { chordFormat.accidentalPitches.map { $0.pitch } }
    var clusterOffset: CGFloat { -spaceHeight * 1.3 }
    var containsCluster: Bool { return pitchFormats.contains { $0.isCluster } }
    
    private var accidentalChordViewWidth: CGFloat {
        accidentalFormats.last?.offset(multipliedBy: spaceHeight) ?? 0
    }
    private var lastAccidentalWidth: CGFloat {
        accidentalFormats.last?.pitch.fixedSolfege.accidental.iconScale.width ?? 0
    }
    var chordViewWidth: CGFloat {
        accidentalChordViewWidth + abs(clusterOffset) + lastAccidentalWidth
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Spacer()
                .frame(width: chordViewWidth)
            ForEach(pitchFormats) { pitchFormat in
                NoteView(pitch: pitchFormat.pitch)
                    .if(pitchFormat.isOffset) { noteView in
                        noteView
                            .offset(x: clusterOffset)
                    }
            }
            AccidentalChordView(accidentalPitches: accidentalFormats)
                .if(containsCluster) { noteView in
                    noteView
                        .offset(x: clusterOffset)
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

