//
//  ModelBrowserDataSource.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import Entity

protocol ModelBrowserDataSource: AnyObject, UITableViewDataSource {
    
    var isMutable: Bool { get set }
    
    /// models for populating the table view
    var models: [ViewModel] { get set }
    
    /// actual types that are represented by viewmodels
    var types: [Type] { get set }
}
