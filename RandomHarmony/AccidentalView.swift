//
//  AccidentalView.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/6/23.
//

import SwiftUI

struct AccidentalView: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    
    let accidental: Accidental
    var body: some View {
        Group {
            switch accidental {
            case .doubleFlat:
//                10 × 16 pixels
                Image("double.flat")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: (spaceHeight * 2 + lineHeight * 5) * (10/16),
                        height: (spaceHeight * 2 + lineHeight * 5)
                    )
            case .flat:
//                6 × 16 pixels
                Image("flat")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: (spaceHeight * 2 + lineHeight * 5) * (6/16),
                        height: (spaceHeight * 2 + lineHeight * 5)
                    )
            case .natural:
//                5 × 19 pixels
                Image("natural")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: (spaceHeight * 3) * 5/19,
                        height: (spaceHeight * 3)
                    )
            case .sharp:
//                7 × 19 pixels
                Image("sharp")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: (spaceHeight * 3) * 7/19,
                        height: (spaceHeight * 3)
                    )
            case .doubleSharp:
//                7 × 7 pixels
                Image("double.sharp")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: spaceHeight,
                        height: spaceHeight
                    )
            }
        }
    }
}

#Preview {
    AccidentalView(accidental: .sharp)
}
