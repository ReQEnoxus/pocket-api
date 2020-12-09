//
//  ModelCreatorRouterInput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelCreatorRouterInput: AnyObject {
    
    /// tells router to dismiss the module
    func dismiss()
    
    /// tells router to present field creator modal
    /// - Parameter usedFieldNames: array of already used field names
    func presentFieldCreator(_ usedFieldNames: [String])
    
    /// tells router to present error alert with given message
    /// - Parameter message: message to display
    func showErrorAlert(message: String)
}
