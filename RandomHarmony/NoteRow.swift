//
//  NoteRow.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation
import SwiftUI

struct NoteRow: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: staffHeight)
            Group {
                NoteView(pitch: Pitch(fixedSolfege: .C, octave: 4))
                NoteView(pitch: Pitch(fixedSolfege: .Csharp, octave: 4))
                NoteView(pitch: Pitch(fixedSolfege: .B, octave: 3))
                NoteView(pitch: Pitch(fixedSolfege: .A, octave: 3))
                NoteView(pitch: Pitch(fixedSolfege: .G, octave: 3))
                NoteView(pitch: Pitch(fixedSolfege: .F, octave: 3))
                NoteView(pitch: Pitch(fixedSolfege: .E, octave: 3))
            }
            NoteView(pitch: Pitch(fixedSolfege: .D, octave: 3))
            Group {
                NoteView(pitch: Pitch(fixedSolfege: .C, octave: 3))
                NoteView(pitch: Pitch(fixedSolfege: .B, octave: 2))
                NoteView(pitch: Pitch(fixedSolfege: .A, octave: 2))
                NoteView(pitch: Pitch(fixedSolfege: .G, octave: 2))
                NoteView(pitch: Pitch(fixedSolfege: .F, octave: 2))
                NoteView(pitch: Pitch(fixedSolfege: .E, octave: 2))
                NoteView(pitch: Pitch(fixedSolfege: .D, octave: 2))
                NoteView(pitch: Pitch(fixedSolfege: .C, octave: 2))
                NoteView(pitch: Pitch(fixedSolfege: .B, octave: 1))
            }
            Spacer()
        }
    }
}

