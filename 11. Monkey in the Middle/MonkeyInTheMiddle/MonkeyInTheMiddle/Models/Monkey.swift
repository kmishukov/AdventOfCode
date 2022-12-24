//
//  Monkey.swift
//  MonkeyInTheMiddle
//
//  Created by Konstantin Mishukov on 22.12.2022.
//

import Foundation

class Monkey {
    let id: Int
    private(set) var inspectionsCount: Int = 0
    private(set) var items: [Int]
    private let operation: Operation
    let divider: Int
    private let trueID: Int
    private let falseID: Int

    init(id: Int, items: [Int], operation: Operation, divider: Int, trueID: Int, falseID: Int) {
        self.id = id
        self.items = items
        self.operation = operation
        self.divider = divider
        self.trueID = trueID
        self.falseID = falseID
    }

    func addItem(_ item: Int) {
        items.append(item)
    }

    func inspectNextItem() -> (Item: Int, monkeyID: Int)? {
        guard !items.isEmpty else { return nil }
        inspectionsCount += 1
        let item = items.removeFirst()
        let inpsectedItem = operation.execute(num: item)
        let boredItem = inpsectedItem / 3
        let monkeyID = nextMonkey(worryLevel: boredItem)
//        print("Monkey #\(id) throws \(boredItem) to Monkey #\(monkeyID)")
        return (boredItem, monkeyID)
    }

    func inspectNextItem2(module: Int) -> (Item: Int, monkeyID: Int)? {
        guard !items.isEmpty else { return nil }
        inspectionsCount += 1
        let item = items.removeFirst()
        var inspectedItem = operation.execute(num: item)
        inspectedItem = inspectedItem % module
        let monkeyID = nextMonkey(worryLevel: inspectedItem)
//        print("Monkey #\(id) throws \(boredItem) to Monkey #\(monkeyID)")
        return (inspectedItem, monkeyID)
    }

    private func nextMonkey(worryLevel: Int) -> Int {
        (worryLevel % divider == 0) ? trueID : falseID
    }
}
