//
//  IanKeen.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 11/1/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let ianKeenTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "IanKeen") { input in
    for (index, digit) in input.numbers.enumerated() {
        if let other = input.numbers.index(of: input.target - digit) {
            return (index + 1, Int(other) + 1)
        }
    }
    return nil
}
