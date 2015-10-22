//
//  AranasaurusTwoSum.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/22/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

func aranasaurusTwoSum(numbers: [Int], targetNumber: Int) -> (Int, Int)? {
    /*
    Given an array of integers, find two numbers such that they add up to a specific target number.
    
    The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.
    
    You may assume that each input would have exactly one solution.
    
    Input: numbers={2, 7, 11, 15}, target=9
    Output: index1=1, index2=2
    */
    var first = 0
    var second = 0
    var spacer = 1
    var sum = targetNumber - 1
    while sum != targetNumber {
        for (i, number) in numbers.enumerate() {
            guard i < numbers.count - spacer else { spacer++; break }
            first = i
            second = i + spacer
            sum = number + numbers[second]
            if sum == targetNumber { break }
        }
    }
    return (first+1, second+1)
}