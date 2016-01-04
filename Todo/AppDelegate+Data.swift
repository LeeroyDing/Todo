//
//  AppDelegate+Data.swift
//  Todo
//
//  Created by Leeroy on 03/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit
import RealmSwift

extension AppDelegate {
  func seedData() {
    let realm = try! Realm()
    guard realm.isEmpty else { return }
    try! realm.write {
      realm.create(Todo.self, value: ["First item", false])
    }
  }
}