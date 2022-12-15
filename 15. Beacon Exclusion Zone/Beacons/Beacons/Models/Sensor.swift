//
//  Sensor.swift
//  Beacons
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

struct Sensor: Item {
    let coord: Coordinate
    let beacon: Beacon
    let radius: Int

    init(coord: Coordinate, beacon: Beacon) {
        self.coord = coord
        self.beacon = beacon
        self.radius = abs(coord.x - beacon.coord.x) + abs(coord.y - beacon.coord.y)
    }

    var surroundingPoints: [Coordinate] {
        var points: [Coordinate] = []
        points.append(Coordinate(coord.x - radius - 1, coord.y)) // Center left
        points.append(Coordinate(coord.x + radius + 1, coord.y)) // Center right
        for i in 1...radius + 1 {
            points.append(contentsOf: [
                Coordinate(coord.x - radius - 1 - i, coord.y + i),
                Coordinate(coord.x + radius + 1 - i, coord.y + i),
                Coordinate(coord.x - radius - 1 - i, coord.y - i),
                Coordinate(coord.x + radius + 1 - i, coord.y - i),
            ])
        }
        return points
    }

    func coversPoint(_ coverCoord: Coordinate) -> Bool {
        let dX = abs(coord.x - coverCoord.x)
        let dY = abs(coord.y - coverCoord.y)
        return dX + dY <= radius
    }
}
