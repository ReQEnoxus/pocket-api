//
//  EntityDecoder.swift
//  PocketAPI
//
//  Created by Enoxus on 23.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol EntityDecoder: AnyObject {
    
    /// tries to decode entity from data
    /// - Parameters:
    ///   - data: data to decode from
    ///   - type: expected type of entity
    func decode(_ data: Data, of type: Type) -> Entity?
}
