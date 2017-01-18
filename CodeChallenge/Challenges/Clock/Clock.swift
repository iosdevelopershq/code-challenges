//
//  Clock.swift
//  CodeChallenge
//
//  Created by Jon-Tait Beason on 12/13/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation

/**
 Given a time represented as a String, "HH:MM:SS",
 calculate the angle the hour hand, minute hand,
 and the second hand make clockwise from 12:00:00.
 
 The angles should be returned in a tuple as follows
 (hourHandAngle: Int, minuteHandAngle: Int, secondHandAndle: Int)
 
 EXAMPLES
 "06:00:00" should return (180, 0, 0)
 "08:30:00" should return  (255, 180, 0)
 "10:17:55" should return (308, 107, 330)
 
 Adapted from http://bit.ly/2gEBhRh
 */

final class ClockChallenge: JSONBasedChallenge {
    typealias InputType = String
    typealias OutputType = (hourHandeAngle: Int, minuteHandAngle: Int, secondHandAngle: Int)
    
    var title = "Clock Challenge"
    
    // no `protected` access level (darn you, swift gods!)
    let fileName = "Clock_dataset"
    var verificationData: [String: Int] = [:]
    
    var entries: [CodeChallengeEntry<ClockChallenge>] = [
        bugKrushaClockEntry,
        FlavioSilverioClockEntry,
        ethanSchatzlineClockEntry,
        brandonShegaClockEntry,
        matthijsClockEntry,
        felixdumitClockEntry,
        juliand665ClockEntry
    ]
    
    // have to declare this explicitly because *of course* tuples are non-nominal and cannot be `Equatable`, despite being able to equate them
    func verifyOutput(_ output: (hourHandeAngle: Int, minuteHandAngle: Int, secondHandAngle: Int), forInput input: String) -> Bool {
        guard let expected = verificationData[input] else { return false }
        return (expected >> 20, expected >> 10 & 0x3ff, expected & 0x3ff) == output
    }
}

/* How I generated the dataset:

func twoDigitString(from num: Int) -> String {
    return num < 10 ? "0\(num)" : "\(num)"
}

for h in 0...43200 {
    if arc4random_uniform(120) == 0 { // strip it down a little
        let m = h % 60
        let s = m % 60
        print("\"\(twoDigitString(from: h / 3600)):\(twoDigitString(from: h / 60 % 60)):\(twoDigitString(from: h % 60))\": \((h * 360 / 43200) << 20 | (m * 360 / 3600) << 10 | s * 360 / 60),")
    }
}

*/
