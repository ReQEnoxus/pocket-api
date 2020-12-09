//
//  ModelCreatorInteractorOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelCreatorInteractorOutput: AnyObject {
    
    /// tells presenter that new field was created
    /// - Parameter nameTypePair: created field
    func didReceiveNotification(for nameTypePair: NameTypePair)
}
