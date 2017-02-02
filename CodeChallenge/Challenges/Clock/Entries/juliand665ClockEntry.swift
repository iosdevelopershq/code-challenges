//
//  juliand665ClockEntry.swift
//  CodeChallenge
//
//  Created by Julian Dunskus on 06.01.17.
//  Copyright © 2017 iosdevelopers. All rights reserved.
//

import Foundation

let juliand665ClockEntry = CodeChallengeEntry<ClockChallenge>(name: "juliand665", block: anglesOfHands)

private func anglesOfHands(at input: String) -> (Int, Int, Int) {
	var time = input.components(separatedBy: ":").map { Int($0)! }
	
	time[2] *= 6
	time[1] *= 6
	time[1] += time[2] / 60
	time[0] *= 30
	time[0] += time[1] / 12
	
	return (time[0], time[1], time[2])
}

private func anglesOfHandsNice(at input: String) -> (Int, Int, Int) {
	let secs = input.components(separatedBy: ":").flatMap { Int($0) }.reduce(0) { $0 * 60 + $1 } // @teevee's `scan` would be really nice here
	
	return (secs * 360 / 43200, (secs % 3600) * 360 / 3600, (secs % 60) * 360 / 60)
}
