//
//  Tunnels.swift
//  Beacons
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

class Tunnels {
    private let sensors: [Sensor]
    private let targetRow: Int

    init(sensors: [Sensor], targetRow: Int) {
        self.sensors = sensors
        self.targetRow = targetRow
    }

    // MARK: - Interface

    func targetRowCoverage() -> Int {
        var coveredX: Set<Int> = []
        var targetRowBeacons: Set<Beacon> = []
        for sensor in sensors {
            if sensor.beacon.coord.y == targetRow {
                targetRowBeacons.insert(sensor.beacon)
            }

            let distanceToTarget = abs(targetRow - sensor.coord.y)
            guard distanceToTarget <= sensor.radius else { continue }
            let side = sensor.radius - distanceToTarget
            for i in (sensor.coord.x - side)...(sensor.coord.x + side) {
                coveredX.insert(i)
            }
        }
        for beacon in targetRowBeacons {
            coveredX.remove(beacon.coord.x)
        }
        return coveredX.count
    }

    func findTuningFrequency() -> Int {
        let limit = 4000000
        var possiblePoints: Set<Coordinate> = []
        for sensor in sensors.sorted(by: { $0.radius > $1.radius }) {
            let filteredPoints = sensor.surroundingPoints.filter { $0.x >= 0 && $0.x <= limit && $0.y >= 0 && $0.y <= limit }
            filteredPoints.forEach { point in
                possiblePoints.insert(point)
            }
        }

        let uncoveredPoints = possiblePoints.filter { point in
            for sensor in sensors {
                if sensor.coversPoint(point) {
                    return false
                }
            }
            return true
        }
        guard
            uncoveredPoints.count == 1,
            let signalCoord = uncoveredPoints.first
        else {
            fatalError("something is bad")
        }

        return signalCoord.x * 4000000 + signalCoord.y
    }
}
