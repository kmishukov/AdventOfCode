//
//  main.swift
//  Beacons
//
//  Created by Konstantin Mishukov on 15.12.2022.
//

import Foundation

class Tunnels {

}

func main() {
    readInput()
}

func readInput() {
    let home = FileManager.default.homeDirectoryForCurrentUser
    let fileUrl = home
        .appendingPathComponent("input")

    guard let path = Bundle.main.path(forResource: "input", ofType:"txt") else { return }

    guard FileManager.default.fileExists(atPath: path) else {
        preconditionFailure("file expected at \(fileUrl.absoluteString) is missing")
    }
    guard let filePointer:UnsafeMutablePointer<FILE> = fopen(path,"r") else {
        preconditionFailure("Could not open file at \(fileUrl.absoluteString)")
    }
    var lineByteArrayPointer: UnsafeMutablePointer<CChar>? = nil
    defer {
        fclose(filePointer)
        lineByteArrayPointer?.deallocate()
    }

    var lineCap: Int = 0
    var bytesRead = getline(&lineByteArrayPointer, &lineCap, filePointer)

    while (bytesRead > 0) {
        let lineAsString = String.init(cString:lineByteArrayPointer!)
          proceedLine(line: lineAsString)
        bytesRead = getline(&lineByteArrayPointer, &lineCap, filePointer)
    }
}

private func proceedLine(line: String) {
    print(line)
}

main()
