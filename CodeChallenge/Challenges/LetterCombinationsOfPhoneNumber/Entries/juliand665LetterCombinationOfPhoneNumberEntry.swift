//
//  juliand665LetterCombinationOfPhoneNumberEntry.swift
//  CodeChallenge
//
//  Created by Julian Dunskus on 06.01.17.
//  Copyright © 2017 iosdevelopers. All rights reserved.
//

import Foundation

let juliand665LetterCombinationOfPhoneNumberEntry = CodeChallengeEntry<LetterCombinationsOfPhoneNumberChallenge>(name: "juliand665", block: combinations)

private func combinations(of input: String) -> [String] {
	var combs: [String] = [""]
	
	let expanded = input.characters.flatMap { numbersToLetters[$0] }
	
	for letters in expanded {
		combs = combs.flatMap { prev in
			letters.map { prev.appending($0) }
		}
	}
	
	return combs
}

private let numbersToLetters: [Character: [String]] = [ // explicit declaration reduces compile time
	"0": [" "],
	"1": [""],
	"2": ["a", "b", "c"],
	"3": ["d", "e", "f"],
	"4": ["g", "h", "i"],
	"5": ["j", "k", "l"],
	"6": ["m", "n", "o"],
	"7": ["p", "q", "r", "s"],
	"8": ["t", "u", "v"],
	"9": ["w", "x", "y", "z"],
]
