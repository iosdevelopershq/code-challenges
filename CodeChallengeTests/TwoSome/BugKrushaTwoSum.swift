//
//  BugKrushaTwoSum.swift
//  CodeChallenge
//
//  Created by Jon-Tait Beason on 10/22/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation


class BugKrushaTwoSome: TwoSomeTests {
    
    func testTwoSum() {
        measureBlock { self.evaluateResult(self.bugKrushaTwoSum) }
    }
    
    func calculate(numOne: Int, numTwo: Int, calculation: (a: Int, b: Int) -> Int) -> Int {
        return calculation(a: numOne, b: numTwo)
    }
    
    func bugKrushaTwoSum(numbers: [Int], total: Int) -> (Int, Int)? {
        for (index, num) in numbers.enumerate() {
            for var i = index + 1; i < numbers.count; i++ {
                if calculate(numbers[i], numTwo: num, calculation: +) == total {
                    return (index + 1, i + 1)
                }
            }
        }
        return nil
    }
    
}