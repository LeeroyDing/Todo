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

  let text = Observable<String?>(nil)
  let selected = Observable<Bool>(false)
  
}
