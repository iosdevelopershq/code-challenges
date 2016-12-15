import Foundation

let brandonShegaClockEntry = CodeChallengeEntry<ClockChallenge>(name: "brandonshega") { input in
  let df = DateFormatter()
  df.dateFormat = "HH:MM:SS"
  guard let date = df.date(from: input) else { return (0, 0, 0) }
  let dateComps = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
  return (0, 0, 0)
}

fileprivate extension DateComponents {
  var hoursToAngle: Int {
    guard let hour = hour else { return 0 }
    return hour * 30
  }

  var minutesToAngle: Int {
    guard let minute = minute else { return 0 }
    return minute * 6
  }

  var secondsToAngle: Int {
    guard let second = second else { return 0 }
    return second * 6
  }

  var handsInAngles: (Int, Int, Int) {
    return (hoursToAngle, minutesToAngle, secondsToAngle)
  }
}
