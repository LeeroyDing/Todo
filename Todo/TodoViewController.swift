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
      // Autolayout in UITableView cells, see:
      // https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 44
    }
  }
  
  var viewModel: TodoViewModel!
  
  // MARK: Present
  
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
  
  // MARK: Interaction
  
  @IBAction func clearFinished(sender: AnyObject) {
    viewModel.cellContents.array = viewModel.cellContents.filter { !$0.selected }
  }
  
}
