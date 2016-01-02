//
//  TodoViewController.swift
//  Todo
//
//  Created by Leeroy on 02/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 44
    }
  }
  var viewModel: TodoViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.cellContents.lift().bindTo(tableView) { indexPath, array, tableView in
      let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.todoCell)!
      let data = array[indexPath.section][indexPath.row]
      cell.contentTextView.text = data.text
      cell.checkButton.selected = data.selected
      return cell
    }
  }
}
