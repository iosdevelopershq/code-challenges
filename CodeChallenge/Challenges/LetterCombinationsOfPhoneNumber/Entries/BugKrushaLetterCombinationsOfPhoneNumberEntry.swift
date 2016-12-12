//
//  BugKrusha.swift
//  CodeChallenge
//
//  Created by Jon-Tait Beason on 11/2/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

let bugKrushaLetterCombinationOfPhoneNumberEntry = CodeChallengeEntry<LetterCombinationsOfPhoneNumberChallenge>(name: "bugKrusha") { input in
    return getCombinations(digitString: input)
}




private enum Digit: String {
    case Two = "abc"
    case Three = "def"
    case Four = "ghi"
    case Five = "jkl"
    case Six = "mno"
    case Seven = "pqrs"
    case Eight = "tuv"
    case Nine = "wxyz"
}


private func getCharactersForNumber(number: String) -> Digit? {
    switch number {
    case "2": return Digit.Two
    case "3": return Digit.Three
    case "4": return Digit.Four
    case "5": return Digit.Five
    case "6": return Digit.Six
    case "7": return Digit.Seven
    case "8": return Digit.Eight
    case "9": return Digit.Nine
    default: break
    }
    
    return nil
}

private func getCombinations(digitString: String) -> [String] {
    var arrayOfCharacterSets = [String]()
    for (index, character) in digitString.characters.enumerated() {
        if let charactersForNumber = getCharactersForNumber(number: "\(character)")?.rawValue {
            if index == 0 {
                arrayOfCharacterSets = charactersForNumber.characters.map { "\($0)" }
            } else {
                var tempArray = [String]()
                for char in charactersForNumber.characters {
                    for characterSet in arrayOfCharacterSets {
                        let newString = characterSet + "\(char)"
                        tempArray.append(newString)
                    }
                }
                arrayOfCharacterSets = tempArray
            }
        }
    }
    return arrayOfCharacterSets
}
