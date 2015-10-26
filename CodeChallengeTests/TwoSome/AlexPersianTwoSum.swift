//
//  AlexPersianTwoSome.swift
//  CodeChallenge
//
//  Created by Alex Persian on 10/22/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

class AlexPersianTwoSome: TwoSomeTests {
    
    func testTwoSum() {
        measureBlock { self.evaluateResult(self.alexPersianTwoSum) }
    }
    
    func alexPersianTwoSum(numbers: [Int], target: Int) -> (Int, Int)? {
        /* The classic while loop + double for loops from intro to CS */
        while (true) {
            for (var i: Int = 0; i < numbers.count; i++) {
                for (var j: Int = 0; j < numbers.count; j++) {
                    if ((numbers[i] + numbers[j]) == target) {
                        return (i + 1, j + 1)
                    }
                }
            }
            return (-1, -1)
        }
    }
    
}
