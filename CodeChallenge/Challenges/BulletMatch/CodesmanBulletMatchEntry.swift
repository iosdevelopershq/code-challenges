//
//  CodesmanBulletMatchEntry.swift
//  CodeChallenge
//
//  Created by Tom Holland on 1/6/17.
//  Copyright © 2017 iosdevelopers. All rights reserved.
//

import Foundation

let codesmanBulletMatchEntry = CodeChallengeEntry<BulletChallenge>(name: "codesman") { input in
    let weapon = input.0
    var cartridge = input.1
    
    for _ in cartridge.characters {
        guard cartridge != weapon else { return true }
        // Rotate the cartridge one scratch and try again!
        cartridge.insert(cartridge.remove(at: cartridge.startIndex), at: cartridge.endIndex)
    }
    return false
}
