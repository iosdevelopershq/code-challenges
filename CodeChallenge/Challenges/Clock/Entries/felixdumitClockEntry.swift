//
//  felixdumitClockEntry.swift
//  CodeChallenge
//
//  Created by Felix Dumit on 12/22/16.
//  Copyright © 2016 iosdevelopers. All rights reserved.
//

import Foundation

private var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "HH:mm:ss"
    return df
}()

let felixdumitClockEntry = CodeChallengeEntry<ClockChallenge>(name: "felix-dumit") { input in
    if #available(iOS 10.0, *) {
        
        guard let date = dateFormatter.date(from: input) else {
            fatalError("bad input")
        }
        
        func duration(for component: Calendar.Component) -> Measurement<UnitDuration> {
            let cmp = NSCalendar.current.component(component, from: date)
            return Measurement<UnitDuration>(value: Double(cmp), unit: component.durationUnit!)
        }
        
        let totalDuration = duration(for: .hour) + duration(for: .minute) + duration(for: .second)
        
        func clockAngle(unit: UnitDuration) -> Int {
            let percent = (totalDuration % unit.durationForClockFullTurn) / unit.durationForClockFullTurn
            return Int(360 * percent)
        }
    
        return (clockAngle(unit: .hours), clockAngle(unit: .minutes), clockAngle(unit: .seconds))
    
    } else {
        fatalError("this solution is only available for iOS10")
    }
}

@available(iOS 10.0, *)
private func /<D:Dimension>(lhs: Measurement<D>, rhs: Measurement<D>) -> Double {
    return lhs.converted(to: D.baseUnit()).value / rhs.converted(to: D.baseUnit()).value
}

@available(iOS 10.0, *)
private func %<D:Dimension>(lhs: Measurement<D>, rhs: Measurement<D>) -> Measurement<D> {
    let value = lhs.converted(to: D.baseUnit()).value
        .truncatingRemainder(dividingBy: rhs.converted(to: D.baseUnit()).value)
    return Measurement(value: value, unit: D.baseUnit())
}

@available(iOS 10.0, *)
private extension UnitDuration {
    var durationForClockFullTurn: Measurement<UnitDuration> {
        switch self {
        case UnitDuration.hours:
            return Measurement<UnitDuration>(value:12, unit: .hours)
        case UnitDuration.minutes:
            return Measurement<UnitDuration>(value:1, unit: .hours)
        case UnitDuration.seconds:
            return Measurement<UnitDuration>(value: 1, unit: .minutes)
        default: //should not happen
            return Measurement<UnitDuration>(value: 0, unit: .seconds)
        }
    }
}

@available(iOS 10.0, *)
private extension Calendar.Component {
    var durationUnit: UnitDuration? {
        switch self {
        case .hour: return .hours
        case .minute: return .minutes
        case .second: return .seconds
        default: return nil
        }
    }
}
