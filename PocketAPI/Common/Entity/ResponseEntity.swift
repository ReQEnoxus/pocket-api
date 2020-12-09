//
//  ResponseEntity.swift
//  PocketAPI
//
//  Created by Enoxus on 29.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

struct ResponseEntity: Codable {
    
    let status: Int
    let message: String
    
    static func asJson(status: Int, message: String) -> Data {
        
        let coder = JSONEncoder()
        let entity = ResponseEntity(status: status, message: message)
        
        return try! coder.encode(entity)
    }
}
