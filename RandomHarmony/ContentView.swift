//
//  ContentView.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/17/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            let height: CGFloat = geo.size.height
            let staveCount = CGFloat(6)
            let staffRatio = min(0.6, staveCount * -0.013 + 0.7)
            let staffSpace = (1 - staffRatio) * height / (staveCount + 1) * 1.8
            let staffHeight = staffRatio * height / staveCount - (staffSpace / staveCount)
            let lineHeight = staffHeight / 63
            let spaceHeight = staffHeight / 9
            VStack {
                StaffRow()
//                StaffRow(debugStaffRow: .flatflat)
//                StaffRow(debugStaffRow: .flatsharp)
//                StaffRow(debugStaffRow: .sharpflat)
//                StaffRow(debugStaffRow: .sharpsharp)
            }
                .environment(\.staffHeight, staffHeight)
                .environment(\.staffSpace, staffSpace)
                .environment(\.lineHeight, lineHeight)
                .environment(\.spaceHeight, spaceHeight)
        }
    }
}

#Preview {
    ContentView()
}
