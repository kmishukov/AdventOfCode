//
//  Round.swift
//  RPS
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

struct Round {
    let playerOne: PlayerOne
    let playerTwo: PlayerTwo

    init(playerOne: PlayerOne, playerTwo: PlayerTwo) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
    }

    var outcome: Int {
        switch playerOne {
        case .rock:
            switch playerTwo {
            case .rock:
                return playerTwo.value + RoundResult.draw.rawValue
            case .paper:
                return playerTwo.value + RoundResult.win.rawValue
            case .scissors:
                return playerTwo.value + RoundResult.lose.rawValue
            }
        case .paper:
            switch playerTwo {
            case .rock:
                return playerTwo.value + RoundResult.lose.rawValue
            case .paper:
                return playerTwo.value + RoundResult.draw.rawValue
            case .scissors:
                return playerTwo.value + RoundResult.win.rawValue
            }
        case .scissors:
            switch playerTwo {
            case .rock:
                return playerTwo.value + RoundResult.win.rawValue
            case .paper:
                return playerTwo.value + RoundResult.lose.rawValue
            case .scissors:
                return playerTwo.value + RoundResult.draw.rawValue
            }
        }
    }

    var outcome2: Int {
        switch playerTwo.elfScenario {
        case .lose:
            switch playerOne {
            case .rock:
                return PlayerTwo.scissors.value + RoundResult.lose.rawValue
            case .paper:
                return PlayerTwo.rock.value + RoundResult.lose.rawValue
            case .scissors:
                return PlayerTwo.paper.value + RoundResult.lose.rawValue
            }
        case .draw:
            switch playerOne {
            case .rock:
                return PlayerTwo.rock.value + RoundResult.draw.rawValue
            case .paper:
                return PlayerTwo.paper.value + RoundResult.draw.rawValue
            case .scissors:
                return PlayerTwo.scissors.value + RoundResult.draw.rawValue
            }
        case .win:
            switch playerOne {
            case .rock:
                return PlayerTwo.paper.value + RoundResult.win.rawValue
            case .paper:
                return PlayerTwo.scissors.value + RoundResult.win.rawValue
            case .scissors:
                return PlayerTwo.rock.value + RoundResult.win.rawValue
            }
        }
    }
}

enum RoundResult: Int {
    case win = 6
    case lose = 0
    case draw = 3
}
