//
//  EntityEncoderImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 23.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class EntityEncoderImpl: EntityEncoder {
    
    func encode(_ obj: Entity) -> Data? {
        return try? JSONSerialization.data(withJSONObject: obj.fields, options: .prettyPrinted)
    }
    
    func encode(objects: [Entity]) -> Data? {
        
        var arrayToEncode = [[String: Codable]]()
        
        objects.forEach({ arrayToEncode.append($0.fields) })
        
        return try? JSONSerialization.data(withJSONObject: arrayToEncode, options: .prettyPrinted)
    }
}
