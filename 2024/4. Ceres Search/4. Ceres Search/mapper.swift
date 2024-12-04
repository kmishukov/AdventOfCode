//
//  mapper.swift
//  4. Ceres Search
//
//  Created by Konstantin Mishukov on 04.12.2024.
//

final class Mapper {
    static func mapGrid(input: String) -> Grid {
        let lines = input.components(separatedBy: "\n")
        var grid: Grid = []
        for line in lines {
            let row = line.reduce(into: [String]()) { partialResult, char in
                partialResult.append(String(char))
            }
            grid.append(row)
        }
        return grid
    }
}
