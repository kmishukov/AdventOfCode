//
//  Coordinate.swift
//  HillClimbing
//
//  Created by Konstantin Mishukov on 24.12.2022.
//

import Foundation

struct Coordinate {
    static var zero = Coordinate(0,0)
    let x: UInt32
    let y: UInt32
    init(_ x: UInt32, _ y: UInt32) {
        self.x = x
        self.y = y
    }

    init(_ x: Int, _ y: Int) {
        self.x = UInt32(x)
        self.y = UInt32(y)
    }

    var surroundings: [Coordinate] {
        var surround: [Coordinate] = []
        if x > 0 {
            surround.append(Coordinate(self.x - 1, y))
        }
        surround.append(Coordinate(self.x + 1, y))

        if y > 0 {
            surround.append(Coordinate(x, y - 1))
        }
        surround.append(Coordinate(x, y + 1))

        return surround
    }
}

// MARK: - Hashable
extension Coordinate: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

extension Coordinate: Equatable {
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
