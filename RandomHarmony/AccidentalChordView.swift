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
                        #warning("accidentalPitch.offset is not right at all. need to track previous notes spaces")
                        x: -accidentalPitch.offset(multipliedBy: spaceHeight),
                        y: accidentalPitch.pitch.staffOffset(spaceHeight: spaceHeight, lineHeight: lineHeight)
                    )
            }
        }
    }
//    @ViewBuilder
//    func accidental(at index: Int) -> some View {
//        let accidentalPitch = accidentalPitches[index]
//        let accidentalIconName = accidentalPitch.fixedSolfege.accidental.iconName
//            if index > 0 {
//                let previousAccidentalPitch = accidentalPitches[index - 1]
//                let accidentalHorizontalSpacing = accidentalHorizontalSpacing(
//                    from: accidentalPitch,
//                    to: previousAccidentalPitch)
//                
//                Image(accidentalIconName)
//                    .offset(
//                        x: -spaceHeight * 1.5,
//                        y: accidentalPitch.staffOffset(
//                        spaceHeight: spaceHeight,
//                        lineHeight: lineHeight)
//                    )
//            } else {
//                Image(accidentalIconName)
//                    .offset(y: accidentalPitch.staffOffset(
//                        spaceHeight: spaceHeight,
//                        lineHeight: lineHeight)
//                    )
//            }
//    }
}

