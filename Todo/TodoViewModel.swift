//
//  TodoViewModel.swift
//  Todo
//
//  Created by Leeroy on 02/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit
import Bond

class TodoViewModel: NSObject {

  // MARK: Element content from model
  
  class ElementContent {
    var text = Observable<String?>(nil)
    var selected = Observable<Bool>(false)
  }
  
  let models: ObservableArray<Todo>
  // Ugly type is inferred from the map function
  lazy var elementContents: EventProducer<ObservableArrayEvent<LazyMapCollection<[Todo], ElementContent>>>! =
  { [unowned self] in
    self.models.map(self.elementContentFromModel)
  }()
  
  func elementContentFromModel(model: Todo) -> ElementContent {
    let elementContent = ElementContent()
    Observable<String?>(object: model, keyPath: "text")
      .bindTo(elementContent.text)
    Observable<Bool>(object: model, keyPath: "done")
      .bindTo(elementContent.selected)
    elementContent.text.observeNew { text in
      let realm = try! Realm()
      try! realm.write {
        model.text = text!
      }
    }
    elementContent.selected.observeNew { selected in
      let realm = try! Realm()
      try! realm.write {
        model.done = selected
      }
    }
    return elementContent
  }
  
  init(_ models: [Todo]) {
    self.models = ObservableArray(models)
    super.init()
  }
  
  // MARK: Controller operations
  
  func addTodo(newTodo: Todo) {
    models.append(newTodo)
    let realm = try! Realm()
    try! realm.write {
      realm.add(newTodo)
    }
  }
  
  func removeTodo(todo: Todo) {
    guard let index = models.indexOf(todo) else { fatalError("No such todo") }
    models.removeAtIndex(index)
    let realm = try! Realm()
    try! realm.write {
      realm.delete(todo)
    }
  }
  
  func clearFinishedTodos() {
    models.filter{$0.done}.forEach(removeTodo)
  }
}

import RealmSwift

extension TodoViewModel {
  class func getAll() -> TodoViewModel {
    let realm = try! Realm()
    let todos = realm.objects(Todo).map{$0}
    return TodoViewModel(todos)
  }
}
