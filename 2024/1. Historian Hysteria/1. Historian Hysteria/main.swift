//
//  main.swift
//  1. Historian Hysteria
//
//  Created by Konstantin Mishukov on 02.12.2024.
//

import Foundation

func main() {
    let (arr1, arr2) = DataMapper.mapInputs(Input.text)
    var diff = 0
    for i in 0..<arr1.count {
        diff += abs(arr1[i] - arr2[i])
    }
    print(diff)
}

main()
