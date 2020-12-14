//
//  ServerService.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

protocol ServerService: AnyObject {
    
    /// state of the server
    var state: ServerState { get }
    
    /// shared instance of server service
    static var shared: ServerService { get }
    
    /// starts the server on default port (1337)
    /// - Parameter types: types that server is able to work with
    func startServer(for types: [Type])
    
    /// immediately stops running server
    func stopServer()
}

/// possible states of the server
enum ServerState {
    
    case up(ip: String, port: String)
    case startingUp
    case down
    case error(description: String)
}
