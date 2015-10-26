//
//  IanKeenTwoSome.swift
//  CodeChallenge
//
//  Created by Ian Keen on 21/10/2015.
//  Copyright © 2015 aryaxt. All rights reserved.
//

import Foundation

class IanKeenTwoSome: TwoSomeTests {
    
    func testTwoSum() {
        measureBlock { self.evaluateResult(self.ianKeenTwoSum) }
    }

    func ianKeenTwoSum(numbers: [Int], target: Int) -> (Int, Int)? {
        for (index, digit) in numbers.enumerate() {
            if let other = numbers.indexOf(target - digit) {
                return (index + 1, Int(other) + 1)
            }
        }
        return nil
    }
    
}