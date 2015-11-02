//
//  ExampleChallengeTests.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import XCTest

@testable import CodeChallenge

class ExampleChallengeTests: CodeChallengeTestCase {
    func testExampleEntries() {
        runTestsForChallenge(ExampleCodeChallenge())
    }
}
