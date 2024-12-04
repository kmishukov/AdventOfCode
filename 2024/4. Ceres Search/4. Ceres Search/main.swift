//
//  main.swift
//  4. Ceres Search
//
//  Created by Konstantin Mishukov on 04.12.2024.
//

import Foundation

func main() {
    let grid = Mapper.mapGrid(input: Input.text)
    print("xmas count: \(processGrid(grid))")
    print("valid cross count: \(processGrid2(grid))")
}

// Part 1
private func processGrid(_ grid: Grid) -> Int {
    var validXmas: [Xmas] = []
    var possibleXmas: [Xmas] = []

    for i in 0..<grid.count {
        var word = ""
        let row = grid[i]
        for j in 0..<row.count {
            let letter = row[j]
            if letter == "S" {
                let coord = Coordinate(x: j, y: i)
                let newLetter = Letter(value: "S", coord: coord)
                if word == "XMA" {
                    validXmas.append(
                        Xmas.init(horEndsWith: Letter(value: "S", coord: coord))
                    )
                }
                word = "S"
                for coordinate in grid.possibleNextForXmas(coord: coord) {
                    let nextLetter = Letter(value: "A", coord: coordinate)
                    possibleXmas.append(
                        Xmas(first: newLetter, next: nextLetter)
                    )
                }
            } else if letter == "X" {
                let coord = Coordinate(x: j, y: i)
                let newLetter = Letter(value: letter, coord: coord)
                if word == "SAM" {
                    validXmas.append(
                        Xmas.init(horEndsWith: newLetter)
                    )
                }
                word = "X"
                for coordinate in grid.possibleNextForXmas(coord: coord) {
                    let nextLetter = Letter(value: "M", coord: coordinate)
                    possibleXmas.append(
                        Xmas(first: newLetter, next: nextLetter)
                    )
                }
            } else {
                word += letter
            }
        }
    }

    for xmas in possibleXmas {
        if grid.isValidXmas(xmas) {
            validXmas.append(xmas)
        }
    }

    return validXmas.count
}

// Part 2
private func processGrid2(_ grid: Grid) -> Int {
    var validCrosses = 0
    var possibleCrosses: [Letter] = []
    for i in 1..<grid.count - 1 {
        for j in 1..<grid[i].count - 1 {
            if grid[i][j] == "A" {
                possibleCrosses.append(
                    Letter(value: "A", coord: Coordinate(x: j, y: i))
                )
            }
        }
    }
    for possibleCross in possibleCrosses {
        if grid.isValidCross(possibleCross) {
            validCrosses += 1
        }
    }
    return validCrosses
}

main()

