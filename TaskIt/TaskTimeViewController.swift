//
//  ViewController.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import UIKit

class TaskTimeViewController: UITableViewController {
    
    var row0Item : TaskListItem
    var row1Item : TaskListItem
    var row2Item : TaskListItem
    var row3Item : TaskListItem
    
    required init?(coder aDecoder: NSCoder) {
        row0Item = TaskListItem()
        row1Item = TaskListItem()
        row2Item = TaskListItem()
        row3Item = TaskListItem()
        
        row0Item.text = "This is just a test cell!"
        row1Item.text = "This is just another test cell"
        row2Item.text = "This is the last test cell"
        row3Item.text = "Here's just one more cell"
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskItemCell", for: indexPath)
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row == 0 {
                label.text = "My first cell"
            } else if indexPath.row == 1 {
                label.text = "Here's another cell"
            } else if indexPath.row == 2 {
                label.text = "And another"
            } else if indexPath.row == 3 {
                label.text = "My last cell"
            }
        }
        configureCheckmark(for: cell, at: indexPath)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCheckmark(for: cell, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if row0Item.checked == false {
                cell.accessoryType = .checkmark
            } else if row0Item.checked == true {
                cell.accessoryType = .none
            }
            row0Item.checked = !row0Item.checked
            
        } else if indexPath.row == 1 {
            if row1Item.checked == false {
                cell.accessoryType = .checkmark
            } else if row1Item.checked == true {
                cell.accessoryType = .none
            }
            row1Item.checked = !row1Item.checked
            
        } else if indexPath.row == 2 {
            if row2Item.checked == false {
                cell.accessoryType = .checkmark
            } else if row2Item.checked == true {
                cell.accessoryType = .none
            }
            row2Item.checked = !row2Item.checked
        
        } else if indexPath.row == 3 {
            if row3Item.checked == false {
                cell.accessoryType = .checkmark
            } else if row3Item.checked == true {
                cell.accessoryType = .none
            }
            row3Item.checked = !row3Item.checked
    }
}
}
