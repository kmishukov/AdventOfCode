//
//  TreeGrid.swift
//  Treetop
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

struct Coordinate: Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

final class TreeGrid {
    private let rawHeights: [[Int]]
    private let trees: [[Tree]]
    private let size: Int
    private var visibleCoordinates: [Coordinate: Tree] = [:]


    init(heightTable: [[Int]]) {
        self.rawHeights = heightTable
        self.size = heightTable.count
        self.trees = rawHeights.compactMap { $0.compactMap { Tree(height: $0) } }
    }

    func visibleTrees() -> Int {
        countVisiblesFromLeft()
        countVisiblesFromTop()
        countVisiblesFromRight()
        countVisiblesFromBottom()

        return trees.flatMap { $0 }.reduce(into: 0) { res, tree in
            if tree.visibleFromOutside { res += 1 }
        }
    }

    func printGrid() {
        for i in 0...size - 1 {
            let row = rawHeights[i].enumerated().compactMap { (index, num) in
                let coord = Coordinate(i, index)
                return visibleCoordinates.keys.contains(coord) ? "⬜️" : "⬛️"
            }.joined()
            print(row)
        }
    }

    func printScores() {
        for i in 0..<size {
            let str = trees[i].map { String($0.viewScore) }.joined()
            print(str)
        }
    }

    func topScore() -> Int {
        var maxim: Int = 0

        let tree = trees.flatMap { $0 }.sorted(by: { $0.viewScore > $1.viewScore })
        

        for row in trees {
            let scores = row.compactMap { $0.viewScore }
            maxim = max(scores.max() ?? 0, maxim)
        }
        return maxim
    }

    private func countVisiblesFromLeft() {
        for i in 0..<size {
            var maxHeightSoFar = trees[i][0].height
            for j in 0..<size {
                let tree = trees[i][j]
                let isOuterRing: Bool = i == 0 || i == size - 1 || j == 0 || j == size - 1
                if isOuterRing {
                    tree.visibleFromOutside = true
                }

                guard j > 0 else {
                    tree.viewDistanceLeft = 0
                    continue
                }


                if tree.height <= maxHeightSoFar {
                    var lowerTrees = 0
                    for k in stride(from: j - 1, to: 0, by: -1) {
                        let prevTree = trees[i][k]
                        if prevTree.height <= tree.height {
                            lowerTrees += 1
                            if prevTree.height == tree.height {
                                break
                            }
                        } else {
                            lowerTrees += 1
                            break
                        }
                    }
                    tree.viewDistanceLeft = max(lowerTrees, 1)
                    continue
                } else {
                    maxHeightSoFar = tree.height
                    tree.visibleFromOutside = true
                    tree.viewDistanceLeft = j
                }
            }
        }
    }

    private func countVisiblesFromTop() {
        for i in 0..<size {
            var maxHeightSoFar = trees[0][i].height
            for j in 0..<size {
                let tree = trees[j][i]
                let isOuterRing: Bool = i == 0 || i == size - 1 || j == 0 || j == size - 1
                if isOuterRing {
                    tree.visibleFromOutside = true
                }

                guard j > 0 else {
                    tree.viewDistanceTop = 0
                    continue
                }


                if tree.height <= maxHeightSoFar {
                    var lowerTrees = 0
                    for k in stride(from: j - 1, to: 0, by: -1) {
                        let prevTree = trees[k][i]
                        if prevTree.height <= tree.height {
                            lowerTrees += 1
                            if prevTree.height == tree.height {
                                break
                            }
                        } else {
                            lowerTrees += 1
                            break
                        }
                    }
                    tree.viewDistanceTop = max(lowerTrees, 1)
                    continue
                } else {
                    maxHeightSoFar = tree.height
                    tree.visibleFromOutside = true
                    tree.viewDistanceTop = j
                }
            }
        }
    }

    private func countVisiblesFromRight() {
        for i in 0..<size {
            var maxHeightSoFar = trees[i][size - 1].height
            for j in stride(from: size - 1, to: 0, by: -1) {
                let tree = trees[i][j]
                let isOuterRing: Bool = i == 0 || i == size - 1 || j == 0 || j == size - 1
                if isOuterRing {
                    tree.visibleFromOutside = true
                }

                guard j < size - 1 else {
                    tree.viewDistanceRight = 0
                    continue
                }

                if tree.height <= maxHeightSoFar {
                    var lowerTrees = 0
                    for k in stride(from: j + 1, to: size, by: 1) {
                        let prevTree = trees[i][k]
                        if prevTree.height <= tree.height {
                            lowerTrees += 1
                            if prevTree.height == tree.height {
                                break
                            }
                        } else {
                            lowerTrees += 1
                            break
                        }
                    }
                    tree.viewDistanceRight = max(lowerTrees, 1)
                    continue
                } else {
                    maxHeightSoFar = tree.height
                    tree.visibleFromOutside = true
                    tree.viewDistanceRight = size - 1 - j
                }
            }
        }
    }

    private func countVisiblesFromBottom() {
        for i in 0..<size {
            var maxHeightSoFar = trees[size - 1][i].height
            for j in stride(from: size - 1, to: 0, by: -1) {
                let tree = trees[j][i]
                let isOuterRing: Bool = i == 0 || i == size - 1 || j == 0 || j == size - 1
                if isOuterRing {
                    tree.visibleFromOutside = true
                }

                guard j < size - 1 else {
                    tree.viewDistanceBottom = 0
                    continue
                }

                if tree.height <= maxHeightSoFar {
                    var lowerTrees = 0
                    for k in stride(from: j + 1, to: size, by: 1) {
                        let prevTree = trees[k][i]
                        if prevTree.height < tree.height {
                            lowerTrees += 1
                        } else if prevTree.height == tree.height {
                            lowerTrees += 1
                            break
                        } else {
                            lowerTrees += 1
                            break
                        }
                    }
                    tree.viewDistanceBottom = max(lowerTrees, 1)
                    continue
                } else {
                    maxHeightSoFar = tree.height
                    tree.visibleFromOutside = true
                    tree.viewDistanceBottom = size - 1 - j
                }
            }
        }
    }

//    private func countVisiblesFromRight(visibleCoords: inout [Coordinate: Tree]) {
//        for i in 1..<size - 1 {
//            var maxHeightSoFar = rawHeights[i][size - 1]
//            for j in stride(from: size-2, to: 1, by: -1) {
//                if rawHeights[i][j] <= maxHeightSoFar {
//                    continue
//                } else {
//                    maxHeightSoFar = rawHeights[i][j]
//
//                    let coord = Coordinate(i,j)
//                    let visibility = visibleCoords[coord] ?? Tree()
//                    visibility.fromRight = j
//                    visibleCoords[coord] = visibility
//                }
//            }
//        }
//    }
//
//    private func countVisiblesFromBottom(visibleCoords: inout [Coordinate: Tree]) {
//        for i in 1..<size - 1 {
//            var maxHeightSoFar = rawHeights[size - 1][i]
//            for j in stride(from: size - 2, to: 1, by: -1) {
//                if rawHeights[j][i] <= maxHeightSoFar {
//                    continue
//                } else {
//                    maxHeightSoFar = rawHeights[j][i]
//                    let coord = Coordinate(j,i)
//                    let visibility = visibleCoords[coord] ?? Tree()
//                    visibility.fromRight = j
//                    visibleCoords[coord] = visibility
//                }
//            }
//        }
//    }

}
