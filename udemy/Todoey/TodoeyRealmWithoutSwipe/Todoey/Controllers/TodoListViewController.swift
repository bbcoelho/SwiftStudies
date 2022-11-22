//
//  ViewController.swift
//  Todoey
//
//  Created by Bruno Coelho on 10/11/22.
//

import UIKit
import RealmSwift

class TodoListViewController: CustomTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var todoItems: Results<Item>?
    
    var navBarTitle: String? = nil
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to see app sandbox path into simulator
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
        
        searchBar.delegate = self
        
    }
    
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let numberOfItems = todoItems?.count {
            if numberOfItems == 0 {
                return 1
            } else {
                return numberOfItems
            }
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath, withIdentifier: K.ToDoItemCellIdentifier)
        
        if let numberOfItems = todoItems?.count {
            if numberOfItems == 0 {
                cell.textLabel?.text = "No items added"
            } else {
                if let item = todoItems?[indexPath.row] {
                    cell.textLabel?.text = item.title
                    if item.done == true {
                        cell.setAccessoryImage(to: UIImage(systemName: "trash")!, color: .systemBlue, selector: #selector(deleteButtonPressed), target: self, indexPath: indexPath)
                    } else {
                        cell.accessoryView = .none
                    }
                }
            }
        }
        
        return cell
    }
    
    @objc override func deleteButtonPressed(_ sender: indexedButton) {
        
        super.deleteButtonPressed(sender)
        
        if let indexToDelete = sender.indexPath?.row {
            if let item = todoItems?[indexToDelete] {
                do {
                    try realm.write {
                        realm.delete(item)
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
        
        if let numberOfItems = todoItems?.count {
            if numberOfItems != 0 {
                if let item = todoItems?[indexPath.row] {
                    do {
                        try realm.write {
                            item.done = !item.done
                        }
                    } catch {
                        print("Error saving DONE status, \(error)")
                    }
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    
    //MARK: - Model manipulation methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    let newItem = Item()
                    newItem.title = textField.text!
                    try self.realm.write {
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new item, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
        title = selectedCategory?.name
        
        tableView.reloadData()
    }
    
}
    
    //MARK: - Search bar methods
    
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}
