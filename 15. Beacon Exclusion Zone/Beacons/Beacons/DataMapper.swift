//
//  DataMapper.swift
//  Beacons
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

class DataMapper {
    static func mapSensor(line: String) -> Sensor {
        let components = line.components(separatedBy: ":")

        let coord = mapSensorCoord(substring: components[0])
        let beacon = mapBeacon(substring: components[1])

        return Sensor(coord: coord, beacon: beacon)
    }

    private static func mapSensorCoord(substring: String) -> Coordinate {
        let components = substring.components(separatedBy: ",")
        guard
            let x = Int(components[0].replacingOccurrences(of: "    Sensor at x=", with: "")),
            let y = Int(components[1].replacingOccurrences(of: " y=", with: ""))
        else {
            fatalError("")
        }
        return Coordinate(x,y)
    }

    private static func mapBeacon(substring: String) -> Beacon {
        let components = substring.components(separatedBy: ",")
        guard
            let x = Int(components[0].replacingOccurrences(of: " closest beacon is at x=", with: "")),
            let y = Int(components[1].replacingOccurrences(of: " y=", with: ""))
        else {
            fatalError("")
        }
        return Beacon(coord: Coordinate(x,y))
    }
}
