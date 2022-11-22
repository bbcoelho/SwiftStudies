//
//  CustomTableViewController.swift
//  Todoey
//
//  Created by Bruno Coelho on 17/11/22.
//

import UIKit

class CustomTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60.0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, withIdentifier identifier: String) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    @objc func deleteButtonPressed(_ sender: indexedButton) {
        
        print("DELETION FROM SUPERCLASS")
    }
    
}
