//
//  mapper.swift
//  5. Print Queue
//
//  Created by Konstantin Mishukov on 05.12.2024.
//

typealias Update = [Int: Int]

struct PrintManual {
    let rules: [Rule]
    let updates: [Update]
}

struct Rule: Hashable {
    let first: Int
    let second: Int
}

final class Mapper {
    static func map(_ input: String) -> PrintManual {
        let lines = input.split(separator: "\n")
        var rules: [Rule] = []
        var updates: [Update] = []
        for line in lines {
            if line.contains("|") {
                let numbers = line.split(separator: "|")
                guard let first = Int(numbers[0]), let second = Int(numbers[1]) else { continue }
                rules.append(Rule(first: first, second: second))
            } else {
                guard !line.isEmpty else { continue }
                let numbers = line.split(separator: ",").compactMap { Int($0) }.enumerated().reduce(into: [Int: Int]()) { result, pair in
                    result[pair.element] = pair.offset
                }
                updates.append(numbers)
            }
        }
        return PrintManual(rules: rules, updates: updates)
    }
}
