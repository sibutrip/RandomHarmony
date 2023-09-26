//
//  NoteRow.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation
import SwiftUI

struct Restaurant {
    let id = UUID()
}

struct NoteRow: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: staffHeight)
            ForEach([60], id: \.self) { index in
                NoteView(note: Note(pitch: Pitch(index)))
                Spacer()
            }
        }
    }
}
