//
//  CodeChallengeType.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

protocol CodeChallengeType {
    typealias InputType
    typealias OutputType
    
    var title: String { get }
    
    var entries: [CodeChallengeEntry<Self>] { get }
    
    func generateDataset() -> [InputType]
    func verifyOutput(output: OutputType, forInput input: InputType) -> Bool
}

struct CodeChallengeEntry<ChallengeType: CodeChallengeType> {
    let name: String
    let block: (input: ChallengeType.InputType) -> ChallengeType.OutputType
    init(name: String, block: (input: ChallengeType.InputType) -> ChallengeType.OutputType) {
        self.name = name
        self.block = block
    }
}

struct AccumulatedChallengeResult {
    let name: String
    let time: NSTimeInterval
    let successes: Int
    let failures: Int
}

extension CodeChallengeType {
    private typealias ResultType = CodeChallengeResult<Self>
    private typealias OperationType = RunOperation<Self>
    
    func runAll() -> [AccumulatedChallengeResult] {
        let dataset = generateDataset()
        
        let workerQueue = NSOperationQueue()
        workerQueue.maxConcurrentOperationCount = min(entries.count, 30)
        var workers = [OperationType]()
        
        for entry in entries {
            let operations: [OperationType] = dataset.map { OperationType(entry: entry, input: $0) }
            workers.appendContentsOf(operations)
        }
        
        workerQueue.addOperations(workers, waitUntilFinished: true)
        
        var resultsByName = [String: [ResultType]]()
        for worker in workers {
            if resultsByName[worker.entry.name] == nil {
                resultsByName[worker.entry.name] = []
            }
            resultsByName[worker.entry.name]?.append(worker.result)
        }
        
        var accumulatedResults = [AccumulatedChallengeResult]()
        for (name, results) in resultsByName {
            let accumulatedTime = results.reduce(0) { $0 + $1.time }
            var successes = 0
            var failures = 0
            for result in results {
                if verifyOutput(result.output, forInput: result.input) {
                    successes++
                } else {
                    failures++
                }
            }
            let result = AccumulatedChallengeResult(name: name, time: accumulatedTime, successes: successes, failures: failures)
            accumulatedResults.append(result)
        }
        return accumulatedResults.sort { $0.time < $1.time }
    }
}

private class RunOperation<ChallengeType: CodeChallengeType>: NSOperation {
    let entry: CodeChallengeEntry<ChallengeType>
    let input: ChallengeType.InputType
    
    var result: CodeChallengeResult<ChallengeType>!
    
    init(entry: CodeChallengeEntry<ChallengeType>, input: ChallengeType.InputType) {
        self.entry = entry
        self.input = input
    }
    
    override func main() {
        let start = NSDate()
        let output = entry.block(input: input)
        let time = -start.timeIntervalSinceNow
        result = CodeChallengeResult(name: entry.name, input: input, output: output, time: time)
    }
}
