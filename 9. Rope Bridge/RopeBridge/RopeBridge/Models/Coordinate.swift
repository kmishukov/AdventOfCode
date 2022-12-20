//
//  Coordinate.swift
//  RopeBridge
//
//  Created by Konstantin Mishukov on 20.12.2022.
//

import Foundation

struct Coordinate {
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func printSelf() {
        print("X: \(x), Y: \(y)")
    }

    func surroundingPoints() -> Set<Coordinate> {
        var points: Set<Coordinate> = []
        for i in self.x - 1...self.x + 1 {
            for j in self.y - 1...self.y + 1 {
                guard !(i == x && j == y) else { continue }
                points.insert(Coordinate(i,j))
            }
        }
        return points
    }

    func inTouchWith(_ coord: Coordinate) -> Bool {
        for i in self.x - 1...self.x + 1 {
            for j in self.y - 1...self.y + 1 {
                if Coordinate(i,j) == coord {
                    return true
                }
            }
        }
        return false
    }
}

extension Coordinate: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
