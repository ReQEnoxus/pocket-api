//
//  ModelCreatorViewOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelCreatorViewOutput: AnyObject {
    
    /// tells presenter that view is loaded and ready for external initial setup
    func initialSetup()
    
    /// tells presenter that add button was pressed
    func addButtonPressed()
    
    /// tells presenter that submit button was pressed
    /// - Parameter name: name of the model that is being created
    func submitButtonPressed(name: String?)
    
    /// tells presenter that cancel button was pressed
    func cancelButtonPressed()
}
