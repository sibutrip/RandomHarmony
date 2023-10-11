//
//  AccidentalChordView.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/6/23.
//

import Foundation
import SwiftUI

struct AccidentalChordView: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    
    let accidentalPitches: [ChordFormat.AccidentalChordFormat]
    var body: some View {
        ZStack {
            ForEach(accidentalPitches) { accidentalPitch in
                Image(accidentalPitch.pitch.fixedSolfege.accidental.iconName)
                    .offset(
                        x: -accidentalPitch.offset(multipliedBy: spaceHeight),
                        y: accidentalPitch.pitch.staffOffset(spaceHeight: spaceHeight, lineHeight: lineHeight)
                    )
            }

        }
    }
}

