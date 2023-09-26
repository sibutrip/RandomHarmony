//
//  EnvironmentValues.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/20/23.
//

import Foundation
import SwiftUI

private struct StaffHeight: EnvironmentKey {
    static let defaultValue: CGFloat = 0
}

private struct StaffSpace: EnvironmentKey {
    static let defaultValue: CGFloat = 0
}

private struct LineHeight: EnvironmentKey {
    static let defaultValue: CGFloat = 0
}

private struct SpaceHeight: EnvironmentKey {
    static let defaultValue: CGFloat = 0
}

extension EnvironmentValues {
    var staffHeight: CGFloat {
        get { self[StaffHeight.self] }
        set { self[StaffHeight.self] = newValue }
    }
    var staffSpace: CGFloat {
        get { self[StaffSpace.self] }
        set { self[StaffSpace.self] = newValue }
    }
    var lineHeight: CGFloat {
        get { self[LineHeight.self] }
        set { self[LineHeight.self] = newValue }
    }
    var spaceHeight: CGFloat {
        get { self[SpaceHeight.self] }
        set { self[SpaceHeight.self] = newValue }
    }
}
