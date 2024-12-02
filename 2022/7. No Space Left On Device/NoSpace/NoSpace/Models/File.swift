//
//  File.swift
//  NoSpace
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

final class File: Item {
    let type: ItemType = .file
    let name: String
    let size: Int

    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}
