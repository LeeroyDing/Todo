//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by Leeroy on 02/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit

protocol TodoTableViewCellDelegate: class {
  func checkButtonOfCellDidTap(cell: TodoTableViewCell)
  func contentTextOfCellDidChange(cell: TodoTableViewCell)
}

class TodoTableViewCell: UITableViewCell {
  
  @IBOutlet weak var checkButton: UIButton!
  @IBOutlet weak var contentTextView: UITextView! {
    didSet {
      contentTextView.textContainer.lineBreakMode = .ByWordWrapping
    }
  }
  
  weak var delegate: TodoTableViewCellDelegate?
  
  @IBAction func checkButtonDidTap() {
    checkButton.bnd_selected.value = !checkButton.selected
    delegate?.checkButtonOfCellDidTap(self)
  }
  
}

extension TodoTableViewCell: UITextViewDelegate {
  
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
  
}