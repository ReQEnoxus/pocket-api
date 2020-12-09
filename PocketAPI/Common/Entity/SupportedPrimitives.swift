//
//  SupportedPrimitives.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// currently supported primitive types of models
indirect enum SupportedPrimitives {
    
    case string
    case number
    case boolean
    case array(type: SupportedPrimitives)
    
    static func stringRepresentation(_ primitive: SupportedPrimitives) -> String? {
        
        switch primitive {
            
        case .string:
            return "String"
        case .number:
            return "Number"
        case .boolean:
            return "Bool"
        case .array(let arrayType):
            
            switch arrayType {
                
            case .string:
                return "[String]"
            case .boolean:
                return "[Bool]"
            case .number:
                return "[Number]"
            case .array:
                return .none
            }
        }
    }
    
    static func fromStringRepresentation(_ string: String) -> SupportedPrimitives? {
        
        switch string {
            
        case "String":
            return .string
        case "Number":
            return .number
        case "Bool":
            return .boolean
        case "[String]":
            return .array(type: .string)
        case "[Number]":
            return .array(type: .number)
        case "[Bool]":
            return .array(type: .boolean)
        default:
            return .none
        }
    }
    
    static func availableCases() -> [String] {
        
        let availableCases: [SupportedPrimitives] = [
            
            .string,
            .number,
            .boolean,
            .array(type: .string),
            .array(type: .number),
            .array(type: .boolean)
        ]
        
        return availableCases.compactMap({
            SupportedPrimitives.stringRepresentation($0)
        })
    }
}
