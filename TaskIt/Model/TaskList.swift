//
//  TaskList.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import Foundation
import RealmSwift

class TaskList {
    
    var taskListArray : [TaskListItem] = []
    
//    init() {
//        let row0Item = TaskListItem()
//        row0Item.text = "Test text"
//        taskListArray.append(row0Item)
//    }

    
    func newTask() -> TaskListItem {
        let item = TaskListItem()
        // item.text = randomDescription()
        item.checked = false
        taskListArray.append(item)
        return item
    }
    
    func move(item: TaskListItem, to index: Int){
        guard let currentIndex = taskListArray.firstIndex(of: item) else {return}
        taskListArray.remove(at: currentIndex)
        taskListArray.insert(item, at: index)
    }
    
    func removeMultiple(items: [TaskListItem]) {
        for item in items {
            if let index = taskListArray.firstIndex(of: item) {
                taskListArray.remove(at: index)
            }
        }
    }
    
//    private func randomDescription() -> String {
//        let randomArray = ["To Do List App",
//                           "Weather App",
//                           "Messaging App",
//                           "Augmented Reality App",
//                           "Another AR App"]
//        let randomNumer = Int.random(in: 0..<randomArray.count)
//        return randomArray[randomNumer]
//    }
}
