//
//  tableViewCell+extensions.swift
//  Todoey
//
//  Created by Bruno Coelho on 16/11/22.
//

import Foundation
import UIKit



/// A button for use as accessory item on tableview rows that holds the indexPath of the cell
class indexedButton: UIButton {
    var indexPath: IndexPath?
}

extension UITableViewCell {
/// Sets a custom accessory button (with indexPath) as cell's accessory item on a tableView
/// - Parameters:
///
///   - image: The image to set.
///   - color: The tint color of the image.
///   - selector: The action of the accessory.
///   - target: The target of the action. (self)
///   - indexPath: Cell's indexPath.
    
    func setAccessoryImage(to image: UIImage, color: UIColor, selector: Selector?, target: Any?, indexPath: IndexPath) {
        
        self.accessoryType = .none
        
        let button = indexedButton(type: .custom)
        button.indexPath = indexPath
        
        button.setImage(image, for: .normal)
        let size = self.textLabel?.font.pointSize ?? UIFont.preferredFont(forTextStyle: .body).pointSize
        button.setPreferredSymbolConfiguration(.init(pointSize: size, weight: .regular, scale: UIImage.SymbolScale.large), forImageIn: .normal)
        button.sizeToFit()
        button.tintColor = color
        
        if selector != nil {
            button.addTarget(target, action: selector!, for: .touchUpInside)
        }

        self.accessoryView = button
    }
}
