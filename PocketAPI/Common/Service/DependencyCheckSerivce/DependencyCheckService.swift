//
//  DependencyCheckService.swift
//  PocketAPI
//
//  Created by Enoxus on 13.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

protocol DependencyCheckServiceProtocol {
    func isPossibleToDelete(type: Type) -> Bool
}

final class DependencyCheckService: DependencyCheckServiceProtocol {
    
    private let manager: TypeManager
    
    init(
        manager: TypeManager = TypeManagerWrapper.shared
    ) {
        self.manager = manager
    }
    func isPossibleToDelete(type: Type) -> Bool {
        return manager.availableTypes
            .filter { $0.name != type.name }
            .map { $0.attributes.values }
            .reduce([]) { acc, next in acc + next }
            .filter { isBasicTypeDependant(type: $0, on: type) }
            .isEmpty
    }
    
    private func isBasicTypeDependant(type: BasicType, on other: Type) -> Bool {
        switch type {
        case .primitive:
            return false
        case .custom(let name):
            return other.name == name
        case .array(let subtype):
            return isBasicTypeDependant(type: subtype, on: other)
        }
    }
}
