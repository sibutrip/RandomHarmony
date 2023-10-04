//
//  ChordView.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/21/23.
//

import SwiftUI

struct ChordFormat {
    let pitch: Pitch
    let isCluster: Bool
}

struct ChordView: View {
    let pitches: [Pitch]
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    var body: some View {
        ZStack {
            ForEach(pitches) { pitch in
                NoteView(pitch: pitch)
            }
        }
    }
}

#Preview {
    ContentView()
}
