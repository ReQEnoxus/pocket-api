//
//  EntityError.swift
//  PocketAPI
//
//  Created by Enoxus on 13.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

enum EntityError: Error {
    case dependencyCheckFailed
}

extension EntityError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dependencyCheckFailed:
            return "It's impossible to delete the entity if some other entity depends on it"
        }
    }
}
