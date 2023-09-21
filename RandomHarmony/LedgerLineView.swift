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
    let note: Note
    var hasLedgerLine: Bool { note.ledgerLine != nil }
    var initialOffset: CGFloat {
        switch note.ledgerLine {
        case .treble:
            return -spaceHeight * 10.7
        case .bass:
            return spaceHeight * 5
        case .middleC, .none:
            return 0
        }
    }
    var offsetBetweenLedgerLines: CGFloat {
        switch note.ledgerLine {
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
            ForEach(0..<note.ledgerLineCount, id: \.self) { count in
                Rectangle()
                    .frame(width: spaceHeight * (460 / 309) * 1.5, height: lineHeight)
                    .offset(y: initialOffset + offsetBetweenLedgerLines * CGFloat(count))
            }
        }
    }
}

#Preview {
    LedgerLineView(note: Note(pitch: Pitch(81)))
}
