import Foundation

private extension Array {
  // Applies func[i] to self[i]
  func mapfuncs(_ funcs: [([Element]) -> Element]) -> [Element] {
    precondition(funcs.count == self.count)
    var result: [Element] = []
    for i in 0..<self.count {
      result.append(funcs[i](self))
    }
    return result
  }
}

let matthijsClockEntry = CodeChallengeEntry<ClockChallenge>(name: "matthijs") { input in

  let output = input.components(separatedBy: ":").map({ Int($0)! }).mapfuncs([
    { x in ((x[0]*60 + x[1])*60 + x[2]) / 120 },
    { x in  (x[1]*60 + x[2]) / 10 },
    { x in   x[2] * 6 },
  ])

  return (output[0], output[1], output[2])
}
