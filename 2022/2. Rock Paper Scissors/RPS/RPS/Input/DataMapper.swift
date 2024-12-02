//
//  DataMapper.swift
//  RPS
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

final class DataMapper {
    static func mapRounds(_ input: String) -> [Round] {
        let lines = input.components(separatedBy: "\n")
        return lines.compactMap { line in
            let components = line.components(separatedBy: " ")
            guard
                let playerOne = PlayerOne(rawValue: components[0]),
                let playerTwo = PlayerTwo(rawValue: components[1])
            else {
                fatalError("Mapping Error")
            }
            return Round(playerOne: playerOne, playerTwo: playerTwo)
        }
    }
}
