//
//  Entity.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// Basic entity. Any instance of created model is an Entity
struct Entity {
    
    let type: Type
    var fields: [String: Codable]
    
    init(type: Type, fields: [String: Codable]) {
        
        self.type = type
        self.fields = fields
    }
}
