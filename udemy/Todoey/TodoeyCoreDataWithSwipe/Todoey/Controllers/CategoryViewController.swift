//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Bruno Coelho on 13/11/22.
//

import UIKit
import CoreData

class CategoryViewController: SwipeTableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    // MARK: - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section, countedAs: categoryArray.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath, withIdentifier: K.CategoryCellIdentifier, numberOfObjectsInCollectionAs: categoryArray.count)
        
        if !categoryArray.isEmpty {
            cell.textLabel?.text = categoryArray[indexPath.row].name
        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !categoryArray.isEmpty {
            performSegue(withIdentifier: K.goToItemsSegue, sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let config = super.tableView(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath, forNumberOfObjectsCountedAs: categoryArray.count)
        
        return config
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Model manipulation methods

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        createData()
    }
    
    override func createData() {
        super.createData()
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func deleteData(at indexPath: IndexPath) {
        super.deleteData(at: indexPath)
        
        context.delete(categoryArray[indexPath.row])
        
        categoryArray.remove(at: indexPath.row)
        
        saveCategories()
    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }

}
