//
//  NuudlesTwoSome.swift
//  CodeChallenge
//
//  Created by Christopher Luu on 10/21/15.
//  Copyright © 2015 aryaxt. All rights reserved.
//

import Foundation

func nuudlesTwoSum(numbers: [Int], target: Int) -> (first: Int, second: Int)?
{
	var numberToIndex: [Int: Int] = [:]
	for (index, number) in numbers.enumerate()
	{
		if let pairIndex = numberToIndex[target - number]
		{
			return (first: pairIndex + 1, second: index + 1) // Why not 0 index? Silly
		}
		numberToIndex[number] = index
	}
	return nil
}
