//
//  TwoSumChallenge.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/28/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

/*
Given an array of integers, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.

You may assume that each input would have exactly one solution.

Input: numbers={2, 7, 11, 15}, target=9
Output: index1=1, index2=2
*/
struct TwoSumChallenge: CodeChallengeType {
    typealias InputType = (numbers: [Int], target: Int)
    typealias OutputType = (first: Int, second: Int)?
    
    let title = "Two Sum Challenge"
    
    let entries: [CodeChallengeEntry<TwoSumChallenge>] = [
        alexPersianTwoSumEntry,
        aranasaurusTwoSumEntry,
        aryaxtTwoSumEntry,
        bugkrushaTwoSumEntry,
        ianKeenTwoSumEntry,
        loganTwoSumEntry,
        mosabTwoSumEntry,
        nuudlesTwoSumEntry
    ]
    
    func generateDataset() -> [InputType] {
        return [InputType(numbers: numbers, target: target)]
    }
    
    func verifyOutput(_ output: OutputType, forInput input: InputType) -> Bool {
        guard let output = output else { return false }
        return (numbers[output.first - 1] + numbers[output.second - 1] == target)
    }
}

private let target = 9
private let numbers: [Int] = {
    let count = 1000
    var numbers = [Int]()
    for _ in 1...count {
        // target / 3 so that no 2 of these can add together to make target
        numbers.append(Int(arc4random_uniform(UInt32(target/3))))
    }
    
    let min = (target / 2)
    let max = (target - min)
    numbers.insert(min, at: Int(arc4random_uniform(UInt32(numbers.count))))
    numbers.insert(max, at: Int(arc4random_uniform(UInt32(numbers.count))))
    return numbers
}()
