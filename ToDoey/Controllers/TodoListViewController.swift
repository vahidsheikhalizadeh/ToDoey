//
//  ViewController.swift
//  ToDoey
//
//  Created by sheiv on 30.04.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "learn swift"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem2.title = "kotlin"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "iOS"
        itemArray.append(newItem3)
        
    
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operation
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens once user click on add button on UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
        
    }
    
}

