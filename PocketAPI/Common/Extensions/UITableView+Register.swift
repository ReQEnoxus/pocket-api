//
//  UITableView+Register.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableView
extension UITableView {
    
    /// registers the given cell for the tableview
    /// - Parameter cell: cell to register
    func register(cell: UITableViewCell.Type) {
        self.register(cell, forCellReuseIdentifier: cell.nibName)
    }
}

//MARK: - UITableViewCell
extension UITableViewCell {
    
    /// returns the nib name for the cell
    static var nibName: String {
        
        get {
            return String(describing: self)
        }
    }
}
