//
//  TypeFormatter.swift
//  PocketAPI
//
//  Created by Enoxus on 09.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

final class TypeFormatter {
    class func representation(of type: BasicType) -> String {
        switch type {
        case let .primitive(primitive):
            switch primitive {
            case .number:
                return "Number"
            case .string:
                return "String"
            case .bool:
                return "Bool"
            }
        case let .custom(name):
            return name.capitalized
        case let .array(basic):
            return "[\(representation(of: basic))]"
        }
    }
}
