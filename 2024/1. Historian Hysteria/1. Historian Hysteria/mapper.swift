//
//  mapper.swift
//  1. Historian Hysteria
//
//  Created by Konstantin Mishukov on 02.12.2024.
//

import Foundation

final class DataMapper {
    static func mapInputs(_ input: String) -> ([Int], [Int]) {
        let lines = input.components(separatedBy: "\n")
        var arr1: [Int] = []
        var arr2: [Int] = []
        for line in lines {
            let components = line.components(separatedBy: "   ")
            guard
                let first = Int(components[0]),
                let second = Int(components[1])
            else {
                continue
            }
            arr1.append(first)
            arr2.append(second)
        }
        return (arr1.sorted(), arr2.sorted())
    }
}

