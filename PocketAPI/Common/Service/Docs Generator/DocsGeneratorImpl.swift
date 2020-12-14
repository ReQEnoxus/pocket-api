//
//  DocsGeneratorImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

class DocsGeneratorImpl: DocsGenerator {
    
    var types: [Type]
    
    init(types: [Type]) {
        self.types = types
    }
    
    func generateDocs(ip: String, port: String) -> Documentation {
        
        var entries = [DocumentationEntry]()
        
        for type in types {
            
            for requestType in SupportedRequests.allCases {
                
                switch requestType {
                
                case .getAll:
                    entries.append(DocumentationEntry(endpoint: "@GET \(ip):\(port)/\(type.name.lowercased())", description: requestType.rawValue))
                case .getById:
                    entries.append(DocumentationEntry(endpoint: "@GET \(ip):\(port)/\(type.name.lowercased())/{id}", description: requestType.rawValue))
                case .addEntity:
                    entries.append(DocumentationEntry(endpoint: "@POST \(ip):\(port)/\(type.name.lowercased())", description: requestType.rawValue))
                case .deleteEntity:
                    entries.append(DocumentationEntry(endpoint: "@DELETE \(ip):\(port)/\(type.name.lowercased())/{id}", description: requestType.rawValue))
                }
            }
        }
        
        return Documentation(entries: entries)
    }
}
