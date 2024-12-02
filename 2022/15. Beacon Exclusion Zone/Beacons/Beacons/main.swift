//
//  main.swift
//  Beacons
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

func main() {
    let sensors = Input.text.components(separatedBy: "\n").compactMap { DataMapper.mapSensor(line:$0) }
    let tunnel = Tunnels(sensors: sensors, targetRow: 2000000)
    let twoMilRowCoverage = tunnel.targetRowCoverage()
    print("Part 1: \(twoMilRowCoverage)")
    let freq = tunnel.findTuningFrequency()
    print("Part 2: \(freq)")
}

main()
