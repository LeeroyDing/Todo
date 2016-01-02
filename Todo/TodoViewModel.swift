//
//  TodoViewModel.swift
//  Todo
//
//  Created by Leeroy on 02/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit
import Bond

class TodoViewModel: NSObject, CollectionViewModel {

  typealias Model = Todo
  struct ElementContent {
    var text: String?
    var selected: Bool
  }
  
  let elementContents = ObservableArray<ElementContent>([])
  
  func modelToElementContent(model: Model) -> ElementContent {
    return ElementContent(text: model.text, selected: model.done)
  }
  
  func elementContentToModel(elementContent: ElementContent) -> Model {
    return Model(text: elementContent.text!, done: elementContent.selected)
  }

  
  var models: [Todo] = [] {
    didSet {
      bnd_bag.dispose()
      elementContents.array = models.map(modelToElementContent)
      elementContents.observeNew { [weak self](event) in
        self?.handleObservableOperation(event.operation)
      }.disposeIn(bnd_bag)
    }
  }
  
  init(_ models: [Todo]) {
    super.init()
    setup(models)  // Trigger didSet
  }
  
  private func setup(models: [Todo]) {
    self.models = models
  }
  
}

#if DEBUG
extension TodoViewModel {
  class func fake() -> TodoViewModel {
    return TodoViewModel([
      Todo(text: "First item", done: false),
      Todo(text: "Second item", done: true),
      Todo(text: "Third item", done: false),
      Todo(text: "Fourth item is a very very long item that will break into the next line", done: false)
    ])
  }
}
#endif
