//
//  xmas.swift
//  4. Ceres Search
//
//  Created by Konstantin Mishukov on 04.12.2024.
//

import Foundation

final class Xmas {
    private(set) var letters: [Letter]
    private(set) var nextLetter: Letter?
    private var xDiff: Int {
        letters[1].coord.x - letters[0].coord.x
    }
    let id = UUID()

    var isFullWord: Bool {
        letters.count == 4
    }

    init(first: Letter, next: Letter?) {
        letters = [first]
        nextLetter = next
    }

    func addLetter() {
        guard let nextLetter else {
            fatalError()
        }
        letters.append(nextLetter)
        if letters.count < 4 {
            self.nextLetter = calculateNextLetter()
        }
    }


    private func calculateNextLetter() -> Letter {
        guard let lastCoord = letters.last?.coord else {
            fatalError()
        }
        let coord = Coordinate(x: lastCoord.x + xDiff, y: lastCoord.y + 1)
        return Letter(value: nextSymbol(), coord: coord)
    }

    private func nextSymbol() -> String {
        let word = letters.first?.value == "X" ?
        rightWord : rightWord.reversed()
        return word[letters.count]
    }

    init(horEndsWith letter: Letter) {
        if letter.value == "S" {
            letters = [
                Letter(value: "X", coord: Coordinate(x: letter.coord.x - 3, y: letter.coord.y)),
                Letter(value: "M", coord: Coordinate(x: letter.coord.x - 2, y: letter.coord.y)),
                Letter(value: "A", coord: Coordinate(x: letter.coord.x - 1, y: letter.coord.y)),
                letter
            ]
        } else {
            letters = [
                Letter(value: "S", coord: Coordinate(x: letter.coord.x - 3, y: letter.coord.y)),
                Letter(value: "A", coord: Coordinate(x: letter.coord.x - 2, y: letter.coord.y)),
                Letter(value: "M", coord: Coordinate(x: letter.coord.x - 1, y: letter.coord.y)),
                letter
            ]
        }
    }

    let rightWord = ["X","M","A","S"]
}
