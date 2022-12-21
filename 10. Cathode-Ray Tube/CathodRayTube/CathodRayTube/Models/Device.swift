//
//  Device.swift
//  CathodRayTube
//
//  Created by Konstantin Mishukov on 21.12.2022.
//

import Foundation

final class Device {
    private let program: [Instruction]

    init(program: [Instruction]) {
        self.program = program
    }

    private var executionLog: [Int: Int] = [:]
    private var currentCycle: Int = 1
    private var currentValue: Int = 1

    private var screenLines: [[String]] = []

    func runProgram() {
        for instruction in program {
            for _ in 0..<instruction.cycles {
                addSymbol()
                executionLog[currentCycle] = currentValue
                currentCycle += 1
            }
            if let function = instruction.function {
                currentValue = function(currentValue)
            }
        }
    }

    func signalStrength(cycle: Int) -> Int {
        guard let value = executionLog[cycle] else { fatalError("bad cycle") }
        return value * cycle
    }

    func signalStrength(cycles: [Int]) -> [Int] {
        return cycles.reduce(into: [Int]()) { result, cycle in
            result.append(signalStrength(cycle: cycle))
        }
    }

    private func addSymbol() {
        let row = (currentCycle - 1) / 40
        let newSymbol = ((currentValue - 1)...(currentValue+1)).contains((currentCycle - 1) % 40) ? "#" : "."
        if screenLines.count > row {
            screenLines[row].append(newSymbol)
        } else {
            screenLines.append([newSymbol])
        }
    }

    func drawScreen() {
        for line in screenLines {
            print(line.joined())
        }
    }
}
