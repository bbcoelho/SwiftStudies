//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Bruno Coelho on 13/11/22.
//

import UIKit
import RealmSwift

class CategoryViewController: CustomTableViewController {
    
    @IBOutlet weak var cellDeleteImage: UIImageView!
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    var categoriesIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    // MARK: - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfCategories = categories?.count {
            if numberOfCategories == 0 {
                return 1
            } else {
                return numberOfCategories
            }
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath, withIdentifier: K.CategoryCellIdentifier)
        
        if let numberOfCategories = categories?.count {
            if numberOfCategories == 0 {
                cell.textLabel?.text = "No categories added yet"
                cell.accessoryView = .none
            } else {
                cell.textLabel?.text = categories?[indexPath.row].name
                categoriesIndex = indexPath.row
                cell.setAccessoryImage(to: UIImage(systemName: "trash")!, color: .systemBlue, selector: #selector(deleteButtonPressed), target: self, indexPath: indexPath)
            }
        }
        
        return cell
    }
    
    @objc override func deleteButtonPressed(_ sender: indexedButton) {
        
        super.deleteButtonPressed(sender)
        
        if let indexToDelete = sender.indexPath?.row {
            if let category = categories?[indexToDelete] {
                do {
                    try realm.write {
                        realm.delete(category)
                    }
                } catch {
                    print("Error deleting category in database, \(error)")
                }
        
                tableView.reloadData()
            }
        }
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let numberOfCategories = categories?.count {
            if numberOfCategories != 0 {
                performSegue(withIdentifier: K.goToItemsSegue, sender: self)
            }
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    //MARK: - Model manipulation methods

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }

}
