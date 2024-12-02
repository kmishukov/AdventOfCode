//
//  RangePair.swift
//  CampCleanup
//
//  Created by Konstantin Mishukov on 17.12.2022.
//

import Foundation

struct RangePair {
    let rangeOne: Range<Int>
    let rangeTwo: Range<Int>

    var oneContainsAnother: Bool {
        if rangeOne.count > rangeTwo.count {
            return rangeOne.clamped(to: rangeTwo) == rangeTwo
        } else {
            return rangeTwo.clamped(to: rangeOne) == rangeOne
        } 
    }

    var haveOverlap: Bool {
        rangeOne.overlaps(rangeTwo)
    }

    init(_ rangeOne: Range<Int>,_ rangeTwo: Range<Int>) {
        self.rangeOne = rangeOne
        self.rangeTwo = rangeTwo
    }
}
