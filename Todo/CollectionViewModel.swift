//
//  CollectionViewModel.swift
//  Todo
//
//  Created by Leeroy on 02/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit
import Bond

protocol CollectionViewModel {
  typealias Model
  typealias ElementContent
  
  func modelToElementContent(model: Model) -> ElementContent
  func elementContentToModel(elementContent: ElementContent) -> Model
  
  var models: [Model] { get set }
  var elementContents: ObservableArray<ElementContent> { get }
}


extension CollectionViewModel {
  
  mutating func handleObservableOperation(operation: ObservableArrayOperation<ElementContent>) {
    switch operation {
    case let .Insert(elements, fromIndex):
      let newModels = elements.map(elementContentToModel)
      models.insertContentsOf(newModels, at: fromIndex)
    case let .Remove(range):
      models.removeRange(range)
    case let .Update(elements, fromIndex):
      let newModels = elements.map(elementContentToModel)
      models.replaceRange(Range(start: fromIndex, end: fromIndex + elements.count), with: newModels)
    case let .Reset(array):
      models = array.map(elementContentToModel)
    case let .Batch(operations):
      operations.forEach{handleObservableOperation($0)}
    }
  }
  
}