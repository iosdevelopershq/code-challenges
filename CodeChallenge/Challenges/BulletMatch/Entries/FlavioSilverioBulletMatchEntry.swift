//
//  FlavioSilverioBulletMatchEntry.swift
//  CodeChallenge
//
//  Created by Flávio Silvério on 31/01/17.
//  Copyright © 2017 iosdevelopers. All rights reserved.
//

import Foundation

let FlavioSilverioBulletMatchEntry = CodeChallengeEntry<BulletChallenge>(name: "flaviodsilverio") { input in
    
    let bulletMarkings = input.0
    var gunMarkings = input.1
    
    for _ in 0...bulletMarkings.characters.count - 1 {
        
        if bulletMarkings == gunMarkings {
            return true
        } else {
            
            gunMarkings.characters.append(gunMarkings.remove(at: gunMarkings.startIndex))
            
            //made this second one to try it, it's way slower than the previous one...
            //            gunMarkings.insert(gunMarkings.remove(
            //                at: gunMarkings.startIndex),
            //                               at: gunMarkings.endIndex)
        }
        
    }
    
    return false
    
}
