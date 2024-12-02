//
//  DataMapper.swift
//  MonkeyInTheMiddle
//
//  Created by Konstantin Mishukov on 22.12.2022.
//

import Foundation

enum Method: String {
    case add = "+"
    case multiply = "*"
}

enum OperationValue {
    case old
    case num(Int)
    case error
}

struct Operation {
    let method: Method
    let value: OperationValue

    func execute(num: Int) -> Int {
        switch value {
        case .old:
            return method == .multiply ? num * num : num + num
        case .num(let value):
            return method == .multiply ? num * value : num + value
        case .error:
            return 0
        }
    }
}

final class DataMapper {
    static func mapMonkeys(input: String) -> [Monkey] {
        let rawMonkeys = input.components(separatedBy: "\n\n")
        var monkeys: [Monkey] = []
        for rawMonkey in rawMonkeys {
            let components = rawMonkey.components(separatedBy: "\n")
            guard
                let id = Int(components[0]
                    .replacingOccurrences(of: "Monkey ", with: "")
                    .replacingOccurrences(of: ":", with: "")
                )
            else {
                fatalError("bad input")
            }

            let items = components[1].replacingOccurrences(of: "  Starting items: ", with: "").components(separatedBy: ", ").compactMap { Int($0) }
            let operationComponents = components[2].replacingOccurrences(of: "  Operation: new = old ", with: "").components(separatedBy: " ")

            guard
                let method = Method(rawValue: operationComponents[0]),
                let devider = Int(components[3].replacingOccurrences(of: "  Test: divisible by ", with: "")),
                let trueID = Int(components[4].replacingOccurrences(of: "    If true: throw to monkey ", with: "")),
                let falseID = Int(components[5].replacingOccurrences(of: "    If false: throw to monkey ", with: ""))
            else {
                fatalError("bad operation input")
            }

            let operationValue: OperationValue
            if let operationValueInt = Int(operationComponents[1]) {
                operationValue = OperationValue.num(operationValueInt)
            } else if "old" == operationComponents[1] {
                operationValue = OperationValue.old
            } else {
                operationValue = OperationValue.error
            }

            let monkey = Monkey(id: id, items: items, operation: Operation(method: method, value: operationValue), divider: devider, trueID: trueID, falseID: falseID)
            monkeys.append(monkey)
        }
        return monkeys
    }
}
