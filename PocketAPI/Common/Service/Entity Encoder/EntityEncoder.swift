//
//  EntityEncoder.swift
//  PocketAPI
//
//  Created by Enoxus on 23.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol EntityEncoder: AnyObject {
    
    /// encodes given entity into json data
    /// - Parameter obj: object to encode
    func encode(_ obj: Entity) -> Data?
    
    /// encodes array of entities into json data
    /// - Parameter objects: array of entities
    func encode(objects: [Entity]) -> Data?
}
