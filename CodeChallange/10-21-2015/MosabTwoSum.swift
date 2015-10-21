//
//  TwoSum.swift
//  
//
//  Created by Mosab Elagha on 10/21/15.
//
//

import Foundation

func twoSum(numbers : [Int], target : Int) -> (Int, Int)
{
    var dictionary : [Int : Int] = [:] //Dictionary to hold numbers and indices
    
    for (index, number) in numbers.enumerate() {
        dictionary[number] = index
    }
    
    return findIndices(&dictionary, numbers: numbers, target: target)
}

func findIndices(inout map : [Int:Int], let numbers : [Int], let target : Int) -> (Int, Int)
{
    for (index, number) in numbers.enumerate()
    {
        print(index)
        if let index2 = map[abs(number - target)]
        {
            return (index + 1, index2 + 1) //offset by 1 so we're not 0 based
        }
    }
    
    return (-1, -1)
}
