//
//  PlayerTwo.swift
//  RPS
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

enum PlayerTwo: String {
    case rock = "X"
    case paper = "Y"
    case scissors = "Z"

    var value: Int {
        switch self {
        case .rock:
            return 1
        case .paper:
            return 2
        case .scissors:
            return 3
        }
    }

    var elfScenario: PlayerElf {
        switch self {
        case .rock:
            return .lose
        case .paper:
            return .draw
        case .scissors:
            return .win
        }
    }
}

enum PlayerElf: String {
    case lose = "X"
    case draw = "Y"
    case win = "Z"
}
