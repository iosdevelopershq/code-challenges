//
//  juliand665TwoSumEntry.swift
//  CodeChallenge
//
//  Created by Julian Dunskus on 06.01.17.
//  Copyright © 2017 iosdevelopers. All rights reserved.
//

import Foundation

let juliand665TwoSumEntryNice = CodeChallengeEntry<TwoSumChallenge>(name: "juliand665 (swiftier)", block: findPairNice)

private func findPairNice(in nums: [Int], targeting target: Int) -> (Int, Int)? { // O(log n)
	var numbers = nums.enumerated().sorted() { $0.1 < $1.1 } // I assume the closure is making it slower
	var i1 = numbers.startIndex
	var i2 = numbers.endIndex - 1
	
	// how to C
	while true { // solution guaranteed
		let n1 = numbers[i1]
		let n2 = numbers[i2]
		let sum = n1.element + n2.element
		if sum == target {
			return (n1.offset + 1, n2.offset + 1) // O(1)
		} else if sum < target {
			i1 += 1
		} else {
			i2 -= 1
		}
	}
}

let juliand665TwoSumEntryFast = CodeChallengeEntry<TwoSumChallenge>(name: "juliand665 (swifter)", block: findPairFast)

private func findPairFast(in nums: [Int], targeting target: Int) -> (Int, Int)? { // O(log n)
	
	var numbers = nums.sorted()
	var i1 = numbers.startIndex
	var i2 = numbers.endIndex - 1
	
	// how to C
	while true { // solution guaranteed
		let n1 = numbers[i1]
		let n2 = numbers[i2]
		let sum = n1 + n2
		if sum == target {
			return (nums.index(of: n1)! + 1, nums.index(of: n2)! + 1) // O(n)
			// darn you, indices! sorting .enumerated() instead seems to be slower :(
		} else if sum < target {
			i1 += 1
		} else {
			i2 -= 1
		}
	}
}

let juliand665TwoSumEntryUgly = CodeChallengeEntry<TwoSumChallenge>(name: "juliand665 (hardcoded)", block: findPairUgly)

private func findPairUgly(in nums: [Int], targeting target: Int) -> (Int, Int)? { // O(n)
	
	var first: Int?
	
	for (index, num) in nums.enumerated() {
		if num > 2 {
			if let first = first {
				return (first + 1, index + 1) // why would you not want zero-based indices?
			}
			first = index
		}
	}
	return nil
}
