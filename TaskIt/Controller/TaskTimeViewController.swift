//
//  ViewController.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import UIKit

class TaskTimeViewController: UITableViewController {
    
    var taskList : TaskList
    
    @IBAction func addButtonPressed(_ sender: Any) {
        print("Test item Added")
        let newRowIndex = taskList.taskListArray.count
        _ = taskList.newTask()
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        taskList = TaskList()
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.taskListArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        taskList.taskListArray.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    // Provide delete functionality and user interface
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskItemCell", for: indexPath)
        let item = taskList.taskListArray[indexPath.row]
        configureTaskText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = taskList.taskListArray[indexPath.row]
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
        guard let checkmarkCell = cell as? TaskListViewControllerCell else { return }
        if item.checked {
            checkmarkCell.checkmarkLabel.text = "✅"
            } else {
            checkmarkCell.checkmarkLabel.text = ""
            }
        item.changeChecked()
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
        tableView.insertRows(at: indexPaths, with: .middle)
    }
}

