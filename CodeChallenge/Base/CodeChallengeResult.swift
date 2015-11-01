//
//  CodeChallengeResult.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

struct CodeChallengeResult<ChallengeType: CodeChallengeType> {
    let name: String
    let input: ChallengeType.InputType
    let output: ChallengeType.OutputType
    let time: NSTimeInterval
    
    init(name: String, input: ChallengeType.InputType, output: ChallengeType.OutputType, time: NSTimeInterval) {
        self.name = name
        self.input = input
        self.output = output
        self.time = time
    }
}
