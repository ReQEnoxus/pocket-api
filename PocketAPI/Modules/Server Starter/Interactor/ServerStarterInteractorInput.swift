//
//  ServerStarterInteractorInput.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ServerStarterInteractorInput: AnyObject {
    
    /// tells interactor to subscribe to server state change notifications
    func subscribeToServerNotifications()
    
    /// tells interactor to toggle the server (switch it on or off based on state)
    /// - Parameter types: types for which the server should generate endpoints
    func serverToggle(types: [Type])
}
