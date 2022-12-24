//
//  Input.swift
//  MonkeyInTheMiddle
//
//  Created by Konstantin Mishukov on 22.12.2022.
//

import Foundation

struct Input {
    static let text: String =
"""
Monkey 0:
  Starting items: 77, 69, 76, 77, 50, 58
  Operation: new = old * 11
  Test: divisible by 5
    If true: throw to monkey 1
    If false: throw to monkey 5

Monkey 1:
  Starting items: 75, 70, 82, 83, 96, 64, 62
  Operation: new = old + 8
  Test: divisible by 17
    If true: throw to monkey 5
    If false: throw to monkey 6

Monkey 2:
  Starting items: 53
  Operation: new = old * 3
  Test: divisible by 2
    If true: throw to monkey 0
    If false: throw to monkey 7

Monkey 3:
  Starting items: 85, 64, 93, 64, 99
  Operation: new = old + 4
  Test: divisible by 7
    If true: throw to monkey 7
    If false: throw to monkey 2

Monkey 4:
  Starting items: 61, 92, 71
  Operation: new = old * old
  Test: divisible by 3
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 5:
  Starting items: 79, 73, 50, 90
  Operation: new = old + 2
  Test: divisible by 11
    If true: throw to monkey 4
    If false: throw to monkey 6

Monkey 6:
  Starting items: 50, 89
  Operation: new = old + 3
  Test: divisible by 13
    If true: throw to monkey 4
    If false: throw to monkey 3

Monkey 7:
  Starting items: 83, 56, 64, 58, 93, 91, 56, 65
  Operation: new = old + 5
  Test: divisible by 19
    If true: throw to monkey 1
    If false: throw to monkey 0
"""
}
