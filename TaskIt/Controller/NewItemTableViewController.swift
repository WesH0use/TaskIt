//
//  NewItemTableViewController.swift
//  TaskIt
//
//  Created by Wesley House on 12/2/19.
//  Copyright © 2019 Wesley House. All rights reserved.
//

import UIKit


protocol NewItemViewControllerDelegate : class {
    func newItemViewControllerDidCancel(_ controller: NewItemTableViewController)
    func newItemViewControllerDidDone(_ controller: NewItemTableViewController, didFinishDone item: TaskListItem)
}


class NewItemTableViewController: UITableViewController {
    
    weak var delegate : NewItemViewControllerDelegate?
    weak var taskList : TaskList?
    weak var taskToEdit : TaskListItem?
    
    @IBOutlet weak var usersItemInput: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let item = TaskListItem()
        if let textField = usersItemInput.text {
            item.text = textField
        }
        item.checked = false
        delegate?.newItemViewControllerDidDone(self, didFinishDone: item)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.newItemViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = taskToEdit {
            title = "Edit Item"
            usersItemInput.text = item.text
            doneButton.isEnabled = true
        }
        usersItemInput.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usersItemInput.becomeFirstResponder()
    }

}

extension NewItemTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usersItemInput.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = usersItemInput.text,
            let stringRange = Range(range, in: oldText) else {return false}
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        return true
    }
    
}


