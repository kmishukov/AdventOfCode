//
//  Priority.swift
//  Rucksack
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

final class Priority {
    private static let priorities: [String: Int] = (0..<52).reduce(into: [String: Int](), { partialResult, index in
        let start = index < 26 ? 97 : 65 - 26
        let character = String(UnicodeScalar(start + index)!)
        partialResult[character] = index + 1
    })

    static func priorityFor(_ str: String) -> Int {
        guard let priority = priorities[str] else { fatalError("no priority") }
        return priority
    }
}
