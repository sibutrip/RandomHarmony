//
//  Scale.swift
//  RandomHarmony
//
//  Created by Cory Tripathy on 9/25/23.
//

import Foundation

struct Scale: Hashable {
    let root: FixedSolfege

    let `do`: Accidental
    let re: Accidental
    let mi: Accidental
    let fa: Accidental
    let sol: Accidental
    let la: Accidental
    let ti: Accidental
    
    private init(root: FixedSolfege, `do`: Accidental, re: Accidental, mi: Accidental, fa: Accidental, sol: Accidental, la: Accidental, ti: Accidental) {
        self.root = root
        self.do = `do`
        self.re = re
        self.mi = mi
        self.fa = fa
        self.sol = sol
        self.la = la
        self.ti = ti
    }
    
    static let all: [Scale] = [
        Self.A,
        Self.Ab,
        Self.Asharp,
        Self.Bb,
        Self.B,
        Self.C,
        Self.Csharp,
        Self.D,
        Self.Db,
        Self.Dsharp,
        Self.Eb,
        Self.E,
        Self.F,
        Self.Fsharp,
        Self.Gb,
        Self.G,
        Self.Gsharp
    ]
    
    public func chord(triad: TriadQuality, seventh: SeventhQuality? = nil, upperExtensions: [UpperExtension]? = nil) -> (root: FixedSolfege, harmonies: Set<FixedSolfege>) {
        let solfeges = (triad.pitchClasses
        + [(seventh?.pitchClass)]
        + (upperExtensions?.map { $0.pitchClass} ?? []))
            .compactMap { $0 }
        let root = chordTone(from: .unison)
        let harmonies = Set(chordTones(from: solfeges))
            .filter { $0 != root}
        return (root, harmonies)
    }
    
    func chordTones(from solfeges: [Interval]) -> [FixedSolfege] {
        return solfeges.map {
            return chordTone(from: $0)
        }
    }
    
    private func chordTone(from solfege: Interval) -> FixedSolfege {
        let doLetterName = root.noteName
        let reLetterName = root.noteName.adding(interval: .second)
        let miLetterName = root.noteName.adding(interval: .third)
        let faLetterName = root.noteName.adding(interval: .fourth)
        let solLetterName = root.noteName.adding(interval: .fifth)
        let laLetterName = root.noteName.adding(interval: .sixth)
        let tiLetterName = root.noteName.adding(interval: .seventh)
        switch solfege {
        case .unison:
            let accidental = self.do
            return doLetterName.chordTone(with: accidental)
        case .augmentedUnison:
            let accidental = self.do.addingSharp
            return doLetterName.chordTone(with: accidental)
        case .minorSecond:
            let accidental = self.re.addingFlat
            return reLetterName.chordTone(with: accidental)
        case .majorSecond:
            let accidental = self.re
            return reLetterName.chordTone(with: accidental)
        case .augmentedSecond:
            let accidental = self.re.addingSharp
            return reLetterName.chordTone(with: accidental)
        case .minorThird:
            let accidental = self.mi.addingFlat
            return miLetterName.chordTone(with: accidental)
        case .majorThird:
            let accidental = self.mi
            return miLetterName.chordTone(with: accidental)
        case .perfectFouth:
            let accidental = self.fa
            return faLetterName.chordTone(with: accidental)
        case .augmentedFourth:
            let accidental = self.fa.addingSharp
            return faLetterName.chordTone(with: accidental)
        case .diminishedFifth:
            let accidental = self.sol.addingFlat
            return solLetterName.chordTone(with: accidental)
        case .perfectFifth:
            let accidental = self.sol
            return solLetterName.chordTone(with: accidental)
        case .augmentedFifth:
            let accidental = self.sol.addingSharp
            return solLetterName.chordTone(with: accidental)
        case .minorSixth:
            let accidental = self.la.addingFlat
            return laLetterName.chordTone(with: accidental)
        case .majorSixth:
            let accidental = self.la
            return laLetterName.chordTone(with: accidental)
        case .diminishedSeventh:
            let accidental = self.ti.addingTwoFlats
            return tiLetterName.chordTone(with: accidental)
        case .minorSeventh:
            let accidental = self.ti.addingFlat
            return tiLetterName.chordTone(with: accidental)
        case .majorSeventh:
            let accidental = self.ti
            return tiLetterName.chordTone(with: accidental)
        }
    }
    
    private var all: [Accidental] {
        [self.do, self.re, self.mi, self.fa, self.sol, self.la, self.ti]
    }
    
    /// more negative is flat, more positive is sharp
    func preferredAccidentalStyle(with solfeges: [Interval]) -> Int {
        
        let value = solfeges.reduce(0) { partialResult, solfege in
            let noteValue = switch solfege {
            case .unison:
                self.do.rawValue
            case .augmentedUnison:
                self.do.rawValue + 1
            case .minorSecond:
                self.re.rawValue - 1
            case .majorSecond:
                self.re.rawValue
            case .augmentedSecond:
                self.re.rawValue + 1
            case .minorThird:
                self.mi.rawValue - 1
            case .majorThird:
                self.mi.rawValue
            case .perfectFouth:
                self.fa.rawValue
            case .augmentedFourth:
                self.fa.rawValue + 1
            case .diminishedFifth:
                self.sol.rawValue - 1
            case .perfectFifth:
                self.sol.rawValue
            case .augmentedFifth:
                self.sol.rawValue + 1
            case .minorSixth:
                self.la.rawValue - 1
            case .majorSixth:
                self.la.rawValue
            case .diminishedSeventh:
                self.ti.rawValue - 2
            case .minorSeventh:
                self.ti.rawValue - 1
            case .majorSeventh:
                self.ti.rawValue
            }
            return noteValue + partialResult
        }
        return value
    }
    
//    var preferredAccidentalStyle: AccidentalStyle {
//        let accidentalPreference = all.reduce(0) { $0 + $1.rawValue}
//        if accidentalPreference > 0 {
//            return .sharp
//        } else if accidentalPreference < 0 {
//            return .flat
//        } else {
//            return .natural
//        }
//    }
    
    static let C = Scale(root: .C, do: .natural,
                         re: .natural,
                         mi: .natural,
                         fa: .natural,
                         sol: .natural,
                         la: .natural,
                         ti: .natural)
    static let Csharp = Scale(root: .Csharp, do: .sharp,
                          re: .sharp,
                          mi: .sharp,
                          fa: .sharp,
                          sol: .sharp,
                          la: .sharp,
                          ti: .sharp)
    static let Db = Scale(root: .Db, do: .flat,
                          re: .flat,
                          mi: .natural,
                          fa: .flat,
                          sol: .flat,
                          la: .flat,
                          ti: .natural)
    static let D = Scale(root: .D, do: .natural,
                         re: .natural,
                         mi: .sharp,
                         fa: .natural,
                         sol: .natural,
                         la: .natural,
                         ti: .sharp)
    static let Dsharp = Scale(root: .Dsharp, do: .sharp,
                          re: .sharp,
                          mi: .doubleSharp,
                          fa: .sharp,
                          sol: .sharp,
                          la: .sharp,
                          ti: .doubleSharp)
    static let Eb = Scale(root: .Eb, do: .flat,
                          re: .natural,
                          mi: .natural,
                          fa: .flat,
                          sol: .flat,
                          la: .natural,
                          ti: .natural)
    static let E = Scale(root: .E, do: .natural,
                         re: .sharp,
                         mi: .sharp,
                         fa: .natural,
                         sol: .natural,
                         la: .sharp,
                         ti: .sharp)
    static let F = Scale(root: .F, do: .natural,
                         re: .natural,
                         mi: .natural,
                         fa: .flat,
                         sol: .natural,
                         la: .natural,
                         ti: .natural)
    static let Fsharp = Scale(root: .Fsharp, do: .sharp,
                          re: .sharp,
                          mi: .sharp,
                          fa: .natural,
                          sol: .sharp,
                          la: .sharp,
                          ti: .sharp)
    static let Gb = Scale(root: .Gb, do: .flat,
                          re: .flat,
                          mi: .flat,
                          fa: .flat,
                          sol: .flat,
                          la: .flat,
                          ti: .natural)
    static let G = Scale(root: .G, do: .natural,
                         re: .natural,
                         mi: .natural,
                         fa: .natural,
                         sol: .natural,
                         la: .natural,
                         ti: .sharp)
    static let Gsharp = Scale(root: .Gsharp, do: .sharp,
                          re: .sharp,
                          mi: .sharp,
                          fa: .sharp,
                          sol: .sharp,
                          la: .sharp,
                          ti: .doubleSharp)
    static let Ab = Scale(root: .Ab, do: .flat,
                          re: .flat,
                          mi: .natural,
                          fa: .flat,
                          sol: .flat,
                          la: .natural,
                          ti: .natural)
    static let A = Scale(root: .A, do: .natural,
                         re: .natural,
                         mi: .sharp,
                         fa: .natural,
                         sol: .natural,
                         la: .sharp,
                         ti: .sharp)
    static let Asharp = Scale(root: .Asharp, do: .sharp,
                          re: .sharp,
                          mi: .doubleSharp,
                          fa: .sharp,
                          sol: .sharp,
                          la: .doubleSharp,
                          ti: .doubleSharp)
    static let Bb = Scale(root: .Bb, do: .flat,
                          re: .natural,
                          mi: .natural,
                          fa: .flat,
                          sol: .natural,
                          la: .natural,
                          ti: .natural)
    static let B = Scale(root: .B, do: .natural,
                          re: .sharp,
                          mi: .sharp,
                          fa: .natural,
                          sol: .sharp,
                          la: .sharp,
                          ti: .sharp)
}
