//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by Leeroy on 02/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
  
  @IBOutlet weak var checkButton: UIButton!
  @IBOutlet weak var contentTextView: UITextView! {
    didSet {
      contentTextView.textContainer.lineBreakMode = .ByWordWrapping
    }
  }
  
}
