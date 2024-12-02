//
//  CargoCrain.swift
//  Stacks
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

final class CargoCrain {
    private var supplies: Supplies
    private var part: Part

    init(supplies: Supplies, part: Part) {
        self.supplies = supplies
        self.part = part
    }

    // MARK: - Interface

    func doInstructions(_ instructions: [Instruction]) {
        for inst in instructions {
            doInstruction(inst)
        }
    }

    func topBoxes() -> String {
        var answer = ""
        for i in 1...supplies.keys.count {
            let key = String(i)
            guard let stack = supplies[key] else { fatalError("stack not found") }
            answer.append(stack.last ?? "")
        }
        return answer
    }

    // MARK: - Private

    private func doInstruction(_ inst: Instruction) {
        if part == .partOne {
            for _ in 1...inst.quantity {
                moveCrate(from: inst.from, to: inst.to)
            }
        } else {
            moveCrates(number: inst.quantity, from: inst.from, to: inst.to)
        }
    }

    private func moveCrate(from: String, to: String) {
        guard var stackFrom = supplies[from] else { fatalError("stack not found") }
        let crate = stackFrom.removeLast()
        supplies[from] = stackFrom

        guard var stackTo = supplies[to] else { fatalError("stack not found") }
        stackTo.append(crate)
        supplies[to] = stackTo
    }

    private func moveCrates(number: Int, from: String, to: String) {
        guard var stackFrom = supplies[from] else { fatalError("stack not found") }
        let itemsToMove: [String] = (1...number).map { _ in
            return stackFrom.removeLast()
        }
        supplies[from] = stackFrom

        guard let stackTo = supplies[to] else { fatalError("stack not found") }
        supplies[to] = stackTo + itemsToMove.reversed()
    }
}


// MARK: - Part
extension CargoCrain {
    enum Part {
        case partOne
        case partTWo
    }
}
