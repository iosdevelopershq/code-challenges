//
//  LoganTwoSome.swift
//  CodeChallenge
//
//  Created by Logan Wright on 10/21/15.
//  Copyright © 2015 aryaxt. All rights reserved.
//


class LoganTwoSome: TwoSomeTests {
    
    func testTwoSum() {
        measureBlock { self.evaluateResult(self.loganTwoSum) }
    }
    
    func loganTwoSum(numbers: [Int], target: Int) -> (Int, Int)? {
        let lastIdx = numbers.count - 1
        for firstIdx in 0..<lastIdx {
            let nextIdx = firstIdx + 1
            for secondIdx in nextIdx...lastIdx where numbers[firstIdx] + numbers[secondIdx] == target {
                return (firstIdx + 1, secondIdx + 1)
            }
        }
        return nil
    }
    
}
