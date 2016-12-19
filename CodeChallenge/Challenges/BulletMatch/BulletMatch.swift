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
