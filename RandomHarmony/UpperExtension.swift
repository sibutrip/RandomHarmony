//
//  UpperExtension.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation
import Tonic

enum UpperExtension {
    case minorNine, nine, augmentedNine, eleven, sharpEleven, minorThirteen, thirteen, augmentedThirteen
    var pitchClass: Int8 {
        switch self {
        case .minorNine:
            return 1
        case .nine:
            return 2
        case .augmentedNine:
            return 3
        case .eleven:
            return 5
        case .sharpEleven:
            return 6
        case .minorThirteen:
            return 8
        case .thirteen:
            return 9
        case .augmentedThirteen:
            return 10
        }
    }
    func transposed(to root: Pitch) -> Int8 {
        return self.pitchClass + root.pitchClass
    }
}
