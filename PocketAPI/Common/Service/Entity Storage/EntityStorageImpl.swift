//
//  EntityStorageImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class EntityStorageImpl: EntityStorage {
    
    var storage = [Entity]()
    
    private let storageQueue = DispatchQueue(label: "storage_queue")
    
    func getAllInstances(of type: Type) -> [Entity] {
        return storage.filter({ $0.type.name == type.name })
    }
    
    func getInstance(of type: Type, by id: Int) -> Entity? {
        return storage.filter({ $0.type.name == type.name && $0.fields["id"] is Int && $0.fields["id"] as! Int == id }).first
    }
    
    func saveInstance(_ instance: Entity) -> Entity {
        
        return storageQueue.sync {
            
            var instanceToAdd = instance
            
            guard let lastOfThisType = storage.last(where: { $0.type.name == instance.type.name }), lastOfThisType.fields["id"] is Int, let id = lastOfThisType.fields["id"] as? Int else {
                
                instanceToAdd.fields["id"] = Int.zero
                storage.append(instanceToAdd)
                return instanceToAdd
            }
            
            instanceToAdd.fields["id"] = id + 1
            storage.append(instanceToAdd)
            
            return instanceToAdd
        }
    }
    
    func deleteInstance(of type: Type, by id: Int) {
        
        storageQueue.sync {
            storage.removeAll(where: { $0.type.name == type.name && $0.fields["id"] is Int && $0.fields["id"] as! Int == id })
        }
    }
}
