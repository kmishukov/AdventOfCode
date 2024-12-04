//
//  grid.swift
//  4. Ceres Search
//
//  Created by Konstantin Mishukov on 04.12.2024.
//

typealias Grid = [[String]]

extension Grid {
    // Part 1
    func possibleNextForXmas(coord: Coordinate) -> [Coordinate] {
        guard coord.y < count - 3 else { return [] }
        var coordinates: [Coordinate] = []
        if coord.x > 2 {
            coordinates.append(Coordinate(x: coord.x - 1, y: coord.y + 1))
        }
        coordinates.append(Coordinate(x: coord.x, y: coord.y + 1))
        if coord.x < (first?.count ?? 0) - 3 {
            coordinates.append(Coordinate(x: coord.x + 1, y: coord.y + 1))
        }
        return coordinates
    }

    func isValidXmas(_ possibleXmas: Xmas) -> Bool {
        while !possibleXmas.isFullWord {
            guard let nextLetter = possibleXmas.nextLetter else {
                fatalError()
            }
            if self[nextLetter.coord.y][nextLetter.coord.x] == nextLetter.value {
                possibleXmas.addLetter()
            } else {
                return false
            }
        }
        return true
    }

    // Part 2
    func isValidCross(_ center: Letter) -> Bool {
        let centerCoord = center.coord
        let firstDiagonal = [
            self[centerCoord.y - 1][centerCoord.x - 1],
            self[centerCoord.y + 1][centerCoord.x + 1]
        ]
        let secondDiagonal = [
            self[centerCoord.y - 1][centerCoord.x + 1],
            self[centerCoord.y + 1][centerCoord.x - 1]
        ]
        if Set(["M", "S"]).isSubset(of: firstDiagonal) && Set(["M", "S"]).isSubset(of: secondDiagonal) {
            return true
        } else {
            return false
        }
    }
}
