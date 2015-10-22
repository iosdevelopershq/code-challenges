//
//  AranasaurusTwoSum.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/22/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

struct Datum {
    let index: Int
    let number: Int
    
    init(_ index: Int, _ number: Int) {
        self.index = index
        self.number = number
    }
}

func aranasaurusTwoSum(numbers: [Int], targetNumber: Int) -> (Int, Int)? {
    /*
    Given an array of integers, find two numbers such that they add up to a specific target number.
    
    The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.
    
    You may assume that each input would have exactly one solution.
    
    Input: numbers={2, 7, 11, 15}, target=9
    Output: index1=1, index2=2
    */
    
    var max = Datum(0, 0)
    var lessThanHalf = [Datum]()
    var moreThanHalf = [Datum]()
    
    let mid = targetNumber / 2
    
    for (i, number) in numbers.enumerate() {
        guard number >= 0 && number <= targetNumber else { continue }
        
        if number < mid {
            lessThanHalf.append(Datum(i, number))
        } else {
            moreThanHalf.append(Datum(i, number))
        }
        
        if number > max.number {
            max = Datum(i, number)
        }
    }
    
    if let diffIndex = numbers.indexOf(targetNumber - max.number) {
        return (diffIndex + 1, max.index + 1)
    }
    
    for second in moreThanHalf {
        if let diffIndex = numbers.indexOf(targetNumber - second.number) {
            return (diffIndex + 1, second.index)
        }
    }
    
    return .None
}