//
//  DataMapper.swift
//  Stacks
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

typealias Supplies = [String: SupplyStack]
typealias SupplyStack = [String]
typealias Instruction = (quantity: Int, from: String, to: String)
final class DataMapper {
    static func mapSuppliesAndInstructions(input: String) -> (Supplies, [Instruction]) {
        var supplyLines: [String] = []
        var instructionLines: [String] = []
        var beforeEmptyLine = true
        for line in input.components(separatedBy: "\n") {
            guard !line.isEmpty else { beforeEmptyLine = false; continue }
            if beforeEmptyLine {
                supplyLines.append(line)
            } else {
                instructionLines.append(line)
            }
        }

        let supplies = mapSupplies(lines: supplyLines)
        let instructions = mapInstructions(lines: instructionLines)
        return (supplies, instructions)
    }

    static private func mapSupplies(lines: [String]) -> Supplies {
        guard let lastLine = lines.last else { fatalError("mapping error") }
        var supplies: Supplies = [:]
        var orderedKeys: [String] = []
        for stackIndex in lastLine.replacingOccurrences(of: " ", with: "") {
            let stackKey = String(stackIndex)
            supplies[stackKey] = []
            orderedKeys.append(stackKey)
        }
        for lineIndex in stride(from: lines.count - 2, to: -1, by: -1) {
            let line = Array(lines[lineIndex])
            for (index, key) in orderedKeys.enumerated() {
                let charIndex = index * 4 + 1
                guard line.count > charIndex else { break }
                let box = String(line[charIndex])
                guard box != " " else { continue }
                supplies[key]?.append(box)
            }
        }
        return supplies
    }

    static private func mapInstructions(lines: [String]) -> [Instruction] {
        return lines.map { line in
            let components = line.components(separatedBy: " ")
            guard
                let quantity = Int(components[1])
            else {
                fatalError("mapping error")
            }
            let from = components[3]
            let to = components[5]
            return (quantity: quantity, from: from, to: to)
        }
    }
}
