//
//  ViewController.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import UIKit
import RealmSwift

class TaskTimeViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var taskList : TaskList
    
    
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        taskList = TaskList()
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [TaskListItem]()
            for indexPath in selectedRows {
                items.append(taskList.taskListArray[indexPath.row])
            }
            taskList.removeMultiple(items: items)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .middle)
            tableView.endUpdates()
        }
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        taskList.move(item: taskList.taskListArray[sourceIndexPath.row], to: destinationIndexPath.row)
        //tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.taskListArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        taskList.taskListArray.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskItemCell", for: indexPath)
        let item = taskList.taskListArray[indexPath.row]
        
        configureTaskText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = taskList.taskListArray[indexPath.row]
            item.changeChecked()
            configureCheckmark(for: cell, with: item)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func configureTaskText(for cell: UITableViewCell, with item: TaskListItem) {
        if let checkmarkCell = cell as? TaskListViewControllerCell {
            checkmarkCell.taskLabel.text = item.text
        }
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, with item: TaskListItem) {
        guard let checkmarkCell = cell as? TaskListViewControllerCell else {
            return
        }
        if item.checked {
            checkmarkCell.checkmarkLabel.text = "✅"
            } else {
            checkmarkCell.checkmarkLabel.text = ""
            }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "NewTaskSegue" {
             if let newItemTableViewController = segue.destination as? NewItemTableViewController {
                newItemTableViewController.delegate = self
                newItemTableViewController.taskList = taskList
             }
         } else if segue.identifier == "EditItemSegue" {
            if let newItemTableViewController = segue.destination as? NewItemTableViewController {
                if let cell = sender as? UITableViewCell,
                   let indexPath = tableView.indexPath(for: cell) {
                    let item = taskList.taskListArray[indexPath.row]
                    newItemTableViewController.taskToEdit = item
                    newItemTableViewController.delegate = self
                }
            }
        }
     }
    
}


extension TaskTimeViewController : NewItemViewControllerDelegate {
    func newItemViewControllerDidEdit(_ controller: NewItemTableViewController, didFinishEdit item: TaskListItem) {
        if let index = taskList.taskListArray.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureTaskText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func newItemViewControllerDidCancel(_ controller: NewItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func newItemViewControllerDidDone(_ controller: NewItemTableViewController, didFinishDone item: TaskListItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = taskList.taskListArray.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        self.view.layoutIfNeeded()
        tableView.insertRows(at: indexPaths, with: .middle)
        self.view.layoutIfNeeded()
    }
}

