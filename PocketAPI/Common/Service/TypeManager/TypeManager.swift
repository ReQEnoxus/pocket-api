//
//  TypeManager.swift
//  PocketAPI
//
//  Created by Enoxus on 13.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

final class TypeManagerWrapper: TypeManager {
    
    private var _instance: BasicTypeManager!
    private static let defaultsKey = "type-manager-key"
    private let defaults = UserDefaults.standard
    
    static let shared: TypeManager = TypeManagerWrapper()
    
    func new(named: String) -> TypeBuilder {
        return _instance.new(named: named)
    }
    
    func type(named: String) -> Type? {
        return _instance.type(named: named)
    }
    
    func deleteType(named: String) {
        _instance.deleteType(named: named)
        saveInstance()
    }
    
    func register(type: Type) {
        _instance.register(type: type)
        saveInstance()
    }
    
    var availableTypes: [Type] { return _instance.availableTypes }
    
    private init() {
        restoreInstance()
    }
    
    private func saveInstance() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(_instance) else { return }
        defaults.set(data, forKey: TypeManagerWrapper.defaultsKey)
    }
    
    private func restoreInstance() {
        guard let data = defaults.data(forKey: TypeManagerWrapper.defaultsKey) else {
            _instance = BasicTypeManager()
            return
        }
        let decoder = JSONDecoder()
        _instance = try! decoder.decode(BasicTypeManager.self, from: data)
    }
}
