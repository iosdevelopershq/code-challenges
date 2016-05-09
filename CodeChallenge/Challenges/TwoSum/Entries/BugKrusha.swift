//
//  BugKrusha.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let bugkrushaTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "Jazbo") { input in
    for (index, num) in input.numbers.enumerate() {
        for i in index + 1 ..< input.numbers.count {
            if calculate(input.numbers[i], numTwo: num, calculation: +) == input.target {
                return (index + 1, i + 1)
            }
        }
    }
    return nil
}

private func calculate(numOne: Int, numTwo: Int, calculation: (a: Int, b: Int) -> Int) -> Int {
    return calculation(a: numOne, b: numTwo)
}