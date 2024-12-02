//
//  FileSystem.swift
//  NoSpace
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

final class FileSystem {
    private let totalSpace: Int = 70000000

    private let commands: [String]
    let root = Folder(name: "/", parent: nil)
    var currentDir: Folder

    var systemSize: Int {
        root.size
    }

    init(commands: String) {
        self.commands = commands.components(separatedBy: "\n")
        self.currentDir = root
    }

    func buildFileSystem() {
        for command in commands {
            let components = command.components(separatedBy: " ")
            if components[0] == "$" {
                if components[1] == "ls" { continue }
                doCommand(command: command)
            } else {
                addItemIfNeeded(item: command)
            }
        }
    }

    private func doCommand(command: String) {
        let components = command.components(separatedBy: " ")
        guard
            components[1] == "cd"
        else {
            fatalError("command error")
        }

        if components[2] == ".." {
            guard let parent = currentDir.parent else {
                fatalError("parent does not exist")
            }
            currentDir = parent
            return
        }

        guard let folder: Folder = currentDir.items.first(where: { $0.name == components[2] && $0.type == .folder }) as? Folder else {
            fatalError("folder does not exist")
        }
        currentDir = folder
    }

    private func addItemIfNeeded(item: String) {
        let components = item.components(separatedBy: " ")
        let name = components[1]
        if components[0] == "dir" {
            guard currentDir.items.first(where: { $0.name == name && $0.type == .folder }) == nil else  { return }
            let folder = Folder(name: components[1], parent: currentDir)
            currentDir.items.append(folder)
        } else {
            guard
                currentDir.items.first(where: { $0.name == name && $0.type == .file }) == nil,
                let size = Int(components[0])
            else {
                print("error mapping file")
                return
            }
            let file = File(name: name, size: size)
            currentDir.items.append(file)
        }
    }

    var partOne: Int {
        foldersBelow100Sum(folder: root)
    }

    private func foldersBelow100Sum(folder: Folder) -> Int {
        var total: Int = 0
        let maxFolderSize = 100000
        for item in folder.items {
            guard
                item.type == .folder,
                let folder = item as? Folder
            else {
                continue
            }
            if folder.size <= maxFolderSize {
                total += folder.size
            }
            total += foldersBelow100Sum(folder: folder)
        }
        return total
    }

    var partTwo: Int {
        let freeSpaceRequired: Int = 30000000
        let spaceLeft = totalSpace - systemSize
        let spaceToFreeUp = freeSpaceRequired - spaceLeft

        let minFolderToDeleteSize = findFolder(folder: root, minSize: spaceToFreeUp)

        return minFolderToDeleteSize
    }

    private func findFolder(folder: Folder, minSize: Int) -> Int {
        var maxMin = folder.size
        for item in folder.items {
            guard
                item.type == .folder,
                let folderItem = item as? Folder,
                folderItem.size >= minSize
            else {
                continue
            }
            maxMin = min(maxMin, findFolder(folder: folderItem, minSize: minSize))
        }
        return maxMin
    }
}
