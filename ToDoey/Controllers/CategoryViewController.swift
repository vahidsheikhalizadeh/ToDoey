//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by sheiv on 13.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
     //MARK: - tableview datasource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
         cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
//MARK: - tableView delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVS = segue.destination as! TodoListViewController
        
    }
    
    
    
    
    //MARK: - add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
            
            self.tableView.reloadData()
    }
    
           alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
   }
    
    //MARK: - data manipulation method
    
    func saveCategories() {
        do {
            try context.save()
        }
            
        catch{
            print("*** Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            categoryArray =  try context.fetch(request)
        }
        catch{
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
}
