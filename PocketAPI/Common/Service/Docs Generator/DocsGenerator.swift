//
//  DocsGenerator.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol DocsGenerator: AnyObject {
    
    /// types for which the docs will be generated
    var types: [Type] { get }
    
    /// generates documentation entity for given ip address and port
    /// - Parameters:
    ///   - ip: ip address
    ///   - port: port where server is accepting requests
    func generateDocs(ip: String, port: String) -> Documentation
}
