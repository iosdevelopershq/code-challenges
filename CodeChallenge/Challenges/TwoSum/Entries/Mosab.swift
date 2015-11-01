//
//  Mosab.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 11/1/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let mosabTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "Mosab") { input in
    var numbers = input.numbers
    var dictionary : [Int : Int] = [:] //Dictionary to hold numbers and indices
    
    for (index, number) in numbers.enumerate() {
        dictionary[number] = index
    }
    
    return findIndices(&dictionary, numbers: &numbers, target: input.target)
}

private func findIndices(inout map : [Int:Int], inout numbers : [Int], let target : Int) -> (Int, Int)?
{
    for (index, number) in numbers.enumerate()
    {
        if let index2 = map[abs(number - target)]
        {
            return (index + 1, index2 + 1) //offset by 1 so we're not 0 based
        }
    }
    
    return nil
}