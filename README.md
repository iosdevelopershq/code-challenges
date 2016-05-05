# code-challenges [![Build Status](https://travis-ci.org/iosdevelopershq/code-challenges.svg?branch=AG%2FTravisSupport)](https://travis-ci.org/iosdevelopershq/code-challenges)
Weekly(?) code challenges for the community to complete for learning and fun.

# Submitting an Entry
If you'd like to submit a solution to a challenge you'll do so by creating an instance of `CodeChallengeEntry` which specifies your name and a code block to run with your solution in it.

Every challenge will have an implementation of `CodeChallengeType` which defines the `InputType` and `OutputType` that your solution block will need to take/return. This `CodeChallengeType` implementation should also include comments in it that describe the challenge itself, so it is your one-stop shop for figuring out what you need to do to successfully complete the challenge.

Here's step-by-step instructions on how to get an entry submitted:

1. Fork the repo and clone it to your machine
2. Open the Xcode project and navigate to the CodeChallenge -> Challenges folder of the Challenge you'd like to submit an entry for.
3. Create a new file to put your solution in. Typically it should be named `yourUsername-challengeNameEntry.swift`.
4. In that file instantiate a `CodeChallengeEntry` object into a global named using the following format:

```
let usernameChallengeNameEntry = CodeChallengeEntry<ChallengeNameChallenge>(name: "username") {  input in
  // Your implementation here, returning the appropriate `OutputType`
}
```
5. Navigate to the `ChallengeNameChallenge.swift` file and add the global instance you created to the `Challenge`'s `entries` array.
6. To test your implementation and see how it compares to any previously submitted solutions just run the tests (⌘+U)!
7. Once you're happy with your results commit and push your changes to your fork and submit a Pull-Request back upstream.

## Some notes on etiquette
Given that everybody's submissions all run in the same module and namespace it's good to take a few things into account while writing your solution:

* It's a great idea to have additional `functions` or data structures to use in your implementation but please, if you do, mark them `private` so that they don't pollute the global namespace.
* Don't `print` _anything_. These will probably get flagged when you submit your PR, but save us a step and just don't commit 'em (or use custom breakpoints to do the trick ;) )! Currently we use the debug console from the test runs to output the results of the challenge runs, so the less console noise the better.

# Submitting a new Challenge

In order to submit a new challenge you'll need to create an implementation of `CodeChallengeType`. This protocol defines:
 * The input and output types for the entries' `block` property
 * A title for the challenge
 * The Array of entries that will be run (you just have to make an empty array of the appropriate type: `[CodeChallengeEntry<YourCodeChallenge>]`)
 * A function to generate the dataset which is just an array of `InputTypes` which will be fed to each entry over multiple iterations to run the challenge.
 * A function to verify the output of the entry for a given input.

Your implementation should be named using the following format: `FooChallenge` for a Challenge named Foo. You should also include the description of the challenge as comments in this implementation file.

This Challenge implementation should be created in a subfolder of the Challenges directory and, in this case, the subfolder would be named `Foo` and the file would be `FooChallenge.swift`.

Check out `CodeChallenge/Base/ExampleCodeChallenge.swift` for a very simple challenge, or the TwoSum challenge for a bit more involved example.

Last step is you'll need to add a test file for this challenge. The test mostly writes itself. Just create a new test in `CodeChallengeTests/Challenges/FooTests.swift` which will look approximately like this:

```
@testable import CodeChallenge

class FooTests: CodeChallengeTestCase {
    func testFooEntries() {
        runTestsForChallenge(FooChallenge())
    }
}
```

That's it! Submit a PR and watch everyone toil over your challenge!
