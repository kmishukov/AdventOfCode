//
//  main.swift
//  RPS
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

func main() {
    let rounds = DataMapper.mapRounds(Input.text)
    let result = rounds.reduce(into: 0) { partialResult, round in
        partialResult += round.outcome
    }
    print("Part 1: \(result)")
    let result2 = rounds.reduce(into: 0) { partialResult, round in
        partialResult += round.outcome2
    }
    print("Part 2: \(result2)")
}

main()
