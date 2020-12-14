//
//  EntityStorage.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

protocol EntityStorage: AnyObject {
    
    /// synchronously returns all entities of given type
    /// - Parameter type: type of requested entities
    func getAllInstances(of type: Type) -> [Entity]
    
    /// get concrete instance by time and id
    /// - Parameters:
    ///   - type: type of entity
    ///   - id: id of entity
    func getInstance(of type: Type, by id: Int) -> Entity?
    
    /// saves entity into database, also manages ids, uniqueness must be ensured
    /// - Parameter instance: instance to save
    func saveInstance(_ instance: Entity) -> Entity
    
    /// deletes instance from database
    /// - Parameters:
    ///   - type: type of entity
    ///   - id: id of entity
    func deleteInstance(of type: Type, by id: Int)
    
    func deleteAllInstances(of type: Type)
}
