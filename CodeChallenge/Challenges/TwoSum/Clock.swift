//
//  Clock.swift
//  CodeChallenge
//
//  Created by Jon-Tait Beason on 12/13/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation

/**
 Given a time represented as a String, "HH:MM:SS, 
 calculate the angle the hour hand, minute hand,
 and the second hand make clockwise from 12:00:00.
 
 The angles should be returned in a tuple as follows
 (hourHandAngle: Int, minuteHandAngle: Int, secondHandAndle: Int)
 
 
 
 EXAMPLES
 "06:00:00" getAngles returns [180, 0, 0]
 "08:30:00" getAngles returns [255, 180, 0]
 "10:17:55" getAngles returns [308, 107, 330]

 */

struct ClockChallenge: CodeChallengeType {
    typealias InputType = String
    typealias OutputType = (hourHandeAnlge: Int, minuteHandAngle: Int, secondHandAngle: Int)
    
    var title = "Clock Challenge"
    
    func verifyOutput(_ output: (hourHandeAnlge: Int, minuteHandAngle: Int, secondHandAngle: Int), forInput input: String) -> Bool {
        <#code#>
    }
    
    func generateDataset() -> [String] {
        return [""]
    }
}
