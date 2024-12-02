//
//  Valve.swift
//  Volcanium
//
//  Created by Konstantin Mishukov on 16.12.2022.
//

import Foundation

class Valve {
    let name: String
    let rate: Int
//    let parent: Valve?

//    private let connectionConstraints: [String]
    var connections: [Valve] = []
    let isOpen = false

    init(name: String, rate: Int) {
        self.name = name
        self.rate = rate
    }
}
