//
//  Todo.swift
//  Todo
//
//  Created by Leeroy on 03/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {
  dynamic var text: String = ""
  dynamic var done: Bool = false
}
