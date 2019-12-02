//
//  ViewController.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import UIKit

class TaskTimeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskItemCell", for: indexPath)
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row == 0 {
                label.text = "My first cell"
            } else {
                label.text = "My other cells"
            }
        }
        return cell
    }

}

