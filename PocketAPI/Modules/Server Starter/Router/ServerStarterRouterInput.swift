//
//  ServerStarterRouterInput.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ServerStarterRouterInput: AnyObject {
    
    /// tells router to dismiss current controller
    func dismiss()
    
    /// tells router to show error alert with given message
    /// - Parameter message: message to display
    func showErrorAlert(message: String)
}
