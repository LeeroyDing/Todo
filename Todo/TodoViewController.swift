//
//  TodoViewController.swift
//  Todo
//
//  Created by Leeroy on 02/01/2016.
//  Copyright © 2016 Leeroy. All rights reserved.
//

import UIKit
import Bond

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
    viewModel.elementContents.lift().bindTo(tableView) { indexPath, array, tableView in
      let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.todoCell)!
      let data = array[indexPath.section][indexPath.row]
      cell.bnd_bag.dispose()
      cell.contentTextView.text = data.text
      cell.checkButton.selected = data.selected
      return cell
    }
  }
  
  // MARK: Interaction
  
  @IBAction func clearFinished(sender: AnyObject) {
    viewModel.elementContents.performBatchUpdates { cellContents in
      viewModel.elementContents.enumerate().filter {
        $1.selected
      }.reverse().forEach { (i, _) in
        viewModel.elementContents.removeAtIndex(i)
      }
    }
  }
  
}

