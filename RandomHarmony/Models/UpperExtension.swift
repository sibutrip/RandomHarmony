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
