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
    }
  }
  var viewModel: TodoViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.cellContents.lift().bindTo(tableView) { indexPath, array, tableView in
    }
  }
}
