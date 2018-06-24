//
//  CategoryViewController.swift
//  Todoey
//
//  Created by fredo on 24/06/18.
//  Copyright © 2018 fesquivel. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    //MARK: Data manipulation
    
    func saveCategories(){
        do{
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categories = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: Add new categoies
    @IBAction func addButtondPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            //What will happen onces the users clicks the add item
            if let text = textField.text, text.count > 0 {
                
                let newCategory = Category(context: self.context)
                newCategory.name = text
                self.categories.append(newCategory)
                self.saveCategories()
                
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let  indexPAth = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPAth.row]
        }
    }
    
}
