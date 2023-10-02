//
//  StaffRow.swift
//  AutoShanty
//
//  Created by Cory Tripathy on 7/19/23.
//

import SwiftUI

enum Clef {
    case treble, bass
    var name: String {
        switch self {
        case .treble:
            return "treble.clef"
        case .bass:
            return "bass.clef"
        }
    }
}

struct StaffRow: View {
    @Environment(\.staffHeight) var staffHeight
    @Environment(\.staffSpace) var staffSpace
    @Environment(\.lineHeight) var lineHeight
    @Environment(\.spaceHeight) var spaceHeight
    var body: some View {
        ZStack {
            grandStaff
            NoteRow()
        }
    }
    
    var grandStaff: some View {
        HStack(alignment: .top, spacing: 4) {
            grandStaffHeader
            VStack(spacing: 0) {
                staff(clef: .treble)
                staff(clef: .bass)
                Spacer().frame(height: staffSpace / 2)
            }
        }
    }
    
    var grandStaffHeader: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: spaceHeight * 3 + lineHeight * 2)
            Image("grand.staff")
                .resizable()
                .frame(height: staffHeight * 2 - (spaceHeight * 2)) // staff height minus the ledger lines
            Spacer()
                .frame(height: spaceHeight * 3 + lineHeight * 2)
        }
        .frame(width: (staffHeight * 2 - (spaceHeight * 4 + lineHeight * 2)) * 6/83)
    }
    
    var bassClef: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height:spaceHeight * 3.1 + lineHeight * 2)
            Image("bass.clef")
                .resizable()
                .frame(
                    width: (staffHeight - (spaceHeight * 4 + lineHeight)) * (671 / 772) * 0.7,
                    height: (staffHeight - (spaceHeight * 4 + lineHeight)) * 0.7
                )
        }
    }
    
    var trebleClef: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height:spaceHeight * 1.4 + lineHeight * 2) // height is smaller than bass clef
            Image("treble.clef")
                .resizable()
                .frame(
                    width: (staffHeight - (spaceHeight * 4 + lineHeight)) * (200 / 600) * 1.7,
                    height: (staffHeight - (spaceHeight * 4 + lineHeight)) * 1.7
                )
        }
    }
    
    func staff(clef: Clef) -> some View {
        ZStack(alignment: .top) {
            staffLines
            HStack {
                switch clef {
                case .treble:
                    trebleClef
                case .bass:
                    bassClef
                }
                Spacer()
            }
            .padding(.horizontal, 5)
        }
    }
    
    var staffLines: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: spaceHeight)
            Rectangle()
                .frame(height: lineHeight)
                .foregroundColor(.white)
            Rectangle()
                .foregroundColor(.white)
                .frame(height: spaceHeight)
            Rectangle()
                .frame(height: lineHeight)
                .foregroundColor(.white)
            Rectangle()
                .foregroundColor(.white)
                .frame(height: spaceHeight)
            Rectangle()
                .foregroundColor(.black)
                .frame(height: lineHeight)
            Rectangle()
                .foregroundColor(.white)
                .frame(height: spaceHeight)
            
            Rectangle()
                .foregroundColor(.black)
                .frame(height: lineHeight)
            Rectangle()
                .foregroundColor(.white)
                .frame(height: spaceHeight)
            Group {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: lineHeight)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: spaceHeight)
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: lineHeight)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: spaceHeight)
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: lineHeight)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: spaceHeight)
                Rectangle()
                    .frame(height: lineHeight)
                    .foregroundColor(.white)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: spaceHeight)
                Rectangle()
                    .frame(height: lineHeight)
                    .foregroundColor(.white)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: spaceHeight)
            }
        }
    }
}

struct StaffRow_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            let height: CGFloat = geo.size.height
            let staveCount = CGFloat(6)
            let staffRatio = min(0.6, staveCount * -0.013 + 0.7)
            let staffSpace = (1 - staffRatio) * height / (staveCount + 1) * 1.8
            let staffHeight = staffRatio * height / staveCount - (staffSpace / staveCount)
            let lineHeight = staffHeight / 63
            let spaceHeight = staffHeight / 9
            StaffRow()
                .environment(\.staffHeight, staffHeight)
                .environment(\.staffSpace, staffSpace)
                .environment(\.lineHeight, lineHeight)
                .environment(\.spaceHeight, spaceHeight)
        }
    }
}

