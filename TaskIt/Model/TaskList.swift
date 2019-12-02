//
//  TaskList.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import Foundation

class TaskList {
    
    var taskListArray : [TaskListItem] = []

    init() {
        let row0Item = TaskListItem()
        let row1Item = TaskListItem()
        let row2Item = TaskListItem()
        let row3Item = TaskListItem()
        
        row0Item.text = "This is just a test cell!"
        row1Item.text = "This is just another test cell"
        row2Item.text = "This is the last test cell"
        row3Item.text = "Here's just one more cell"
        
        taskListArray.append(row0Item)
        taskListArray.append(row1Item)
        taskListArray.append(row2Item)
        taskListArray.append(row3Item)
    }
}