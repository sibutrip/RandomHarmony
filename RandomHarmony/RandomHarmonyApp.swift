//
//  RandomHarmonyApp.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/17/23.
//

import SwiftUI

@main
struct RandomHarmonyApp: App {
    let raw: String
    var body: some Scene {
        WindowGroup {
            Text(raw)
//            ContentView()
            
        }
    }
    init() {
        raw = Scale.B.chord(triad: .sus, seventh: .diminished, upperExtensions: [.augmentedNine,.augmentedThirteen,.eleven,.minorNine,.thirteen,.nine]).map {$0.rawValue + " "}.joined()
    }
}
