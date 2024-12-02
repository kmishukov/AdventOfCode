//
//  main.swift
//  HillClimbing
//
//  Created by Konstantin Mishukov on 24.12.2022.
//

import Foundation

func main() {
    let grid = DataMapper.mapGrid(input: Input.text)
    let route = grid.mapShortestRoute()
    print("route length: \((route?.length ?? Int.max) - 1)")
}

main()

