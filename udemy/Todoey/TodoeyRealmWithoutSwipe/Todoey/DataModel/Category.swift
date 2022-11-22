//
//  RealmCategory.swift
//  Todoey
//
//  Created by Bruno Coelho on 14/11/22.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
