//
//  CodeChallengeTests.swift
//  CodeChallengeTests
//
//  Created by Aryan on 10/21/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import XCTest
@testable import CodeChallenge

class TwoSomeTests: XCTestCase {
    
    // MARK: - Helper -
    
    func generateNumbers(count count: Int, target: Int) -> [Int] {
        var numbers = Array<Int>(count: count, repeatedValue: 1)
        let min = (target / 2)
        let max = (target - min)
        numbers += [min, 1, max]
        return numbers
    }
    
    func evaluateResult(twoSumFunction: ([Int], Int) -> (first: Int, second: Int)?) {
        let target = 9
        let count = 1000
        let numbers = generateNumbers(count: count, target: target)
        let result = twoSumFunction(numbers, target)
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result!.first == count+1)
        XCTAssertTrue(result!.second == count+3)
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
}
