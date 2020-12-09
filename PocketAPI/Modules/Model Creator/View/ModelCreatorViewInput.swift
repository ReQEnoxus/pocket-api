//
//  ModelCreatorViewInput.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelCreatorViewInput: AnyObject {
    
    /// tells view to connect data source to the table view
    /// - Parameter dataSource: data source to connect
    func connectDataSource(_ dataSource: ModelCreatorDataSource)
    
    /// tells view to reload all data in table
    func reloadData()
    
    /// tells view to update table view with given indices
    /// - Parameters:
    ///   - deletions: deletions idx
    ///   - insertions: insertions idx
    ///   - modifications: modifications idx
    func updateTableView(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath])
}
