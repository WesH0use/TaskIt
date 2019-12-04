//
//  NewItemTableViewController.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import UIKit

class NewItemTableViewController: UITableViewController {

    @IBOutlet weak var usersItemInput: UITextField!
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        print("Done")
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usersItemInput.becomeFirstResponder()
    }

}
