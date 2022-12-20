//
//  Knot.swift
//  RopeBridge
//
//  Created by Konstantin Mishukov on 20.12.2022.
//

import Foundation

final class Knot {
    let id: Int
    var coordinate: Coordinate
    var next: Knot?

    init(id: Int, coordinate: Coordinate, next: Knot?) {
        self.id = id
        self.coordinate = coordinate
        self.next = next
    }
}
