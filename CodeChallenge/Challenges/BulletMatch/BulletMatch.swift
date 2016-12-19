//
//  BulletMatch.swift
//  CodeChallenge
//
//  Created by Jon-Tait Beason on 12/19/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation
/**
Forensic specialists examine spent cartridges for unique
markings left by parts of a gun. They can then compare
these markings to a gun thought to used to fire the
original bullet.

Given two markings, one from a spent cartridge and the other
from a suspected weapon, both as Strings, return 1 if they match
and 0 if they don't.

EXAMPLES:
Match, returns 1
"| |||  |   |" and
"| |||  |   |"

Match, returns 1 though one is rotated. Bullets can be rotated.
Your solution should account for the possible rotation of bullets.
"|| ||| | " and
" | || |||"

Doesn't match, returns 0
"| |||  |   |" and
"||| |  |   |"

Problem adapted from http://bit.ly/2h57Wxe
*/

struct BulletChallenge: CodeChallengeType {
    typealias InputType = (bulleteMarkings: String, gunMarkings: String)
    typealias OutputType = Bool
    
    var title = "Bullet Challenge"
    var entries: [CodeChallengeEntry<BulletChallenge>] = [
    ]
    
    func generateDataset() -> [(bulleteMarkings: String, gunMarkings: String)] {
        return generateMarkings(count: 1000, length: 7)
    }
    
    func verifyOutput(_ output: Bool, forInput input: (bulleteMarkings: String, gunMarkings: String)) -> Bool {
        guard
            let vd = verificationData[input.1]
            else { return false }
        return vd.1
    }
}

private var verificationData = [String: (String, Bool)]()

/**
 Turns bullet markings around to mimic a rotated
 bullet.
 */
private func rotate(markings: String, turns: Int) -> String {
    
    guard turns != 0 else { return markings }
    let offset = markings.index(markings.startIndex, offsetBy: turns)
    
    let prefix = markings.substring(from: offset)
    let suffix = markings.substring(to: offset)
    
    return prefix + suffix
}


fileprivate func generateMarkings(count: Int, length: Int) -> [(String, String)] {
    let characters: [Character] = ["|", " "]
    var verificationData =  [
        // double check these
        "| |||  |   |": ("| |||  |   |", true),
        "| |||  |   |": ("||| |  |   |", false),
        "|| ||| | ": (" | || |||", true)
    ]
    
    var markings = [
        ("| |||  |   |", "| |||  |   |"),
        ("| |||  |   |", "||| |  |   |)"),
        ("|| ||| | ", " | || |||")
    ]
    
    for _ in 0..<count {
        var markingA = ""
        
        for _ in 0..<length {
            markingA.append(characters[rand(below: 2)])
        }
        var markingB = rotate(markings: markingA,
                              turns: rand(below: markingA.characters.count))
        
        if rand(below: 2) == 0 {
            markingB += "| "
            
            verificationData[markingA] = (markingB, false)
            markings.append((markingA, markingB))
            continue
        }
        verificationData[markingA] = (markingB, true)
        markings.append((markingA, markingB))
    }
    return markings
}

fileprivate func rand(below: Int) -> Int {
    return Int(arc4random_uniform(2))
}


