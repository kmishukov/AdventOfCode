//
//  letter.swift
//  4. Ceres Search
//
//  Created by Konstantin Mishukov on 04.12.2024.
//


struct Letter: Hashable {
    let value: String
    let coord: Coordinate

    static func == (lhs: Letter, rhs: Letter) -> Bool {
        lhs.value == rhs.value && lhs.coord == rhs.coord
    }
}
