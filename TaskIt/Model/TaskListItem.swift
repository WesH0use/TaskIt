//
//  TaskList.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import Foundation
import RealmSwift


class TaskListItem : Object {
    
    @objc dynamic var text = ""
    @objc dynamic var checked = false
    // var parentCategory = LinkingObjects(fromType: TaskList.self, property: "taskListArray")
    
    func changeChecked() {
      checked = !checked
    }
    
}
