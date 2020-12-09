//
//  Type.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// Any created model is a Type
struct Type {
    
    let name: String
    let types: [String: SupportedPrimitives]
    
    init(name: String, types: [String: SupportedPrimitives]) {
        
        self.name = name
        self.types = types
    }
}
