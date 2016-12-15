//
//  EthanSchatzline-ClockEntry.swift
//  CodeChallenge
//
//  Created by Ethan Schatzline on 12/15/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation

private struct Constants {
    
    static let maxDegrees: Double = 360.0
    static let maxHours: Double = 12.0
    static let maxMinutes: Double = 60.0
    static let maxSeconds: Double = 60.0
}

let ethanSchatzlineClockEntry = CodeChallengeEntry<ClockChallenge>(name: "ethan.schatzline") {  input in
    
    let components = input.components(separatedBy: ":")
    
    guard components.count == 3,
        let hour = Double(components[0]),
        let minute = Double(components[1]),
        let second = Double(components[2])
        else { fatalError("Bad input") }
    
    let hourAngle = Int((hour / Constants.maxHours) * Constants.maxDegrees)
    let minuteAngle = Int((minute / Constants.maxMinutes) * Constants.maxDegrees)
    let secondAngle = Int((second / Constants.maxSeconds) * Constants.maxDegrees)
    
    return (hourAngle, minuteAngle, secondAngle)
}
