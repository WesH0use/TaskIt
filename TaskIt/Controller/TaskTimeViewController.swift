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
    
    
    required init?(coder aDecoder: NSCoder) {

        taskList = TaskList()
    
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.taskListArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskItemCell", for: indexPath)
        let item = taskList.taskListArray[indexPath.row]
        configureTaskText(for: cell, with: item)
        configureCheckmark(for: cell, at: indexPath)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCheckmark(for: cell, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureTaskText(for cell: UITableViewCell, with item: TaskListItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.text
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        let isChecked = taskList.taskListArray[indexPath.row].checked
        if isChecked {
                cell.accessoryType = .checkmark
            } else if isChecked == false {
                cell.accessoryType = .none
            }
        taskList.taskListArray[indexPath.row].checked = !isChecked
    }
    
    
}

