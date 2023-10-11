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
            .frame(width: spaceHeight * 1.05 * (460 / 309), height: spaceHeight * 1.05)
            .offset(
                y: pitch.staffOffset(
                    spaceHeight: spaceHeight,
                    lineHeight: lineHeight))
            .overlay {
                LedgerLineView(pitch: pitch)
            }
    }
}



//#Preview {
//    NoteView(note: Note(pitch: Pitch(30)))
//}
