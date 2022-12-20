//
//  main.swift
//  RopeBridge
//
//  Created by Konstantin Mishukov on 20.12.2022.
//

import Foundation

func main() {
    let motions = DataMapper.mapMotionSeries(input: Input.text)
    let grid = Grid()
    grid.doMotions(motions)
    print("Part 1: \(grid.traceCount())")

    let grid2 = Grid(numberOfKnots: 10)
    grid2.applyMotions(motions)
    print("Part 2: \(grid2.traceCount())")
}

main()

