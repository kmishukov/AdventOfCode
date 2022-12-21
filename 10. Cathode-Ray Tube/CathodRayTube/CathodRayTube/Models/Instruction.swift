//
//  Instruction.swift
//  CathodRayTube
//
//  Created by Konstantin Mishukov on 21.12.2022.
//

import Foundation

protocol Instruction {
    var function: ((Int) -> Int)? { get }
    var cycles: Int { get }
}

struct Add: Instruction {
    let function: ((Int) -> Int)?
    let value: Int
    let cycles = 2
}

struct Noop: Instruction {
    let function: ((Int) -> Int)? = nil
    let cycles = 1
}
