//
//  ModelBrowserRouterInput.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelBrowserRouterInput: AnyObject {
    
    /// tells router to present model creator module
    /// - Parameter usedNames: list of already used names
    func presentModelCreator(usedNames: [String])
    
    /// tells router to present server starter module
    /// - Parameter types: list of types to start server with
    func presentServerStarter(types: [Type])
    
    /// tells router to present error alert with given message
    /// - Parameter message: message to display
    func showErrorAlert(message: String)
}
