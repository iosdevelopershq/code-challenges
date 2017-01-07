//
//  CodeChallengeTestCase.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import XCTest
@testable import CodeChallenge

class CodeChallengeTestCase: XCTestCase {
    /**
     Run all of the entries for the given challenge and print the results as nicely as we can to the console.
    */
    func runTestsForChallenge<ChallengeType: CodeChallengeType>(_ challenge: ChallengeType) {
        // Do some formatting
        let charWidth = 116
        var headingText = "Calculating results for '\(challenge.title)'"
        let headingTextInnerCount = headingText.characters.count + 2
        headingText = headingText.padWithCharacter(" ", toLength: headingTextInnerCount)
        headingText = headingText.padWithCharacter("=", toLength: charWidth)
        
        let footingInnerText = "fin."
        var footingText = footingInnerText
        footingText = footingText.padWithCharacter(" ", toLength: headingTextInnerCount)
        footingText = footingText.padWithCharacter("=", toLength: charWidth)
        
        print(headingText)
        let results = challenge.runAll()
        printResults(results)
        print(footingText)
    }
    
    fileprivate func printResults<ChallengeType: CodeChallengeType>(_ results: [AccumulatedChallengeResult<ChallengeType>]) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 5
        formatter.maximumFractionDigits = 5

        var names = [String]()
        for (i, result) in results.enumerated() {
            names.append("\(i+1). \(result.name)")
        }
        let maxNameLength = names.reduce(0) { max($0, $1.characters.count) }

        for (i, result) in results.enumerated() {
            // Add spaces to the name to make the avg column line up with all results
            var nameAndNumber = names[i]
            while nameAndNumber.characters.count < maxNameLength {
                nameAndNumber.append(" ")
            }
            print("\(nameAndNumber) avg: \(formatter.string(from: NSDecimalNumber(decimal: Decimal(result.averageTime)))!)s\ttotal: \(formatter.string(from: NSDecimalNumber(decimal: Decimal(result.totalTime)))!)s\t[\(result.successRate * 100)% success rate]")
        }
    }
}

private extension String {
    func padWithCharacter(_ char: Character, toLength length: Int) -> String {
        let textLength = characters.count
        let paddedCharsCount = (length - textLength) / 2
        let paddedChars = String(repeating: String(char), count: paddedCharsCount)
        var retValue = "\(paddedChars)\(self)\(paddedChars)"
        while retValue.characters.count < length {
            retValue.append(char)
        }
        return retValue
    }
}
