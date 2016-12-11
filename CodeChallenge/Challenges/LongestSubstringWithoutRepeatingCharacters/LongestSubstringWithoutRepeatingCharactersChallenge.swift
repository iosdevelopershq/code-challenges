//
//  LongestSubstringWithoutRepeatingCharactersChallenge.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 11/1/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

/*
https://leetcode.com/problems/longest-substring-without-repeating-characters/
Longest Substring Without Repeating Characters

Given a string, find the length of the longest substring without repeating characters. For example, the longest substring without repeating letters for "abcabcbb" is "abc", which the length is 3. For "bbbbb" the longest substring is "b", with the length of 1.

*/
struct LongestSubstringWithoutRepeatingCharactersChallenge: CodeChallengeType {
    typealias InputType = String
    typealias OutputType = Int
    
    let title = "Longest Substring Without Repeating Characters"
    
    let entries: [CodeChallengeEntry<LongestSubstringWithoutRepeatingCharactersChallenge>] = [
        // Put your entry instance here!
    ]
    
    func generateDataset() -> [InputType] {
        return [
            "abcabcbb",
            "bbbbb"
        ]
    }
    
    func verifyOutput(_ output: OutputType, forInput input: InputType) -> Bool {
        guard let expected = verificationDictionary[input] else { return false }
        return output == expected
    }
    
    fileprivate let verificationDictionary = [
        "abcabcbb": 3,
        "bbbbb": 1
    ]
}
