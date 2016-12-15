import Foundation

let brandonShegaClockEntry = CodeChallengeEntry<ClockChallenge>(name: "brandonshega") { input in
  let clock = Clock(for: input)
  return clock.timeInAngles
}

fileprivate struct Clock {
  let hour: Double
  let minute: Double
  let second: Double

  init(for date: String) {
    let df = DateFormatter()
    df.dateFormat = "hh:mm:ss"
    guard let date = df.date(from: date) else { fatalError("Bad Time") }
    let dateComps = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
    guard
      let hour = dateComps.hour,
      let minute = dateComps.minute,
      let second = dateComps.second else { fatalError("Bad Time") }
    self.hour = Double(hour)
    self.minute = Double(minute)
    self.second = Double(second)
  }

  var timeInAngles: (Int, Int, Int) {
    let hoursToAngle = Int(hour * 30 + (minute/60 * 30))
    let minutesToAngle = Int(minute * 6 + (second/60 * 6))
    let secondsToAngle = Int(second * 6)
    return (hoursToAngle, minutesToAngle, secondsToAngle)
  }

}
