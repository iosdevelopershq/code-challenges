//
//  AlexPersian.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let alexPersianTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "AlexPersian") { input in
    for i in 0..<input.numbers.count {
        for j in 0..<input.numbers.count {
            if ((input.numbers[i] + input.numbers[j]) == input.target) {
                return (i + 1, j + 1)
            }
        }
    }
    return nil
}