//
//  Item.swift
//  NoSpace
//
//  Created by Konstantin Mishukov on 18.12.2022.
//

import Foundation

enum ItemType {
    case file
    case folder
}

protocol Item {
    var name: String { get }
    var type: ItemType { get }
    var size: Int { get }
}
