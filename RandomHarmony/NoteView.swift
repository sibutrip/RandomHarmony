////
////  NoteView.swift
////  RandomHarmony
////
////  Created by Cory Tripathy on 9/20/23.
////
//
//import SwiftUI
//
//struct NoteView: View {
//    @Environment(\.staffHeight) var staffHeight
//    @Environment(\.staffSpace) var staffSpace
//    @Environment(\.lineHeight) var lineHeight
//    @Environment(\.spaceHeight) var spaceHeight
//    let note: Note
//    var body: some View {
//        Image("whole.note")
//            .resizable()
//            .frame(width: spaceHeight * (460 / 309), height: spaceHeight)
//            .offset(y: offset)
//            .overlay {
//                LedgerLineView(note: note)
//            }
//    }
//    var offset: CGFloat {
//        if note.midiNoteNumber >= 60 {
//            let noteOffset = note.noteName.trebleClefPosition + 7 * (note.octave - 5)
//            return -spaceHeight * 3.85 + -CGFloat(noteOffset) * (spaceHeight / 2 + lineHeight / 2)
//        } else {
//            // multiplying by 0.98 is the only thing that gets the notes to line up on the staff and I have no idea why
//            let noteOffset = note.noteName.trebleClefPosition + 7 * (note.octave - 4)
//            return -CGFloat(noteOffset) * (spaceHeight / 2 + lineHeight / 2) * 0.975 - (spaceHeight * 3/2 + lineHeight)
//        }
//    }
//}
//
//
//
////#Preview {
////    NoteView(note: Note(pitch: Pitch(30)))
////}
