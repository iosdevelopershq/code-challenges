//
//  juliand665BulletMatchEntry.swift
//  CodeChallenge
//
//  Created by Julian Dunskus on 06.01.17.
//  Copyright © 2017 iosdevelopers. All rights reserved.
//

import Foundation

let juliand665BulletMatchEntry = CodeChallengeEntry<BulletChallenge>(name: "juliand665") { (bullet, gun) in
	var bul = bullet
	
	for _ in 1 ... bul.characters.count {
		// equate
		if bul == gun {
			return true
		}
		// rotate
		bul.characters.append(bul.characters.popFirst()!)
	}
	
	return false
}
