//
//  NoteView.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/20/23.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    let pitch: Pitch
    var body: some View {
        Image("whole.note")
            .resizable()
            .frame(width: spaceHeight * (460 / 309), height: spaceHeight)
            .offset(y: yOffset)
            .overlay {
                LedgerLineView(pitch: pitch)
            }
    }
    var yOffset: CGFloat {
        if pitch.octave >= 4 {
            let noteOffset = pitch.noteName.trebleClefPosition + 7 * (pitch.octave - 5)
            return -spaceHeight * 9 + -CGFloat(noteOffset) * (spaceHeight / 2 + lineHeight / 2)
        } else {
            let noteOffset = (pitch.noteName.trebleClefPosition - 1) + 7 * (pitch.octave - 4)
            return -CGFloat(noteOffset) * (spaceHeight / 2 + lineHeight / 2) - (spaceHeight + lineHeight)
        }
    }
}



//#Preview {
//    NoteView(note: Note(pitch: Pitch(30)))
//}
