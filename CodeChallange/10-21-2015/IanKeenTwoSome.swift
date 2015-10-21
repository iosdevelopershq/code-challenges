//
//  IanKeenTwoSome.swift
//  CodeChallange
//
//  Created by Ian Keen on 21/10/2015.
//  Copyright © 2015 aryaxt. All rights reserved.
//

import Foundation

public func ianKeenTwoSum(numbers: [Int], target: Int) -> (Int, Int)? {
    for digit in numbers {
        if (numbers.contains(target - digit)) {
            return (Int(numbers.indexOf(digit)!) + 1, Int(numbers.indexOf((target - digit))!) + 1)
        }
    }
    return nil
}