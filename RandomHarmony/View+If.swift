//
//  View+If.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 10/4/23.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
