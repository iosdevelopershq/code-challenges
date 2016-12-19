//
//  BugKrushaBulletMatchEntry.swift
//  CodeChallenge
//
//  Created by Jon-Tait Beason on 12/19/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation

let bugKrushaBulletMatchEntry = CodeChallengeEntry<BulletChallenge>(name: "bugKrusha") { input in
    let count = input.0.characters.count
    
    guard
        count == input.1.characters.count
        else { return false }
    
    var resets = count
    var bulletIndex = 0
    var gunIndex = 0
    var matches = 0
    
    let bulletMarks = input.0.characters.flatMap { String($0) }
    let gunMarks = input.1.characters.flatMap { String($0) }
    
    while resets > 0  {
        if bulletMarks[bulletIndex] == gunMarks[gunIndex] {
            gunIndex += 1
            matches += 1
        } else {
            gunIndex = 0
            resets -= 1
            matches = 0
        }
        
        bulletIndex += 1
        bulletIndex %= count
        if matches == count { return true }
    }
    return false
}
