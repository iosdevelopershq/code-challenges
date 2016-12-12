//
//  CodeChallengeType.swift
//  CodeChallenge
//
//  Created by Ryan Arana on 10/31/15.
//  Copyright © 2015 iosdevelopers. All rights reserved.
//

import Foundation

/**
 Protocol for defining a new Challenge.
 
 This protocol defines the Input/Output types for the Entry's `block` property. HINT: Use a tuple for multiple inputs! It also defines the interface that whatever will run the challenges (currently our tests) uses to run the entries and verify their output.
*/
protocol CodeChallengeType {
    /// The type for the input(s) for the challenge.
    associatedtype InputType
    /// The type that the entry's function will return.
    associatedtype OutputType
    
    /// The heading title for this challenge
    var title: String { get }
    
    /// The entries to be run. Participants will need to add their `CodeChallengeEntry` instance to this array in the challeng's definition.
    var entries: [CodeChallengeEntry<Self>] { get }
    
    /**
     A function to generate the dataset that the entries will be run against. Each `InputType` in the returned array will be run by each entry multiple times and then averaged in the results.
    */
    func generateDataset() -> [InputType]
    
    /**
     A function which verifies the output from running an entry's block with the given input.
     
     - Returns: True if the output is valid, false if not.
    */
    func verifyOutput(_ output: OutputType, forInput input: InputType) -> Bool
}

/// An entry for a `CodeChallengeType`.
struct CodeChallengeEntry<ChallengeType: CodeChallengeType> {
    /// This entry's author's name.
    let name: String
    
    /// The block to be run to evaluate this entry.
    let block: (_ input: ChallengeType.InputType) -> ChallengeType.OutputType
}

/// A structure to hold the result of a single run of an Entry's `block`.
struct CodeChallengeResult<ChallengeType: CodeChallengeType> {
    /// The name of the Entry's participant
    let name: String
    
    /// The input that generated the result.
    let input: ChallengeType.InputType
    
    /// The output received from the block. There should be one output in this array for each iteration, and the index will match the corresponding time measurement in the `times` array. NOTE: These should all be the same value, as they are all the result of the entry processing the same input, but we store them all here for just in case.
    let outputs: [ChallengeType.OutputType]
    
    /// The amount of wall-clock time it took to process the input. There should be one time measurment in this array for each iteration, and the index here will match the corresponding output in the `outputs` array.
    let times: [TimeInterval]
    
    /// The number of times the entry was run.
    let iterations: Int
    
    /// The total wall-clock time it took to process input `iterations` times.
    var totalTime: TimeInterval { return times.reduce(0) { $0 + $1 } }
    
    /// The average wall-clock time a single iteration took to process the input.
    var averageTime: TimeInterval {
        // computers don't like dividing by zero.
        guard times.count != 0 else { return TimeInterval.infinity }
        return Double(totalTime) / Double(times.count)
    }
}

/// A structure to hold the result of running an Entry's `block` multiple times.
struct AccumulatedChallengeResult<ChallengeType: CodeChallengeType> {
    /// The name of the Entry's participant.
    let name: String
    
    /// How many total runs does this AccumulatedResult represent.
    let total: Int
    
    /// How many of the runs passed verification.
    let successes: Int
    
    /// How many of the runs did not pass verification.
    let failures: Int
    
    /// The ratio of successes to failures (0.0 - 1.0)
    let successRate: Double
    
    /// The array of individual runs' `CodeChallengeResult`s.
    let results: [CodeChallengeResult<ChallengeType>]
    
    /// The total wall-clock time it took to process all results.
    let totalTime: TimeInterval
    
    /// The average wall-clock time a single iteration took to process its input.
    let averageTime: TimeInterval
    
    /**
     Create a new AccumulatedChallengeResult from the given set of results. The time properties will be calculated using the given parameters to this init.
    */
    init(name: String, results: [CodeChallengeResult<ChallengeType>], successes: Int, failures: Int) {
        self.name = name
        self.results = results
        self.successes = successes
        self.failures = failures
        self.total = successes + failures
        self.totalTime = results.reduce(0) { $0 + $1.totalTime }
        self.successRate = Double(successes) / Double(total)
        
        if total == 0 {
            self.averageTime = TimeInterval.infinity
        } else {
            self.averageTime = Double(results.reduce(0) { $0 + $1.averageTime }) / Double(total)
        }
    }
}

extension CodeChallengeType {
    fileprivate typealias ResultType = CodeChallengeResult<Self>
    fileprivate typealias OperationType = RunOperation<Self>
    
    typealias AccumulatedResultType = AccumulatedChallengeResult<Self>
    
    /**
     Run all of this Challenge's entries using the same generated dataset.
     
     This function calls `generateDataset()` and then runs each input in the dataset through each entry in the `entries` multiple times, concurrently. It then processes all of the `CodeChallengeResult`s into `AcummulatedChallengeResult`s for each participant and returns them sorted by `totalTime`.
     
     - Returns: An array of `AcummulatedChallengeResult`s for each participant sorted by `averageTime`.
    */
    func runAll() -> [AccumulatedResultType] {
        
        // Generate the dataset, everybody gets the same one
        let dataset = generateDataset()
        
        // Make a worker queue so that we can run through everything concurrently and save the runner some time.
        let workerQueue = OperationQueue()
        workerQueue.maxConcurrentOperationCount = 30
        var workers = [OperationType]()
        let iterations = 10
        
        // For each entry
        for entry in entries {
            workers.append(contentsOf: dataset.map { OperationType(entry: entry, input: $0, iterations: iterations) })
        }
        
        print("Adding \(workers.count) operations to the queue and running them \(min(workerQueue.maxConcurrentOperationCount, workers.count)) at a time")
        workerQueue.addOperations(workers, waitUntilFinished: true)
        
        // Gather up all of the results grouped by Participant name.
        var resultsByName = [String: [ResultType]]()
        for worker in workers {
            if resultsByName[worker.entry.name] == nil {
                resultsByName[worker.entry.name] = []
            }
            resultsByName[worker.entry.name]?.append(worker.result)
        }
        
        // Generate AccumulatedResults for each participant
        var accumulatedResults = [AccumulatedResultType]()
        for (name, results) in resultsByName {
            var successes = 0
            var failures = 0
            for result in results {
                for output in result.outputs {
                    if verifyOutput(output, forInput: result.input) {
                        successes += 1
                    } else {
                        failures += 1
                    }
                }
            }
            let result = AccumulatedResultType(name: name, results: results, successes: successes, failures: failures)
            accumulatedResults.append(result)
        }
        
        // Return the accumulated results sorted by average time.
        return accumulatedResults.sorted { $0.averageTime < $1.averageTime }
    }
}

private class RunOperation<ChallengeType: CodeChallengeType>: Operation {
    let entry: CodeChallengeEntry<ChallengeType>
    let input: ChallengeType.InputType
    let iterations: Int
    
    var result: CodeChallengeResult<ChallengeType>!
    
    init(entry: CodeChallengeEntry<ChallengeType>, input: ChallengeType.InputType, iterations: Int) {
        self.entry = entry
        self.input = input
        self.iterations = iterations
    }
    
    override func main() {
        var outputs = Array<ChallengeType.OutputType>()
        var times = Array<TimeInterval>()
        for _ in 1...iterations {
            let start = Date()
            outputs.append(entry.block(input: input))
            times.append(-start.timeIntervalSinceNow)
        }
        result = CodeChallengeResult(name: entry.name, input: input, outputs: outputs, times: times, iterations: iterations)
    }
}
