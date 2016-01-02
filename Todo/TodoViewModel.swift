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

  struct CellContent {
    let text: String?
    let selected: Bool
  }
  
  let cellContents = ObservableArray<CellContent>([])
  
  init(_ models: [Todo]) {
    super.init()
    cellContents.array = models.map { model in
      CellContent(text: model.text, selected: model.done)
    }
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