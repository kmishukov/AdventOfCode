//
//  Grid.swift
//  HillClimbing
//
//  Created by Konstantin Mishukov on 24.12.2022.
//

import Foundation

final class Grid {
    private let start: Coordinate
    private let end: Coordinate
    private let grid: [[UInt32]]
    private var completed: [Route] = []
    private var record: Int = Int.max

    init(start: Coordinate, end: Coordinate, grid: [[UInt32]]) {
        self.start = start
        self.end = end
        self.grid = grid
    }

    func mapShortestRoute() -> Route? {
        print("Start: \(start.y),\(start.x)")
        print("End: \(end.y),\(end.x)")


        var routesQueue: [Route] = [Route(path: [start])]
        while !routesQueue.isEmpty {
            print(routesQueue.count)
            let route = routesQueue.removeFirst()
            self.generateNextStep(route, queue: &routesQueue)
        }
        return completed.sorted(by: { $0.path.count < $1.path.count }).first 
    }

    func generateNextStep(_ route: Route, queue: inout [Route]) {
        guard let last = route.last else { fatalError("empty route") }
        guard route.length < record else {
            print("removed route bigger than record")
            return
        }
        guard last != end else {
            completed.append(route)
            record = min(route.length - 1, record)
            return
        }
        let posCoords: [Coordinate] = route.availableMoves().compactMap { coord in
            guard coord.x < (grid.first?.count ?? 0) && coord.y < grid.count else { return nil }
            let stepHeightPart = valueFor(coord).subtractingReportingOverflow(valueFor(last))
            guard !stepHeightPart.overflow else { return nil }
            return stepHeightPart.partialValue < 2 ? coord : nil
        }

        guard !posCoords.isEmpty else {
//            print(printRoute(route))
            return
        }

//        if posCoords.count > 1 {
////            print("SPLIT")
//        }
        for coord in posCoords {
            let newRoutePath = route.path + [coord]
//            print(newRoutePath.compactMap { coord in
//                let value = valueFor(coord)
//                return UnicodeScalar(Int(value))
//            })
            let route = Route(path: newRoutePath)
            queue.append(route)
        }
    }

//    newRoutePath.compactMap { coord in
//                    let value = valueFor(coord)
//                    return UnicodeScalar(Int(value))
//                }

    private func valueFor(_ coord: Coordinate) -> UInt32 {
        grid[Int(coord.y)][Int(coord.x)]
    }

    private func printRoute(_ route: Route) -> String {
        var rows: String = ""
        for i in 0..<grid.count {
            var row = ""
            for j in 0..<grid[i].count {
//                guard Coordinate(j,i) != start else {
//                    row = row + "🔴"
//                    continue
//                }
//                guard Coordinate(j,i) != end else {
//                    row = row + "🏁"
//                    continue
//                }

                guard !route.path.contains(Coordinate(j,i)) else {
                    row = row + "+"
                    continue 
                }

//                guard let char = UnicodeScalar(Int(grid[i][j])) else { fatalError("bad print") }
                row = row + "-"//String(char)
            }
            rows = rows + row + "\n"
        }
        return rows
    }

//    private func mapRoutes() -> [Route] {
////        var routes: [Route] = []
//        let route = mapRoute(coord: start)
//        return [route]
//    }
//
//    private func mapRoute(coord: Coordinate) -> Route {
//        let route = Route(path: [start])
//        var posCoords: [Coordinate] = []
//        for posCoord in route.possibleMoves(coord: coord) {
//            if grid[Int(posCoord.y)][Int(posCoord.x)] > grid[Int(coord.y)][Int(coord.x)] {
//                posCoords.append(posCoord)
//            }
//        }
//
//
//
//        if posCoords.count == 1 {
//            mapRoute(coord: <#T##Coordinate#>)
//        }
//    }

//    private func mapRoute(_ coord: Coordinate, _ usedCoordinates: Set<Coordinate>, routes: inout [Route]) {
//        let route = Route(path: usedCoordinates)
//        var used = usedCoordinates
//        used.insert(coord)
//    }

}
