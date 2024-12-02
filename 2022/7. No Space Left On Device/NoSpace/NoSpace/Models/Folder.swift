//
//  Folder.swift
//  NoSpace
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

final class Folder: Item {
    let type: ItemType = .folder

    let name: String
    let parent: Folder?

    init(name: String, parent: Folder?) {
        self.name = name
        self.parent = parent
    }

    var items: [Item] = []

    var size: Int {
        items.reduce(into: 0) { partialResult, item in
            partialResult += item.size
        }
    }

}
