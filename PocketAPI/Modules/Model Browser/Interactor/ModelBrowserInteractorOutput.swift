//
//  ModelBrowserInteractorOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelBrowserInteractorOutput: AnyObject {
    
    /// tells presenter that new type creation notification was received
    /// - Parameter type: new created type
    func didReceiveNotification(with type: Type)
    
    /// tells presenter that server has changed its state and whether data source should turn immutable or not
    /// - Parameter shouldTurnImmutable: should data source turn immutable
    func didReceiveServerStateChangeNotification(shouldTurnImmutable: Bool)
}
