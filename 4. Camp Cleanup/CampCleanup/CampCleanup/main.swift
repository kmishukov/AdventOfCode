//
//  main.swift
//  CampCleanup
//
//  Created by Konstantin Mishukov on 17.12.2022.
//

import Foundation

func main() {
    let rangePairs = DataMapper.mapPairs(input: Input.text)
    let result = rangePairs.reduce(into: 0) { result, pair in
        result += pair.oneContainsAnother ? 1 : 0
    }
    print("Part 1: \(result)")
    let result2 = rangePairs.reduce(into: 0) { result, pair in
        result += pair.haveOverlap ? 1 : 0
    }
    print("Part 2: \(result2)")
}

main()

