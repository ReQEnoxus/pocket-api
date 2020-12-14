//
//  ModelBrowserInteractorInput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelBrowserInteractorInput: AnyObject {
    
    /// tells interactor to subscribe to type creation notifications
    func subscribeToTypeCreationNotifications()
    
    /// tells interactor to subscribe to server state changes
    func subscribeToServerStateNotifications()
    
    func loadInitialTypes()
    
    func deleteType(by name: String)
}
