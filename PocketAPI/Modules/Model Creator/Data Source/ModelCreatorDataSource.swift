//
//  ModelCreatorDataSource.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol ModelCreatorDataSource: UITableViewDataSource {
    
    /// models to be used for table view
    var models: [NameTypePair] { get set }
}
