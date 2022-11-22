//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Bruno Coelho on 18/11/22.
//

import UIKit

class SwipeTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist") }
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemGreen

        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = navBar.standardAppearance
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int, countedAs numberOfObjetcs: Int) -> Int {

        return numberOfObjetcs != 0 ? numberOfObjetcs : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, withIdentifier identifier: String, numberOfObjectsInCollectionAs numberOfRows: Int) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .none
        
        if numberOfRows == 0 {
            cell.textLabel?.text = "Nothing added yet"
        } else {
            
            let r = 1.0
            let g = 1.0
    
            let inicialB = 0.5882
            let gradientStep = inicialB / Double(numberOfRows)
            let b = inicialB - (Double(indexPath.row) * gradientStep)
            
            cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    // trailingSwipeActionsConfigurationForRowAt is the same method to swipe from left to right and its possible to have both at the same time for different actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath, forNumberOfObjectsCountedAs numberOfObjects: Int) -> UISwipeActionsConfiguration? {
        
        if numberOfObjects != 0 {
            
            let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, completion in
                self.deleteData(at: indexPath)
                completion(true)    //true IF EVERETHING GOES OK, false IF SOMETHING FAILS
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            
            //POSSIBLE TO HAVE MULTIPLE ACTIONS
            //        let messageAction = UIContextualAction(style: .destructive, title: "MESSAGE") { _, _, completion in
            //            print("Send a message to XXX")
            //            completion(true)
            //        }
            //        messageAction.image = UIImage(systemName: "envelope")
            //        messageAction.backgroundColor = .systemBlue
            
            let config = UISwipeActionsConfiguration(actions: [deleteAction])
            
            //        let config = UISwipeActionsConfiguration(actions: [deleteAction, messageAction])    // the first action in the array will be the action for full swipe
            //        config.performsFirstActionWithFullSwipe = false     // disable full swipe
            
            return config
            
        } else {
            
            let addAction = UIContextualAction(style: .normal, title: "ADD ITEM") { _, _, completion in
                self.createData()
                completion(true)
            }
            addAction.backgroundColor = .systemBlue

            let config = UISwipeActionsConfiguration(actions: [addAction])
            
            return config
        }
    }
    
    func createData() {
        print("CREATE from superclass")
    }
    
    func updateData(at indexPath: IndexPath) {
        print("UPDATE from superclass")
        print(indexPath.row)
    }
    
    func deleteData(at indexPath: IndexPath) {
        print("DELETE from superclass")
        print(indexPath.row)
    }
}
