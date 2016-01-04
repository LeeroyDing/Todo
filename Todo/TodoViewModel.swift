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

  typealias Model = Todo
  class ElementContent {
    var text = Observable<String?>(nil)
    var selected = Observable<Bool>(false)
  }
  
  private var models: ObservableArray<Todo>
  lazy var elementContents: EventProducer<ObservableArrayEvent<LazyMapCollection<[Todo], ElementContent>>>! =
  { [unowned self] in
    self.models.map(self.modelToElementContent)
  }()
  
  func modelToElementContent(model: Model) -> ElementContent {
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
  
}

#if DEBUG
import RealmSwift

extension TodoViewModel {
  class func fake() -> TodoViewModel {
    let realm = try! Realm()
    let todos = realm.objects(Todo).map{$0}
    return TodoViewModel(todos)
  }
}
#endif
