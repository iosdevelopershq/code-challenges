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
    typealias InputType
    /// The type that the entry's function will return.
    typealias OutputType
    
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
    func verifyOutput(output: OutputType, forInput input: InputType) -> Bool
}

/// An entry for a `CodeChallengeType`.
struct CodeChallengeEntry<ChallengeType: CodeChallengeType> {
    /// This entry's author's name.
    let name: String
    
    /// The block to be run to evaluate this entry.
    let block: (input: ChallengeType.InputType) -> ChallengeType.OutputType
}

/// A structure to hold the result of a single run of an Entry's `block`.
struct CodeChallengeResult<ChallengeType: CodeChallengeType> {
    /// The name of the Entry's participant
    let name: String
    
    /// The input that generated the result.
    let input: ChallengeType.InputType
    
    /// The output received from the block.
    let output: ChallengeType.OutputType
    
    /// The amount of wall-clock time it took to process the input.
    let time: NSTimeInterval
}

/// A structure to hold the result of running an Entry's `block` multiple times.
struct AccumulatedChallengeResult<ChallengeType: CodeChallengeType> {
    /// The name of the Entry's participant.
    let name: String
    
    /// How many of the runs passed verification.
    let successes: Int
    
    /// How many of the runs did not pass verification.
    let failures: Int
    
    /// The array of individual runs' `CodeChallengeResult`s.
    let results: [CodeChallengeResult<ChallengeType>]
    
    /// The total wall-clock time it took to process all results.
    let totalTime: NSTimeInterval
    
    /// The average wall-clock time a single run took.
    let averageTime: NSTimeInterval
    
    /**
     Create a new AccumulatedChallengeResult from the given set of results. The time properties will be calculated using the given parameters to this init.
    */
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
    
    /**
     Run all of this Challenge's entries using the same generated dataset.
     
     This function calls `generateDataset()` and then runs each input in the dataset through each entry in the `entries` multiple times, concurrently. It then processes all of the `CodeChallengeResult`s into `AcummulatedChallengeResult`s for each participant and returns them sorted by `totalTime`.
     
     - Returns: An array of `AcummulatedChallengeResult`s for each participant sorted by `averageTime`.
    */
    func runAll() -> [AccumulatedResultType] {
        
        // Generate the dataset, everybody gets the same one
        let dataset = generateDataset()
        
        // Make a worker queue so that we can run through everything concurrently and save the runner some time.
        let workerQueue = NSOperationQueue()
        workerQueue.maxConcurrentOperationCount = min(entries.count * dataset.count, 30)
        var workers = [OperationType]()
        
        // For each entry
        for entry in entries {
            var iterations = [OperationType]()
            // Run every input through the entry's block (which happens in the RunOperation's `main()`
            for input in dataset {
                // Run each input through 10 times
                for _ in 1...10 {
                    iterations.append(OperationType(entry: entry, input: input))
                }
            }
            workers.appendContentsOf(iterations)
        }
        
        print("Adding \(workers.count) operations to the queue and running them \(workerQueue.maxConcurrentOperationCount) at a time")
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
                if verifyOutput(result.output, forInput: result.input) {
                    successes++
                } else {
                    failures++
                }
            }
            let result = AccumulatedResultType(name: name, results: results, successes: successes, failures: failures)
            accumulatedResults.append(result)
        }
        
        // Return the accumulated results sorted by average time.
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
