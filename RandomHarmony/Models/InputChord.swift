//
//  InputChord.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/28/23.
//

import Foundation
import SwiftUI

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
    
    var cleanedAccidental: String {
        guard let accidental else { return "" }
        switch accidental {
        case .sharp:
            return "♯"
        case .flat:
            return "♭"
        case .natural:
            return ""
        }
    }
    
    var cleanedNote: String {
        return noteName?.description ?? ""
    }
    
    var cleanedTriad: String {
        guard let triadQuality else { return "" }
        switch triadQuality {
        case .major:
            if seventhQuality == .minor {
                return ""
            } else {
                return "MA"
            }
        case .minor:
            return "MI"
        case .diminished:
            if seventhQuality == .minor {
                return ""
            }
            return "°"
        case .augmented:
            return "+"
        case .sus:
            return "sus"
        }
    }
    var cleanedSeventh: String {
        guard let seventhQuality else { return "" }
        switch seventhQuality {
        case .major:
            if triadQuality == .major {
                return "7"
            } else {
                return "△7"
            }
        case .minor:
            if triadQuality == .diminished {
                return "\u{E871}" // diminished
            }
            return "7"
        case .diminished:
            if triadQuality == .diminished {
                return "7"
            }
            return "°7"
        }
    }
    var cleanedExtensions: [[String]] {
        guard var upperExtensions
        else { return [] }
        upperExtensions = upperExtensions.sorted()
        var cleanedExtensions = [[String](),[String](),[String]()]
        upperExtensions.enumerated().forEach { (index, upperExtension) in
            if index < 3 {
                cleanedExtensions[0].append(upperExtension.description)
            } else if index < 6 {
                cleanedExtensions[1].append(upperExtension.description)
            } else {
                cleanedExtensions[2].append(upperExtension.description)
            }
        }
        cleanedExtensions = cleanedExtensions.filter { $0 != [] }
        return cleanedExtensions
    }
}

#Preview {
    Keyboard()
}
