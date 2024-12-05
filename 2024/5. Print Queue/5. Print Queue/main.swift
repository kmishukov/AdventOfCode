//
//  main.swift
//  5. Print Queue
//
//  Created by Konstantin Mishukov on 05.12.2024.
//

import Foundation

private var manual: PrintManual?

func main() {
    manual = Mapper.map(Input.text)
    let (validUpdates, invalidUpdates) = findValidUpdates(in: manual)
    let sumOfValid = sumOfUpdates(validUpdates)
    print(sumOfValid)
    let fixedUpdates = processInvalidUpdates(invalidUpdates)
    let sumOfFixed = sumOfUpdates(fixedUpdates)
    print(sumOfFixed)
}

private func findValidUpdates(in manual: PrintManual?) -> ([Update],[Update]) {
    guard let manual else { return ([],[]) }
    var validUpdates: [Update] = []
    var invalidUpdates: [Update] = []
    for update in manual.updates {
        if isValidUpdate(update) {
            validUpdates.append(update)
        } else {
            invalidUpdates.append(update)
        }
    }

    return (validUpdates, invalidUpdates)
}

private func isValidUpdate(_ update: Update) -> Bool {
    guard let manual else { return false }
    for pageNumber in update {
        let rules = manual.rules.filter { $0.first == pageNumber.key }
        for rule in rules {
            guard let secondPageNumber = update.first(where: { $0.key == rule.second }) else {
                continue
            }
            if secondPageNumber.value < pageNumber.value { return false }
        }
    }
    return true
}

private func sumOfUpdates(_ updates: [Update]) -> Int {
    var sum = 0
    for update in updates {
        sum += update.first { $0.value == (update.count / 2) }?.key ?? 0
    }
    return sum
}

// Part 2
private func processInvalidUpdates(_ invalidUpdates: [Update]) -> [Update] {
    var validUpdates: [Update] = []
    for update in invalidUpdates {
        let sorted = update.sorted(by: {
            sortingRules($0.key, $1.key)
        })
        var fixedUpdate: Update = [:]
        for i in 0..<sorted.count {
            fixedUpdate[sorted[i].key] = i
        }
        validUpdates.append(fixedUpdate)
    }
    return validUpdates
}

private func sortingRules(_ num1: Int, _ num2: Int) -> Bool {
    guard let manual else { return false }
    if manual.rules.contains(where: { $0.first == num1 && $0.second == num2 }) { return true }
    if manual.rules.contains(where: { $0.first == num2 && $0.second == num1 }) { return false }
    return false
}

main()

extension Update {
    func printUpdate() {
        var arr: [Int] = []
        for i in 0..<self.values.count {
            guard let num = first(where: { $0.value == i })?.key else { continue }
            arr.append(num)
        }
        print(arr)
    }
}
