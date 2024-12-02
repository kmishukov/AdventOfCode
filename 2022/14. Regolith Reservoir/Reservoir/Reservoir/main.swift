//
//  main.swift
//  Reservoir
//
//  Created by Konstantin Mishukov on 14.12.2022.
//

import Cocoa
import Foundation

enum Material: String {
    case air = "⬛️"
    case rock = "⬜️"
    case void = "~"
    case sand = "🟠"
    case sandSource = "+"
}

typealias Coordinate = (x: Int, y: Int)
typealias RockLine = [Coordinate]
var rockLines: [RockLine] = []

var minX: Int = 500
var maxX: Int = 500
var minY: Int = 0
var maxY: Int = 0

final class Cave {

    private let minX: Int
    private let maxX: Int
    private let minY: Int = 0
    private let maxY: Int
    private var verticalSlice: [[Material]] = []
    let inset: Int

    init(minX: Int, maxX: Int, maxY: Int, test: Bool, sideInsets inset: Int) {
        self.minX = minX
        self.maxX = maxX
        self.maxY = maxY
        self.inset = inset
        self.verticalSlice = !test ? createVerticalSlice2(minX: minX, maxX: maxX, maxY: maxY) : createTestVerticalSlice()
    }

    private func createVerticalSlice(minX: Int, maxX: Int, maxY: Int) -> [[Material]] {
        var table: [[Material]] = []
        for y in 0...maxY+1 {
            var row: [Material] = []
            for x in minX-1...maxX+1 {
                let mat: Material = ((x == minX - 1 || x == maxX + 1 || y == maxY + 1) ? .void : ((y == 0 && x == 500) ? .sandSource : .air))
                row.append(mat)
            }
            table.append(row)
        }
        return table
    }

    private func createVerticalSlice2(minX: Int, maxX: Int, maxY: Int) -> [[Material]] {
        var table: [[Material]] = []
        for y in 0...maxY+2 {

            guard y < maxY + 2 else {
                table.append((minX-inset...maxX+inset).map {_ in .rock})
                continue
            }
            var row: [Material] = []
            for x in minX-inset...maxX+inset {
                let mat: Material = ((y == 0 && x == 500) ? .sandSource : .air)
                row.append(mat)
            }
            table.append(row)
        }
        return table
    }

    // MARK: - Interface

    func printVerticalSlice() {
        for n in verticalSlice {
            print(n.compactMap { $0.rawValue }.joined())
        }
    }

    func updateWithRocklines(_ rockLines: [RockLine]) {
        for rockLine in rockLines {
            for i in 0..<rockLine.count - 1 {
                addRocksBetween(pointA: rockLine[i], pointB: rockLine[i+1])
            }
        }
    }

    // MARK: - TEst

    func createTestVerticalSlice() -> [[Material]] {
        [
            "~......+...~".compactMap { Material(rawValue: String($0)) },
            "~..........~".compactMap { Material(rawValue: String($0)) },
            "~..........~".compactMap { Material(rawValue: String($0)) },
            "~..........~".compactMap { Material(rawValue: String($0)) },
            "~....#...##~".compactMap { Material(rawValue: String($0)) },
            "~....#...#.~".compactMap { Material(rawValue: String($0)) },
            "~..###...#.~".compactMap { Material(rawValue: String($0)) },
            "~........#.~".compactMap { Material(rawValue: String($0)) },
            "~........#.~".compactMap { Material(rawValue: String($0)) },
            "~#########.~".compactMap { Material(rawValue: String($0)) },
            "~~~~~~~~~~~~".compactMap { Material(rawValue: String($0)) },
        ]
    }

    

    private func addRocksBetween(pointA: Coordinate, pointB: Coordinate) {
        if pointA.x == pointB.x {
            // Vertical
            let x = pointA.x - minX + inset
            let range = pointA.y < pointB.y ? pointA.y...pointB.y : pointB.y...pointA.y
            for y in range {
                verticalSlice[y][x] = .rock
            }
        } else if pointA.y == pointB.y {
            // Horizontal
            let y = pointA.y
            let range = pointA.x < pointB.x ? pointA.x...pointB.x : pointB.x...pointA.x
            for x in range {
                let correctX = x - minX + inset
                verticalSlice[y][correctX] = .rock
            }
        } else {
            fatalError("error drawing rock line")
        }
    }

    func unleashSand(from: Coordinate) -> Int {
        var restingSand: Int = 0
        let sandhole: Coordinate = from

        var didLand = true
        while didLand {
            didLand = dropSandUnit(from: sandhole)
            if didLand {
                restingSand += 1
                if restingSand == 400 {
                    print("break")
                } else if restingSand == 500 {
                    print("break")
                } else if restingSand == 600 {
                    print("break")
                } else if restingSand == 700 {
                    print("break")
                }
            }
        }
//        printVerticalSlice()
        return restingSand
    }

    private func dropSandUnit(from coordinate: Coordinate, didSlide: SandDisplacement? = nil) -> Bool {
        if coordinate.x == 0 {
            print("breakpoint")
        }
        guard verticalSlice[coordinate.y][coordinate.x] != .void else {
            return false
        }
        let nextCoord: Coordinate = (coordinate.x, coordinate.y + 1)
        let materialBelow = verticalSlice[nextCoord.y][nextCoord.x]
        switch materialBelow {
        case .air:
            return dropSandUnit(from: (coordinate.x, coordinate.y + 1), didSlide: didSlide)
        case .void:
            return false
        case .rock:
            fallthrough
        case .sand:
            let direction: SandDisplacement = possibleDisplacement(belowMat: materialBelow, coord: coordinate, didSlide: didSlide)
            switch direction {
            case .left:
                return dropSandUnit(from: (coordinate.x - 1, coordinate.y + 1), didSlide: .left)
            case .right:
                return dropSandUnit(from: (coordinate.x + 1, coordinate.y + 1), didSlide: .right)
            case .none:
                landSand(coordinate)
                return coordinate == (500 + inset - minX, 0) ? false : true
            }
        case .sandSource:
            fatalError("wrong cell")
        }
    }

    private func landSand(_ coordinate: Coordinate) {
        verticalSlice[coordinate.y][coordinate.x] = .sand
    }

    private func possibleDisplacement(belowMat: Material, coord: Coordinate, didSlide: SandDisplacement?) -> SandDisplacement {
        let bottomLeft = verticalSlice[coord.y + 1][coord.x - 1]
        let bottomRight = verticalSlice[coord.y + 1][coord.x + 1]

        if belowMat == .sand {
            if bottomLeft == .air || bottomLeft == .void {
                return .left
            } else if bottomRight == .air || bottomRight == .void {
                return .right
            } else {
                return .none
            }
        } else {
            if didSlide == .left && (bottomLeft == .air || bottomLeft == .void) {
                return .left
            } else if didSlide == .right && (bottomRight == .air || bottomRight == .void) {
                return .right
            } else {
                return .none
            }
        }
    }
}

enum SandDisplacement {
    case left, right, none
}

func main() {
    readInput()
    print(minX, maxX, minY, maxY)

    let test = false

    let cave = Cave(minX: minX, maxX: maxX, maxY: maxY, test: test,sideInsets: 500)
    if !test {
        cave.updateWithRocklines(rockLines)
    }
//    cave.printVerticalSlice()

    let sandSource: Coordinate = (500 + cave.inset - minX, 0)
    let rest = !test ? cave.unleashSand(from: sandSource) : cave.unleashSand(from: (7,0))
    print(rest)
}



func readInput() {
    // get URL to the the documents directory in the sandbox
    let home = FileManager.default.homeDirectoryForCurrentUser

    // add a filename
    let fileUrl = home
        .appendingPathComponent("input")

    // make sure the file exists
    guard FileManager.default.fileExists(atPath: fileUrl.path) else {
        preconditionFailure("file expected at \(fileUrl.absoluteString) is missing")
    }

    // open the file for reading
    // note: user should be prompted the first time to allow reading from this location
    guard let filePointer:UnsafeMutablePointer<FILE> = fopen(fileUrl.path,"r") else {
        preconditionFailure("Could not open file at \(fileUrl.absoluteString)")
    }

    // a pointer to a null-terminated, UTF-8 encoded sequence of bytes
    var lineByteArrayPointer: UnsafeMutablePointer<CChar>? = nil

    // see the official Swift documentation for more information on the `defer` statement
    // https://docs.swift.org/swift-book/ReferenceManual/Statements.html#grammar_defer-statement
    defer {
        // remember to close the file when done
        fclose(filePointer)

        // The buffer should be freed by even if getline() failed.
        lineByteArrayPointer?.deallocate()
    }

    // the smallest multiple of 16 that will fit the byte array for this line
    var lineCap: Int = 0

    // initial iteration
    var bytesRead = getline(&lineByteArrayPointer, &lineCap, filePointer)


    while (bytesRead > 0) {
        // note: this translates the sequence of bytes to a string using UTF-8 interpretation
        let lineAsString = String.init(cString:lineByteArrayPointer!)

        // do whatever you need to do with this single line of text
        // for debugging, can print it
        //if let line = lineAsString {
          proceedLine(line: lineAsString)
        //}

        // updates number of bytes read, for the next iteration
        bytesRead = getline(&lineByteArrayPointer, &lineCap, filePointer)
    }
}

private func proceedLine(line: String) {
  guard !line.isEmpty else { return }
    let rockLine: RockLine = line.replacingOccurrences(of: "\n", with: "").components(separatedBy: " -> ").compactMap {
        let coordinates = $0.components(separatedBy:",")
        guard coordinates.count == 2, let x = Int(coordinates[0]), let y = Int(coordinates[1]) else { fatalError("coordinates") }
        if x < minX { minX = x }
        if x > maxX { maxX = x }
        if y < minY { minY = y }
        if y > maxY { maxY = y }
        return (x,y)
    }
    rockLines.append(rockLine)
}

main()
