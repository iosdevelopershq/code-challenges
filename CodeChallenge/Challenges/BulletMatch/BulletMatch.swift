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
these markings to the ones in any gun to determine if there
is a match. A match means that the bullet was fired from 
that gun.

Given two markings, one from a spent cartridge and the other
from a suspected weapon, both as Strings, return true if they match
and false if they don't.

EXAMPLES:
Match, returns true
"| |||  |   |" and
"| |||  |   |"

Match, returns true though one is rotated. Bullets can be rotated.
Your solution should account for the possible rotation of bullets.
"|| ||| | " and
" | || |||"

Doesn't match, returns false
"| |||  |   |" and
"||| |  |   |"
 
 NOTE: Markings cannot be flipped. 
 "| ||" is not a match for
 "|| |"

Problem adapted from http://bit.ly/2h57Wxe
*/

final class BulletChallenge: CodeChallengeType {
    typealias InputType = (bulletMarkings: String, gunMarkings: String)
    typealias OutputType = Bool
    
    var title = "Bullet Challenge"
    private let separator = "#"
    
    var entries: [CodeChallengeEntry<BulletChallenge>] = [
        bugKrushaBulletMatchEntry,
        codesmanBulletMatchEntry,
        juliand665BulletMatchEntry,
        FlavioSilverioBulletMatchEntry,
    ]
    
    func generateDataset() -> [InputType] {
        let bundle = Bundle(for: BulletChallenge.self)
        guard
            let dataUrl = bundle.url(forResource: "markings_short", withExtension: "json"),
            let data = try? Data(contentsOf: dataUrl),
            let jsonObjects = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let vd = jsonObjects as? [String: Bool]
            else { fatalError() }
        
        verificationData = vd
        let markings = verificationData.keys.map { key -> (String, String) in
            let components = key.components(separatedBy: self.separator)
            let gunMarkings = components[1]
            let bulletMarkings = components[0]
            return (bulletMarkings: bulletMarkings, gunMarkings: gunMarkings)
        }

        return Array(markings)
    }
    
    func verifyOutput(_ output: Bool, forInput input: (bulletMarkings: String, gunMarkings: String)) -> Bool {
        return verificationData[input.bulletMarkings + separator + input.gunMarkings] == output
    }
}

private var verificationData = [String: Bool]()


