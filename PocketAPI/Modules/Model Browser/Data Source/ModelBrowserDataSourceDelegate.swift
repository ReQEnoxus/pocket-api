//
//  ModelBrowserDataSourceDelegate.swift
//  PocketAPI
//
//  Created by Enoxus on 29.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

protocol ModelBrowserDataSourceDelegate: AnyObject{
    
    func didRequestToDelete(type: Type, at: IndexPath)
}
