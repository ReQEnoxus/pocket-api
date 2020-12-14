//
//  FieldCreatorRouterInput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Entity

protocol FieldCreatorRouterInput: AnyObject {
    
    /// tells router to dismiss current controller
    func dismiss()
    
    /// tells router to show error alert with given message
    /// - Parameter message: message to display
    func showErrorAlert(message: String)
    
    func showTypeConstructor(with type: BasicType?)
}
