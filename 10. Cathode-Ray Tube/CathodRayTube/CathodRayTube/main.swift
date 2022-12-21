//
//  main.swift
//  CathodRayTube
//
//  Created by Konstantin Mishukov on 21.12.2022.
//

import Foundation

func main() {
    let program = DataMapper.mapInstructions(input: Input.text)
    let device = Device(program: program)
    device.runProgram()

    let sum = device.signalStrength(cycles: [20, 60, 100, 140, 180, 220]).reduce(0, +)
    print("Part 1: \(sum)\n")
    print("Part 2:\n")
    device.drawScreen()
}

main()
