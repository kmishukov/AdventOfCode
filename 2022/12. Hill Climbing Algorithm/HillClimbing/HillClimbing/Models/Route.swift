//
//  Route.swift
//  HillClimbing
//
//  Created by Konstantin Mishukov on 24.12.2022.
//

import Foundation

final class Route {
    private(set) var path: [Coordinate]
    init(path: [Coordinate]) {
        self.path = path
    }

    // Route Length
    var length: Int {
        path.count
    }

    var last: Coordinate? {
        path.last
    }

    func possibleMoves(coord: Coordinate) -> [Coordinate] {
        coord.surroundings.filter { !path.contains($0)  }
    }

    func availableMoves() -> [Coordinate] {
        guard let last = path.last else { return [] }
        return last.surroundings.filter { !path.contains($0) }
    }
}
