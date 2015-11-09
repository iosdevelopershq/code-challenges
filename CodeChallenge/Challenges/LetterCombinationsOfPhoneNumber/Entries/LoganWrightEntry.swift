//
//  LoganWrightEntry.swift
//  CodeChallenge
//
//  Created by Logan Wright on 11/8/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

// MARK: Entry

typealias PhoneCombinationsTest = CodeChallengeEntry<LetterCombinationsOfPhoneNumberChallenge>
let LoganWrightLetterCombinationOfPhoneNumberEntry =
PhoneCombinationsTest(name: "LoganWright") { possibleCombinationsForPhoneNumber($0) }

// MARK: Solution

private let phoneNumberMap: [String : [String]] = [
    "2" : ["a", "b", "c"],
    "3" : ["d", "e", "f"],
    "4" : ["g", "h", "i"],
    "5" : ["j", "k", "l"],
    "6" : ["m", "n", "o"],
    "7" : ["p", "q", "r", "s"],
    "8" : ["t", "u", "v"],
    "9" : ["w", "x", "y", "z"]
]

func possibleCombinationsForPhoneNumber(phoneNumber: String) -> [String] {
    return phoneNumber
        .characters
        .map { String($0) }
        .flatMap { phoneNumberMap[$0] }
        .reduce([]) { combinations, nextSet in
            guard !combinations.isEmpty else { return nextSet }
            return nextSet.flatMap { letter in
                return combinations.map { $0 + letter }
            }
    }
}
