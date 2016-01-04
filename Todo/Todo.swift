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
  dynamic var id: String! = nil
  dynamic var text: String = ""
  dynamic var done: Bool = false
  
  convenience init(text: String, done: Bool) {
    self.init(value: ["id": NSUUID().UUIDString, "text": text, "done": done])
  }
}

// MARK: Equatable
extension Todo: Equatable {}
func ==(lhs: Todo, rhs: Todo) -> Bool {
  return lhs.id == rhs.id
}
