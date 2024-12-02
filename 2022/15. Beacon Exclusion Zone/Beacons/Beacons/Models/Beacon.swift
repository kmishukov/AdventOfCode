//
//  Beacon.swift
//  Beacons
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

struct Beacon: Item {
    var coord: Coordinate
}

extension Beacon: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(coord.x)
        hasher.combine(coord.y)
    }
}
