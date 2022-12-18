//
//  main.swift
//  NoSpace
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

func main() {
    let fileSystem = FileSystem(commands: Input.text)
    fileSystem.buildFileSystem()
    print("Part 1: \(fileSystem.partOne)")
    print("Part 2: \(fileSystem.partTwo)")
}

main()
