//
//  Game.swift
//  MonkeyInTheMiddle
//
//  Created by Konstantin Mishukov on 24.12.2022.
//

import Foundation

final class Game {

    enum Part {
        case one, two
    }

    private let monkeys: [Monkey]
    private let part: Part
    private let module: Int

    var monkeyBusiness: Int {
        let inspected = monkeys.map { $0.inspectionsCount }.sorted(by: >)
        guard inspected.count >= 2 else { return 0 }
        return inspected[0] * inspected[1]
    }

    init(monkeys: [Monkey], part: Part) {
        self.monkeys = monkeys.sorted(by: { $0.id < $1.id })
        self.part = part
        self.module = monkeys.reduce(into: 1, { result, monkey in result *= monkey.divider })
    }

    func play(rounds: Int) {
        for _ in 1...rounds {
            if part == .one {
                for monkey in monkeys {
                    while let (item, monkeyID) = monkey.inspectNextItem() {
                        guard let nextMonkey = monkeys.first(where: { $0.id == monkeyID }) else { fatalError("bad monkey id") }
                        nextMonkey.addItem(item)
                    }
                }
            } else {
                for monkey in monkeys {
                    while let (item, monkeyID) = monkey.inspectNextItem2(module: module) {
                        guard let nextMonkey = monkeys.first(where: { $0.id == monkeyID }) else { fatalError("bad monkey id") }
                        nextMonkey.addItem(item)
                    }
                }
            }
        }
    }
}
