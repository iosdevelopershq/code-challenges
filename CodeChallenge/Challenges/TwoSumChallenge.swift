//
//  TwoSumChallenge.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/28/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

/*
private let target = 9
private let numbers: [Int] = {
    let count = 10000
    var numbers = [Int]()
    for _ in 1...count {
        // target / 3 so that no 2 of these can add together to make target
        numbers.append(Int(arc4random_uniform(UInt32(target/3))))
    }
    
    let min = (target / 2)
    let max = (target - min)
    numbers.insert(min, atIndex: Int(arc4random_uniform(UInt32(numbers.count))))
    numbers.insert(max, atIndex: Int(arc4random_uniform(UInt32(numbers.count))))
    return numbers
}()

class TwoSumChallenge: CodeChallengeType {
    typealias InputType = (numbers: [Int], target: Int)
    typealias OutputType = (first: Int, second: Int)
    
    let entries: [EntryType] = [
        // Instantiate your entry here
        AranasaurusTwoSum(),
        IanKeenTwoSum()
    ]
    
    func verify(input: EntryType.InputType, output: EntryType.OutputType?) -> Bool {
        guard let output = output else { return false }
        assert((numbers[output.first - 1] + numbers[output.second - 1] == target))
        return true
    }
    
    func generateDataset() -> [EntryType.InputType] {
        return [EntryType.InputType(numbers: numbers, target: target)]
    }
}

struct Datum {
    let index: Int
    let number: Int
    
    init(_ index: Int, _ number: Int) {
        self.index = index
        self.number = number
    }
}

class AranasaurusTwoSum: TwoSumEntry, CodeChallengeEntry {
    var participant: Participant { return .Aranasaurus }
    override func solution(input: InputType) -> OutputType? {
        let numbers = input.0
        let targetNumber = input.1
        
        var max = Datum(0, 0)
        let mid = targetNumber / 2
        
        for (i, number) in numbers.enumerate() {
            guard number >= 0 && number <= targetNumber && number >= mid else { continue }
            
            if number > max.number {
                if let diffIndex = numbers.indexOf(targetNumber - number) {
                    return (diffIndex + 1, i + 1)
                }
                max = Datum(i, number)
            }
        }
        
        return .None
    }
}

class IanKeenTwoSum: TwoSumEntry {
    override func solution(input: InputType) -> OutputType? {
        for (index, digit) in input.numbers.enumerate() {
            if let other = input.numbers.indexOf(input.target - digit) {
                return (index + 1, Int(other) + 1)
            }
        }
        return nil
    }
}
*/