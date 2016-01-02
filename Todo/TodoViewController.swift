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
  
  var autoFocusOnNewCell = false
  
  // MARK: Present
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.elementContents.lift().bindTo(tableView) { indexPath, array, tableView in
      let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.todoCell)!
      let data = array[indexPath.section][indexPath.row]
      cell.bnd_bag.dispose()
      cell.contentTextView.text = data.text
      cell.checkButton.selected = data.selected
      cell.delegate = self
      return cell
    }
  }
  
  // MARK: Interaction
  
  @IBAction func newTodo(sender: AnyObject) {
    autoFocusOnNewCell = true
    viewModel.elementContents.append(TodoViewModel.ElementContent(text: "", selected: false))
  }
  
  @IBAction func clearFinished(sender: AnyObject) {
    viewModel.elementContents.performBatchUpdates { elementContents in
      viewModel.elementContents.enumerate()
        .filter { $1.selected }
        .reverse()
        .forEach { (i, _) in
          viewModel.elementContents.removeAtIndex(i)
      }
    }
  }
  
}

extension TodoViewController: TodoTableViewCellDelegate {
  
  func checkButtonOfCellDidTap(cell: TodoTableViewCell) {
    guard let indexPath = tableView.indexPathForCell(cell) else { return }
    viewModel.elementContents[indexPath.row].selected = cell.checkButton.selected
  }
  
  func contentTextOfCellDidChange(cell: TodoTableViewCell) {
    guard let indexPath = tableView.indexPathForCell(cell) else { return }
    viewModel.elementContents[indexPath.row].text = cell.contentTextView.text
  }
}

extension TodoViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    let cell = cell as! TodoTableViewCell
    if autoFocusOnNewCell {
      cell.contentTextView.becomeFirstResponder()
      autoFocusOnNewCell = false
    }
  }
}