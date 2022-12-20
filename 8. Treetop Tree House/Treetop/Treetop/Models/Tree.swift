//
//  Tree.swift
//  Treetop
//
//  Created by Konstantin Mishukov on 19.12.2022.
//

import Foundation

final class Tree {
    var visibleFromOutside = false

    var viewDistanceLeft: Int = 0
    var viewDistanceTop: Int = 0
    var viewDistanceRight: Int = 0
    var viewDistanceBottom: Int = 0

    private(set) var height: Int

    init(height: Int) {
        self.height = height
    }

    var viewScore: Int {
        viewDistanceLeft * viewDistanceTop * viewDistanceRight * viewDistanceBottom
    }
}
