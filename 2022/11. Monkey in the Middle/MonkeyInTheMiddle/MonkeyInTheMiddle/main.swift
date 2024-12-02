//
//  main.swift
//  MonkeyInTheMiddle
//
//  Created by Konstantin Mishukov on 22.12.2022.
//

import Foundation

func main() {
    let monkeys = DataMapper.mapMonkeys(input: Input.text)
    let game = Game(monkeys: monkeys, part: .one)
    game.play(rounds: 20)
    print("Part 1: \(game.monkeyBusiness)")

    let monkeys2 = DataMapper.mapMonkeys(input: Input.text)
    let game2 = Game(monkeys: monkeys2, part: .two)
    game2.play(rounds: 10000)
    print("Part 2: \(game2.monkeyBusiness)")
}

main()

