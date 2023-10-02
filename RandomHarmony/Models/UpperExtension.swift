//
//  UpperExtension.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/19/23.
//

import Foundation

enum UpperExtension: String, CaseIterable {
    case minorNine, nine, augmentedNine, eleven, sharpEleven, minorThirteen, thirteen, augmentedThirteen
    var pitchClass: Interval {
        switch self {
        case .minorNine:
            return .minorSecond
        case .nine:
            return .majorSecond
        case .augmentedNine:
            return .augmentedSecond
        case .eleven:
            return .perfectFouth
        case .sharpEleven:
            return .augmentedFourth
        case .minorThirteen:
            return .minorSixth
        case .thirteen:
            return .majorSixth
        case .augmentedThirteen:
            return .minorSeventh
        }
    }
    
    var description: String {
        switch self {
        case .minorNine:
            "♭9"
        case .nine:
            "9"
        case .augmentedNine:
            "♯9"
        case .eleven:
            "11"
        case .sharpEleven:
            "♯11"
        case .minorThirteen:
            "♭13"
        case .thirteen:
            "13"
        case .augmentedThirteen:
            "♯13"
        }
    }
    
    var accidentalSymbol: String {
        switch self {
        case .minorNine, .minorThirteen:
            return "flat"
        case .nine, .eleven, .thirteen:
            return ""
        case .augmentedNine, .sharpEleven, .augmentedThirteen:
            return "sharp"
        }
    }
    
    var scaleDegree: String {
        switch self {
        case .minorNine, .nine, .augmentedNine:
            return 9.description
        case .eleven, .sharpEleven:
            return 11.description
        case .minorThirteen, .thirteen, .augmentedThirteen:
            return 13.description
        }
    }
//    var description: some View {
//        switch self {
//        case .minorNine:
//            HStack {
//                Image("flat")
//                Text("9")
//            }
//        case .nine:
//            <#code#>
//        case .augmentedNine:
//            <#code#>
//        case .eleven:
//            <#code#>
//        case .sharpEleven:
//            <#code#>
//        case .minorThirteen:
//            <#code#>
//        case .thirteen:
//            <#code#>
//        case .augmentedThirteen:
//            <#code#>
//        }
//    }
}

extension UpperExtension: Comparable {
    private var order: Int {
        switch self {
        case .minorNine:
            0
        case .nine:
            1
        case .augmentedNine:
            2
        case .eleven:
            3
        case .sharpEleven:
            4
        case .minorThirteen:
            5
        case .thirteen:
            6
        case .augmentedThirteen:
            7
        }
    }
    static func < (lhs: UpperExtension, rhs: UpperExtension) -> Bool {
        lhs.order < rhs.order
    }
}
