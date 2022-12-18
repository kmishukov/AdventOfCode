//
//  main.swift
//  Stacks
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

func main() {
    let (supplies, instructions) = DataMapper.mapSuppliesAndInstructions(input: Input.text)
    let crain = CargoCrain(supplies: supplies, part: .partOne)
    crain.doInstructions(instructions)
    print("Part 1: \(crain.topBoxes())")

    let crain2 = CargoCrain(supplies: supplies, part: .partTWo)
    crain2.doInstructions(instructions)
    print("Part 2: \(crain2.topBoxes())")
}

main()
