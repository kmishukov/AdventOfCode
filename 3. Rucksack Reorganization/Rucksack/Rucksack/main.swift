//
//  main.swift
//  Rucksack
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

func main() {
    let racksacks: [Racksack] = Input.text.components(separatedBy: "\n").compactMap { DataMapper.mapRacksack(line:$0) }
    let result1 = racksacks.reduce(into: 0) { result, racksack in
        let common = racksack.commonItem
        result += Priority.priorityFor(common)
    }
    print("Part 1: \(result1)")
    var result2 = 0
    for i in stride(from: 0, to: racksacks.count - 1, by: 3) {
        let group = racksacks[i..<i+3]
        let commonItem = Racksack.commonItemFor(group: Array(group))
        result2 += Priority.priorityFor(commonItem)
    }
    print("Part 2: \(result2)")
}

main()
