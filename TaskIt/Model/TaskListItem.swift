//
//  TaskList.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import Foundation


class TaskListItem : NSObject {
    
    var text = ""
    var checked = false
    
    func changeChecked() {
      checked = !checked
    }
    
}
