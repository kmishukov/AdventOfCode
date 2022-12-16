//
//  Racksack.swift
//  Rucksack
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

struct Racksack {
    private let compartmentOne: [String]
    private let compartmentTwo: [String]

    init(compartmentOne: [String], compartmentTwo: [String]) {
        self.compartmentOne = compartmentOne
        self.compartmentTwo = compartmentTwo
    }

    var commonItem: String {
        Set(compartmentOne).intersection(Set(compartmentTwo)).first ?? ""
    }

    var allItems: [String] {
        compartmentOne + compartmentTwo
    }
}

extension Racksack {
    static func commonItemFor(group racksacks: [Racksack]) -> String {
        guard racksacks.count == 3 else { fatalError("wrong group count") }
        let first = Set(racksacks[0].allItems)
        let second = Set(racksacks[1].allItems)
        let third = Set(racksacks[2].allItems)
        guard
            let commonItem = first.first(where: { second.contains($0) && third.contains($0) })
        else {
            fatalError("no common character")
        }
        return commonItem
    }
}
