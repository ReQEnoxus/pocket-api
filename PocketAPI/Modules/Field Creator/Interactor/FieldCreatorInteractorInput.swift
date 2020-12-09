//
//  FieldCreatorInteractorInput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol FieldCreatorInteractorInput: AnyObject {
    
    /// tells interactor to create a field and notify observers of its creation
    /// - Parameter field: field contents
    func createFieldAndNotify(_ field: NameTypePair)
}
