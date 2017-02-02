//
//  juliand665LSWRCEntry.swift
//  CodeChallenge
//
//  Created by Julian Dunskus on 06.01.17.
//  Copyright © 2017 iosdevelopers. All rights reserved.
//

import Foundation

let juliand665LSWRCEntry = CodeChallengeEntry<LongestSubstringWithoutRepeatingCharactersChallenge>(name: "juliand665", block: lswrc)

private func lswrc(in input: String) -> Int {
	var chars: [Character] = []
	var longest = 0
	
	for char in input.characters {
		if chars.contains(char) {
			chars.removeFirst(chars.index(of: char)! + 1)
		}
		chars.append(char)
		longest = max(longest, chars.count)
	}
	
	return longest
}
