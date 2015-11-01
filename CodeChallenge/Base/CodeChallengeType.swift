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

struct AccumulatedChallengeResult<ChallengeType: CodeChallengeType> {
    let name: String
    let successes: Int
    let failures: Int
    let results: [CodeChallengeResult<ChallengeType>]
    let totalTime: NSTimeInterval
    let averageTime: NSTimeInterval
    
    init(name: String, results: [CodeChallengeResult<ChallengeType>], successes: Int, failures: Int) {
        self.name = name
        self.results = results
        self.successes = successes
        self.failures = failures
        self.totalTime = results.reduce(0) { $0 + $1.time }
        self.averageTime = totalTime / Double(results.count)
    }
    
}

extension CodeChallengeType {
    private typealias ResultType = CodeChallengeResult<Self>
    private typealias OperationType = RunOperation<Self>
    
    typealias AccumulatedResultType = AccumulatedChallengeResult<Self>
    
    func runAll() -> [AccumulatedResultType] {
        let dataset = generateDataset()
        
        let workerQueue = NSOperationQueue()
        workerQueue.maxConcurrentOperationCount = min(entries.count, 30)
        var workers = [OperationType]()
        
        for entry in entries {
            var iterations = [OperationType]()
            for input in dataset {
                for _ in 1...10 {
                    iterations.append(OperationType(entry: entry, input: input))
                }
            }
            workers.appendContentsOf(iterations)
        }
        
        print("Adding \(workers.count) operations to the queue and running them \(workerQueue.maxConcurrentOperationCount) at a time")
        workerQueue.addOperations(workers, waitUntilFinished: true)
        
        var resultsByName = [String: [ResultType]]()
        for worker in workers {
            if resultsByName[worker.entry.name] == nil {
                resultsByName[worker.entry.name] = []
            }
            resultsByName[worker.entry.name]?.append(worker.result)
        }
        
        var accumulatedResults = [AccumulatedResultType]()
        for (name, results) in resultsByName {
            var successes = 0
            var failures = 0
            for result in results {
                if verifyOutput(result.output, forInput: result.input) {
                    successes++
                } else {
                    failures++
                }
            }
            let result = AccumulatedResultType(name: name, results: results, successes: successes, failures: failures)
            accumulatedResults.append(result)
        }
        return accumulatedResults.sort { $0.averageTime < $1.averageTime }
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
