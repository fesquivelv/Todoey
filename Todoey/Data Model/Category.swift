//
//  Category.swift
//  Todoey
//
//  Created by fredo on 24/06/18.
//  Copyright © 2018 fesquivel. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
