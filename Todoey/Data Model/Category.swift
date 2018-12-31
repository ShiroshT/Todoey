//
//  Category.swift
//  Todoey
//
//  Created by Shiroshana Tissera on 12/30/18.
//  Copyright © 2018 Shiroshana Tissera. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    @objc dynamic var name: String  = ""
    let items = List<Item>()
    
}
