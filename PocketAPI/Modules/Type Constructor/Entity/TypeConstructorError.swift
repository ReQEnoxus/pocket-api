//
//  TypeConstructorError.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

enum TypeConstructorError: Error {
    case cannotEncloseWithArray
    case noCurrentType
}

extension TypeConstructorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cannotEncloseWithArray:
            return "Primitive or custom type should be specified in order to be enclosed with array"
        case .noCurrentType:
            return "Impossible to create new field because no type has been specified"
        }
    }
}
