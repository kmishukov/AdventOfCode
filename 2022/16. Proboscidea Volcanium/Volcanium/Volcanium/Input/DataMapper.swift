//
//  DataMapper.swift
//  Volcanium
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

final class DataMapper {
    static func mapValves(input: String) -> [Valve] {
        var constraintsDict: [String: [String]] = [:]
        let valves: [Valve] = input.components(separatedBy: "\n").reduce(into: [Valve]()) { result, line in
            let (valve, constraints) = mapValve(line: line)
            constraintsDict[valve.name] = constraints
            result.append(valve)
        }

        for valve in valves {
            guard let constraints = constraintsDict[valve.name] else { fatalError("bad connections") }
            for constraint in constraints {
                guard let connectedValve = valves.first(where: { $0.name == constraint }) else { fatalError("bad connections")}
                valve.connections.append(connectedValve)
            }
        }

        return valves
    }

    private static func mapValve(line input: String) -> (Valve, [String]) {
        let components = input.components(separatedBy: ";")
        let firstHalfComp = components[0].components(separatedBy: " ")
        let name = firstHalfComp[1]
        guard let rate = Int(firstHalfComp[4].replacingOccurrences(of: "rate=", with: "")) else {
            fatalError("could not map rate")
        }
        let constraints = components[1]
            .replacingOccurrences(of: " tunnels lead to valves ", with: "")
            .replacingOccurrences(of: " tunnel leads to valve ", with: "")
            .components(separatedBy: ", ")
        return (Valve(name: name, rate: rate), constraints)
    }
}
