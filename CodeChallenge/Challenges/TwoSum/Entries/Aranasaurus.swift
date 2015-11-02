//
//  Aranasaurus.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let aranasaurusTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "Aranasaurus") { input in
    
    var max = Datum(0, 0)
    let mid = input.target / 2
    
    for (i, number) in input.numbers.enumerate() {
        guard number >= 0 && number <= input.target && number >= mid else { continue }
        
        if number > max.number {
            if let diffIndex = input.numbers.indexOf(input.target - number) {
                return (diffIndex + 1, i + 1)
            }
            max = Datum(i, number)
        }
    }
    
    return .None
}

private struct Datum {
    let index: Int
    let number: Int
    
    init(_ index: Int, _ number: Int) {
        self.index = index
        self.number = number
    }
}
