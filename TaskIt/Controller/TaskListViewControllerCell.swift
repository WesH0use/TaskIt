//
//  TaskListViewControllerCell.swift
//  TaskIt
//
//  Created by Wesley House on 12/16/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import UIKit

class TaskListViewControllerCell: UITableViewCell {

    @IBOutlet weak var checkmarkLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
