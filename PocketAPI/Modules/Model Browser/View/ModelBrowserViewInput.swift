//
//  ModelBrowserViewInput.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelBrowserViewInput: AnyObject {
    
    /// tells view to register data source to the table view
    /// - Parameter dataSource: data source to be registered
    func registerDataSource(_ dataSource: ModelBrowserDataSource)
    
    /// tells view to completely refresh its data
    func reloadData()
    
    /// tells view to update table view with indices
    /// - Parameters:
    ///   - deletions: deletions idx
    ///   - insertions: insertions idx
    ///   - modifications: modifications idx
    func updateTableView(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath])
    
    /// tells view to display table view
    func displayTableView()
    
    /// tells view to display placeholder based on a given boolean value
    /// - Parameter showing: boolean value which decides whether placeholder should be shown
    func setShowingPlaceholder(_ showing: Bool)
}
