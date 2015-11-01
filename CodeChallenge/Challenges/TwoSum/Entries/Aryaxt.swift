//
//  Aryaxt.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let aryaxtTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "Aryaxt") { input in
    for i in 0..<input.numbers.count-1 {
        for j in i+1..<input.numbers.count {
            if input.numbers[i] + input.numbers[j] == input.target {
                return (i+1, j+1)
            }
        }
    }
    
    return nil
}