//
//  Coordinate.swift
//  Beacons
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

struct Coordinate {
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

// MARK: - Hashable
extension Coordinate: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
