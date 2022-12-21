//
//  DataMapper.swift
//  CathodRayTube
//
//  Created by Konstantin Mishukov on 21.12.2022.
//

import Foundation

enum Command: String {
    case add = "addx"
    case noop = "noop"
}

final class DataMapper {
    static func mapInstructions(input: String) -> [Instruction] {
        let lines = input.components(separatedBy: "\n")
        return lines.reduce(into: [Instruction]()) { result, line in
            let components = line.components(separatedBy: " ")
            guard let command = Command(rawValue: components[0]) else { fatalError("bad input") }
            if command == .add {
                guard let value = Int(components[1]) else { fatalError("bad input") }
                let add = Add(function: { num in
                    let addition = Int(components[1]) ?? 0
                    return num + addition
                }, value: value)
                result.append(add)
            } else {
                result.append(Noop())
            }
        }
    }
}
