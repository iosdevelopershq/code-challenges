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
    func runTestsForChallenge<ChallengeType: CodeChallengeType>(challenge: ChallengeType) {
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
    
    private func printResults<ChallengeType: CodeChallengeType>(results: [AccumulatedChallengeResult<ChallengeType>]) {
        let maxNameLength = results.reduce(0) { max($0, $1.name.characters.count) }
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 5
        formatter.maximumFractionDigits = 5
        for (i, accResult) in results.enumerate() {
            var name = accResult.name
            // try to make the results line up a bit by inserting the correct amount of tabs between the name and the avg based on the maximum name length vs this name's length
            if name.characters.count < maxNameLength {
                let diff = maxNameLength - name.characters.count
                let tabWidth = 5
                let tabsToInsert = Int(ceil(Double(diff)/Double(tabWidth)))
                for _ in 1...tabsToInsert {
                    name.append(Character("\t"))
                }
            }
            print("\(i+1). \(name)\t avg: \(formatter.stringFromNumber(accResult.averageTime)!)s\ttotal: \(formatter.stringFromNumber(accResult.totalTime)!)s\t[\(accResult.successRate * 100)% success rate]")
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
