//
//  CodeChallengeTests.swift
//  CodeChallengeTests
//
//  Created by Aryan on 10/21/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import XCTest
@testable import CodeChallenge

let target = 9
let numbers: [Int] = {
    let count = 1000
    var numbers = [Int]()
    for _ in 1...count {
        // target / 3 so that no 2 of these can add together to make target
        numbers.append(Int(arc4random_uniform(UInt32(target/3))))
    }
    
    let min = (target / 2)
    let max = (target - min)
    numbers.insert(min, atIndex: Int(arc4random_uniform(UInt32(numbers.count))))
    numbers.insert(max, atIndex: Int(arc4random_uniform(UInt32(numbers.count))))
    return numbers
}()

class TwoSomeTests: XCTestCase {
    
    // MARK: - Helper -
    
    func evaluateResult(twoSumFunction: ([Int], Int) -> (first: Int, second: Int)?) {
        let result = twoSumFunction(numbers, target)
        
        XCTAssertNotNil(result)
        XCTAssertTrue(numbers[result!.first - 1] + numbers[result!.second - 1] == target)
    }
    
    // MARK: - User Tests -
    
    func testAryaxtTwoSum() {
        measureBlock { self.evaluateResult(aryaxtTwoSum) }
    }

	func testNuudlesTwoSum() {
		measureBlock { self.evaluateResult(nuudlesTwoSum) }
	}
    
    func testIanKeenTwoSum() {
        measureBlock { self.evaluateResult(ianKeenTwoSum) }
    }
    
    func testLoganTwoSum() {
        measureBlock { self.evaluateResult(loganTwoSum) }
    }
    
    func testMosabTwoSum() {
        measureBlock { self.evaluateResult(mosabTwoSum) }
    }
    
    func testAranasuarusTwoSum() {
        measureBlock { self.evaluateResult(aranasaurusTwoSum) }
    }
    
    func testAlexPersianTwoSum() {
        measureBlock { self.evaluateResult(alexPersianTwoSum) }
    }
    
    func testBugKrushaTwoSum() {
        measureBlock { self.evaluateResult(bugKrushaTwoSum) }
    }
}
