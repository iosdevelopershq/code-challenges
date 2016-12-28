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
    typealias InputType = (bulletMarkings: String, gunMarkings: String)
    typealias OutputType = Bool
    
    var title = "Bullet Challenge"
    
    var entries: [CodeChallengeEntry<BulletChallenge>] = [
        bugKrushaBulletMatchEntry
    ]
    
    func generateDataset() -> [(bulletMarkings: String, gunMarkings: String)] {
        return generateMarkings(count: 15000, length: 15)
    }
    
    func verifyOutput(_ output: Bool, forInput input: (bulletMarkings: String, gunMarkings: String)) -> Bool {
        guard
            let vd = verificationData[input.bulletMarkings]
            else { return false }
        return vd.1 == output
    }
}

private var verificationData =  [
    // double check these
    "| |||  |   |": ("| |||  |   |", true),
    "| |||  |  |": ("||| |  |   |", false),
    "|| ||| | ": (" | || |||", true)
]

/**
 Turns bullet markings around to mimic a rotated
 bullet.
 */
private func rotate(marking: String, turns: Int) -> String {
    
    guard turns != 0 else { return marking }
    let offset = marking.index(marking.startIndex, offsetBy: turns)
    
    let prefix = marking.substring(from: offset)
    let suffix = marking.substring(to: offset)
    
    return prefix + suffix
}


fileprivate func generateMarkings(count: Int, length: Int) -> [(String, String)] {
    let characters: [Character] = ["|", " "]
    
    var markings = [
        ("| |||  |   |", "| |||  |   |"),
        ("| |||  |  |", "||| |  |   |)"),
        ("|| ||| | ", " | || |||")
    ]
    
    for _ in 0..<count {
        var bulletMarking = ""
        
        for _ in 0..<length {
            bulletMarking.append(characters[rand(below: 2)])
        }
        
        guard verificationData[bulletMarking] == nil else { continue }
        var gunMarking = rotate(marking: bulletMarking,
                              turns: rand(below: bulletMarking.characters.count))

        
        if rand(below: 2) == 0 {
            gunMarking += "| "
            
            verificationData[bulletMarking] = (gunMarking, false)
            markings.append((bulletMarking, gunMarking))
            continue
        }
        
        verificationData[bulletMarking] = (gunMarking, true)
        markings.append((bulletMarking, gunMarking))
    }
    return markings
}

fileprivate func rand(below: Int) -> Int {
    return Int(arc4random_uniform(2))
}


