//
//  DataMapper.swift
//  CampCleanup
//
//  Created by Konstantin Mishukov on 17.12.2022.
//

import Foundation

typealias Pair = (Range<Int>, Range<Int>)
final class DataMapper {
    static func mapPairs(input: String) -> [RangePair] {
        let lines = input.components(separatedBy: "\n")
        let pairs = lines.map { line in
            let components = line.components(separatedBy: ",")
            guard components.count == 2 else { fatalError("bad input") }
            let first = mapRange(input: components[0])
            let second = mapRange(input: components[1])
            return RangePair(first, second)
        }
        return pairs
    }

    static private func mapRange(input: String) -> Range<Int> {
        let numbers = input.components(separatedBy: "-")
        guard
            numbers.count == 2,
            let from = Int(numbers[0]),
            let to = Int(numbers[1])
        else {
            fatalError("bad input")
        }
        return Range(from...to)
    }
}
