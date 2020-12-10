//
//  FieldCreatorViewOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol FieldCreatorViewOutput: AnyObject {
    
    /// tells presenter that cancel button was pressed
    func didPressedCancel()
    
    /// tells presenter that user has tapped on create button
    /// - Parameters:
    ///   - name: name of the field
    func didPressedCreate(name: String?)
}
