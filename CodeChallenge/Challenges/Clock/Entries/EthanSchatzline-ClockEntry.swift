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
    static let hourTenth: Double = 1.0 / 12.0
    static let hourDegrees: Double = 30.0
    static let secondMinuteTenth: Double = 1.0 / 60.0
    static let minuteDegrees: Double = 6.0
}

let ethanSchatzlineClockEntry = CodeChallengeEntry<ClockChallenge>(name: "ethan.schatzline") {  input in
    
    let components = input.components(separatedBy: ":")
    
    guard components.count == 3,
        let hour = Double(components[0]),
        let minute = Double(components[1]),
        let second = Double(components[2])
        else { fatalError("Bad input") }
    
    let secondPercentage = second * Constants.secondMinuteTenth
    let minutePercentage = minute * Constants.secondMinuteTenth
    let hourPercentage = hour * Constants.hourTenth
    
    let secondAngle = Int(secondPercentage * Constants.maxDegrees)
    
    let minuteDegree = minutePercentage * Constants.maxDegrees
    let minuteOffset = secondPercentage * Constants.minuteDegrees
    let minuteAngle = Int(minuteDegree + minuteOffset)
    
    let hourDegree = hourPercentage * Constants.maxDegrees
    let hourOffset = minutePercentage * Constants.hourDegrees
    let hourAngle = Int(hourDegree + hourOffset)
    
    return (hourAngle, minuteAngle, secondAngle)
}
