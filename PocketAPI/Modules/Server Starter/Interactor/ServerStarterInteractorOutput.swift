//
//  ServerStarterInteractorOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ServerStarterInteractorOutput: AnyObject {
    
    /// tells presenter that server has changed its state
    /// - Parameter state: new state
    func didReceiveServerStateChangeNotification(_ state: ServerState)
    
    /// tells presenter that server has failed to start
    /// - Parameter message: reason why it's happened
    func didFinishStartingServerWithError(message: String)
    
    /// tells presenter that server has successfully started and passes the documentation to it
    /// - Parameter docs: documentation of created endpoints
    func didFinishStartingServerWith(docs: Documentation)
}
