//
//  DataMapper.swift
//  Treetop
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

final class DataMapper {
    static func mapHeightTable(input: String) -> [[Int]] {
        var grid: [[Int]] = []
        let lines = input.components(separatedBy: "\n")
        for line in lines {
            let row = line.compactMap { Int(String($0)) }
            grid.append(row)
        }
        return grid
    }
}
