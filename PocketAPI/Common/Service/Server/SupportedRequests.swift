//
//  SupportedRequests.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// All types of requests, for which endpoints will be generated. To add new type of request, you should start with this enum
enum SupportedRequests: String, CaseIterable {
    
    case getAll = "Get all instances of entity"
    case getById = "Get specific entity by id"
    case addEntity = "Add entity with POST request"
    case deleteEntity = "Delete entity by id"
}
