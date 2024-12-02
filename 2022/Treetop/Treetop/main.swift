//
//  main.swift
//  Treetop
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

func main() {
    let heightTable = DataMapper.mapHeightTable(input: Input.text)
    let treeGrid = TreeGrid(heightTable: heightTable)
    let count = treeGrid.visibleTrees()
//    treeGrid.printGrid()
    print("Part 1: \(count)")
    let topScore = treeGrid.topScore()
    print("Part 2: \(topScore)")
}

main()
