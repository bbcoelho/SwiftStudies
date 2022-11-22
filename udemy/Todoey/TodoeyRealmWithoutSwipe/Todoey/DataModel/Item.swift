//
//  RealmItem.swift
//  Todoey
//
//  Created by Bruno Coelho on 14/11/22.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated = Date().timeIntervalSince1970
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
