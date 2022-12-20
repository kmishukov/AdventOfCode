//
//  DataMapper.swift
//  RopeBridge
//
//  Created by Konstantin Mishukov on 20.12.2022.
//

import Foundation

final class DataMapper {
    static func mapMotionSeries(input: String) -> [Motion] {
        let lines = input.components(separatedBy: "\n")
        return lines.reduce(into: [Motion]()) { result, line in
            let components = line.components(separatedBy: " ")
            guard
                components.count == 2,
                let direction = MotionDirection(rawValue: components[0]),
                let numberOfSteps = Int(components[1])
            else {
                fatalError("bad input")
            }
            result.append(Motion(direction: direction, steps: numberOfSteps))
        }
    }
}
