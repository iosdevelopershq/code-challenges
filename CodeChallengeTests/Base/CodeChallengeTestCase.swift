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
    func runTestsForChallenge<ChallengeType: CodeChallengeType>(challenge: ChallengeType) {
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
    
    private func printResults(results: [AccumulatedChallengeResult]) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 5
        formatter.maximumFractionDigits = 5
        for (i, result) in results.enumerate() {
            let total = result.successes + result.failures
            let successRate = Double(result.successes) / Double(total)
            
            print("\(i+1). \(result.name) - \(formatter.stringFromNumber(result.time)!)s [\(successRate * 100)% success rate]")
        }
    }
}

private extension String {
    func padWithCharacter(char: Character, toLength length: Int) -> String {
        let textLength = characters.count
        let paddedCharsCount = (length - textLength) / 2
        let paddedChars = String(count: paddedCharsCount, repeatedValue: char)
        var retValue = "\(paddedChars)\(self)\(paddedChars)"
        while retValue.characters.count < length {
            retValue.append(char)
        }
        return retValue
    }
}
