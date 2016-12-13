//
//  BugKrusha.swift
//  CodeChallenge
//
//  Created by Jon-Tait Beason on 12/13/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation

let bugKrushaClockEntry = CodeChallengeEntry<ClockChallenge>(name: "bugkrusha") { input in
    let timeBreakDown = input.components(separatedBy: ":")
    
    let oneRevolution = 360.0
    let numberOfIntervals = 60.0
    let degreePerHour = 30.0
    let degreePerInterval = oneRevolution / numberOfIntervals
    
    guard
        let seconds = Double(timeBreakDown[2]),
        let minutes = Double(timeBreakDown[1]),
        let hours = Double(timeBreakDown[0])
        else { fatalError() }
    
    
    let secondsAngle = seconds * degreePerInterval
    let minutesAngle = minutes * degreePerInterval + (seconds/numberOfIntervals * degreePerInterval)
    let hoursAngle = hours * degreePerHour + (minutes/numberOfIntervals * degreePerHour)
    
    return (Int(hoursAngle), Int(minutesAngle), Int(secondsAngle))
}
