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
                AccidentalView(accidental: accidentalPitch.pitch.fixedSolfege.accidental)
                    .offset(
                        x: -accidentalPitch.offset(multipliedBy: spaceHeight),
                        y: yOffset(for: accidentalPitch)
                    )
            }

        }
    }
    
    func yOffset(for accidentalPitch: ChordFormat.AccidentalChordFormat) -> CGFloat {
        var baseOffset = accidentalPitch.pitch.staffOffset(spaceHeight: spaceHeight, lineHeight: lineHeight)
        switch accidentalPitch.pitch.fixedSolfege.accidental {
        case .doubleFlat:
            break
        case .flat:
            baseOffset -= spaceHeight / 2 + lineHeight
            break
        case .natural:
            break
        case .sharp:
            break
        case .doubleSharp:
            break
        }
        return baseOffset
    }
}

