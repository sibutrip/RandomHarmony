//
//  LedgerLine.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/21/23.
//

import SwiftUI

struct LedgerLineView: View {
    @Environment(\.spaceHeight) var spaceHeight
    @Environment(\.lineHeight) var lineHeight
    let pitch: Pitch
    var hasLedgerLine: Bool { pitch.ledgerLine != nil }
    var initialOffset: CGFloat {
        switch pitch.ledgerLine {
        case .treble:
            return -spaceHeight * 11.85
        case .bass:
//            return spaceHeight * 5
            return (spaceHeight + lineHeight) * 5 + spaceHeight / 2 * 1.15
        case .middleC, .none:
            return -spaceHeight * 5
        }
    }
    var offsetBetweenLedgerLines: CGFloat {
        switch pitch.ledgerLine {
        case .treble:
            return -(lineHeight + spaceHeight)
        case .bass:
            return (lineHeight + spaceHeight)
        case .middleC, .none:
            return 0
        }
    }
    var body: some View {
        if hasLedgerLine {
            ForEach(0..<pitch.ledgerLineCount, id: \.self) { count in
                Rectangle()
                    .frame(width: spaceHeight * (460 / 309) * 1.42, height: lineHeight)
                    .offset(y: initialOffset + offsetBetweenLedgerLines * CGFloat(count))
            }
        }
    }
}

//#Preview {
//    LedgerLineView(note: Note(pitch: Pitch(81)))
//}
