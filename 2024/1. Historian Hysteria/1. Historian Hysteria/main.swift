//
//  main.swift
//  1. Historian Hysteria
//
//  Created by Konstantin Mishukov on 02.12.2024.
//

import Foundation

func main() {
    let (arr1, arr2) = DataMapper.mapInputs(Input.text)
//    var diff = 0
//    for i in 0..<arr1.count {
//        diff += abs(arr1[i] - arr2[i])
//    }
//    print(diff)

    var similarity = 0
    var countDict: [Int: Int] = [:]
    for i in 0..<arr1.count {
        if let count = countDict[arr1[i]] {
            similarity += arr1[i] * count
            continue
        } else {
            let count = arr2.compactMap { $0 == arr1[i] ? $0 : nil }.count
            countDict[arr1[i]] = count
            similarity += arr1[i] * count
        }
    }
    print(similarity)
}

main()
