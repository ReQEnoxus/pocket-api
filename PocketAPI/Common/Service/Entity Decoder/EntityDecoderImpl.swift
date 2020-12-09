//
//  EntityDecoderImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 23.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class EntityDecoderImpl: EntityDecoder {
    
    func decode(_ data: Data, of type: Type) -> Entity? {
        
        var successful = true
        var fields = [String: Codable]()
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        if let singleObject = json as? [String: Any] {
            
            // type checking
            for (name, primitive) in type.types {
                
                if name == "id" {
                    continue
                }
                
                if let field = singleObject[name] {
                    
                    switch primitive {
                    
                    case .string:
                        
                        if field is String {
                            fields[name] = field as! String
                        }
                        else {
                            
                            successful = false
                            break
                        }
                    case .number:
                        
                        if field is Int {
                            fields[name] = field as! Int
                        }
                        else if field is Double {
                            fields[name] = field as! Double
                        }
                        else {
                            
                            successful = false
                            break
                        }
                    case .boolean:
                        
                        if field is Bool {
                            fields[name] = field as! Bool
                        }
                        else {
                            
                            successful = false
                            break
                        }
                    case .array(let type):
                        switch type {
                            
                        case .boolean:
                            if field is [Bool] {
                                fields[name] = field as! Bool
                            }
                            else {
                                
                                successful = false
                                break
                            }
                        case .number:
                            if field is [Int] {
                                fields[name] = field as! [Int]
                            }
                            else if field is [Double] {
                                fields[name] = field as! [Double]
                            }
                            else {
                                
                                successful = false
                                break
                            }
                        case .string:
                            if field is [String] {
                                fields[name] = field as! [String]
                            }
                            else {
                                
                                successful = false
                                break
                            }
                        case .array:
                            successful = false
                            break
                        }
                    }
                }
                else {
                    successful = false
                    break
                }
            }
        }
        else {
            // object is not a valid json
            successful = false
        }
        
        if successful {
            return Entity(type: type, fields: fields)
        }
        else {
            return .none
        }
    }
}
