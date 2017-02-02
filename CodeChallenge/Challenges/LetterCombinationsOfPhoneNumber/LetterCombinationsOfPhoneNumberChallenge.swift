//
//  LetterCombinationsOfPhoneNumberChallenge.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 11/1/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

/**
https://leetcode.com/problems/letter-combinations-of-a-phone-number/
Letter Combinations of a Phone Number

Given a digit string, return all possible letter combinations that the number could represent.

A mapping of digit to letters (just like on the telephone buttons) is given below.

![keypad](http://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Telephone-keypad2.svg/200px-Telephone-keypad2.svg.png)

Input:Digit string "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
*/
struct LetterCombinationsOfPhoneNumberChallenge: CodeChallengeType {
    typealias InputType = String
    typealias OutputType = [String]
    
    let title = "Letter Combinations of Phone Number"
    
    let entries: [CodeChallengeEntry<LetterCombinationsOfPhoneNumberChallenge>] = [
        bugKrushaLetterCombinationOfPhoneNumberEntry,
        LoganWrightLetterCombinationOfPhoneNumberEntry,
        juliand665LetterCombinationOfPhoneNumberEntry
    ]
    
    func generateDataset() -> [InputType] {
        return ["23"]
    }
    
    func verifyOutput(_ output: OutputType, forInput input: InputType) -> Bool {
        guard let expected = verificationDictionary[input] else { return false }
        return output.sorted(by: <) == expected.sorted(by: <)
    }
    
    fileprivate let verificationDictionary = [
        "23": ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
    ]
}
