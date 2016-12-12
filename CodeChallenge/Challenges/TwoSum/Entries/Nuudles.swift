//
//  Nuudles.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 11/1/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let nuudlesTwoSumEntry = CodeChallengeEntry<TwoSumChallenge>(name: "Nuudles") { input in
	var numberToIndex: [Int: Int] = [:]
	for (index, number) in input.numbers.enumerated()
	{
		if let pairIndex = numberToIndex[input.target - number]
		{
			return (first: pairIndex + 1, second: index + 1) // Why not 0 index? Silly
		}
		numberToIndex[number] = index
	}
	return nil
}
