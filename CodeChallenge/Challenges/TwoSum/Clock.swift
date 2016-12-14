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

struct ClockChallenge: CodeChallengeType {
    typealias InputType = String
    typealias OutputType = (hourHandeAnlge: Int, minuteHandAngle: Int, secondHandAngle: Int)
    
    var title = "Clock Challenge"
    
    var entries: [CodeChallengeEntry<ClockChallenge>] = [
        
    ]
    
    func verifyOutput(_ output: (hourHandeAnlge: Int, minuteHandAngle: Int, secondHandAngle: Int), forInput input: String) -> Bool {
        guard
            let value = verificationData[input],
            value == output else { return false }
        return true
    }
    
    func generateDataset() -> [String] {
        return ["06:00:00","08:30:00", "10:17:55"]
    }
    
    private var verificationData = [
        "06:00:00": (180, 0, 0),
        "08:30:00": (255, 180, 0),
        "10:17:55": (308, 107, 330)
    ]
}
