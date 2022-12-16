//
//  DataMapper.swift
//  Rucksack
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

final class DataMapper {
    static func mapRacksack(line: String) -> Racksack {
        let mid = line.count / 2
        let items = line.map { String($0) }
        return Racksack(compartmentOne: Array(items[0..<mid]), compartmentTwo: Array(items[mid..<items.count]))
    }
}
