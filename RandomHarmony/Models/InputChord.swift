//
//  InputChord.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/28/23.
//

import Foundation

struct InputChord {
    var noteName: NoteName?
    var accidental: AccidentalStyle?
    var triadQuality: TriadQuality?
    var seventhQuality: SeventhQuality?
    var upperExtensions: [UpperExtension]?
    var raw: String {
        var contents = [noteName?.description] + [accidental?.rawValue.description] + [triadQuality?.rawValue.description] + [ seventhQuality?.rawValue.description ]
        contents += upperExtensions?.map { $0.rawValue.description } ?? []
        return contents.compactMap { $0 }.joined(separator: " ")
    }
}



//        var contents = [noteName?.rawValue.description + accidental?.rawValue.description] + triadQuality?.rawValue.description + seventhQuality?.rawValue.description].compactMap { $0 } + upperExtensions.map { $0.rawValue.description }
