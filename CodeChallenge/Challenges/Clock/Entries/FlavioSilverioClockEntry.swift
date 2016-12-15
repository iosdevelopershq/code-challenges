//
//  FlavioSilverioClockEntry.swift
//  CodeChallenge
//
//  Created by Flávio Silvério on 15/12/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation

let FlavioSilverioClockEntry = CodeChallengeEntry<ClockChallenge>(name: "flaviodsilverio") { input in

    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm:ss"
    
    guard let date = formatter.date(from: input) else {
        return (Int(0), Int(0), Int(0))
    }
    
    let calendar = Calendar.current
    
    let seconds = calendar.component(.second, from: date)
    let minutesAsSeconds = calendar.component(.minute, from: date) * 60 + seconds
    let hoursAsSeconds = calendar.component(.hour, from: date) * 3600 + minutesAsSeconds
    
    let secondsAngle = Int(360 / 60 * seconds)
    let minutesAngle = Int((Double(minutesAsSeconds) / Double(3600)) * 360)
    let hoursAngle   = Int((Double(hoursAsSeconds) / Double(3600 * 12)) * 360)
    
    return (hoursAngle, minutesAngle, secondsAngle)
}
