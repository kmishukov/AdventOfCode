//
//  PlayerOne.swift
//  RPS
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

enum PlayerOne: String {
    case rock = "A"
    case paper = "B"
    case scissors = "C"

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
}
