//
//  ModelCreatorInteractorInput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelCreatorInteractorInput: AnyObject {
    
    /// tells interactor to subscribe to field creation notifications
    func subscribeToNameTypePairCreation()
    
    /// tells interactor to create a type instance and send notification about that
    /// - Parameters:
    ///   - name: name of the type
    ///   - fields: fields of the type
    func createTypeAndNotify(name: String, fields: [NameTypePair])
}
