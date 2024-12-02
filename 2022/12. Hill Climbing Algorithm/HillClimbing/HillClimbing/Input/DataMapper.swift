//
//  DataMapper.swift
//  HillClimbing
//
//  Created by Konstantin Mishukov on 24.12.2022.
//

import Foundation

final class DataMapper {
    static func mapGrid(input: String) -> Grid {
        var grid: [[UInt32]] = []
        var start: Coordinate = .zero
        var end: Coordinate = .zero
        for (i, line) in input.components(separatedBy: "\n").enumerated() {
            let row: [UInt32] = line.enumerated().map { (j, char) in
                guard let num = char.unicodeScalars.first?.value else { fatalError("bad input") }
                if char == "S" {
                    start = Coordinate(UInt32(j),UInt32(i))
                    guard let startInt = "a".unicodeScalars.first?.value else { fatalError("bad input") }
                    return startInt
                } else if char == "E" {
                    end = Coordinate(j,i)
                    guard let endInt = "z".unicodeScalars.first?.value else { fatalError("bad input") }
                    return endInt
                }
                return num
            }
            grid.append(row)
        }
        return Grid(start: start, end: end, grid: grid)
    }
}
