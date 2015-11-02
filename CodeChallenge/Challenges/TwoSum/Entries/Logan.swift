//
//  Logan.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 11/1/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let loganTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "Logan") { input in
    let lastIdx = input.numbers.count - 1
    for firstIdx in 0..<lastIdx {
        let nextIdx = firstIdx + 1
        for secondIdx in nextIdx...lastIdx where input.numbers[firstIdx] + input.numbers[secondIdx] == input.target {
            return (firstIdx + 1, secondIdx + 1)
        }
    }
    return nil
}