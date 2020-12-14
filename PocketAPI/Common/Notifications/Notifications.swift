//
//  Notifications.swift
//  PocketAPI
//
//  Created by Enoxus on 29.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    /// fires up each time when new type is created in Model Creator module
    static let didCreateNewType = Notification.Name("didCreateNewType")
    
    /// fires up each time when new type value pair in Field Creator module
    static let didCreateNewNameTypePair = Notification.Name("didCreateNewTypeValuePair")
    
    /// fires up each time when new basic type is created
    static let didCreateNewBasicType = Notification.Name("didCreateNewBasicType")
    
    /// fires up each time when server changes its state
    static let didChangeServerState = Notification.Name("didChangeServerState")
    
    /// fires up each time when server catches http request
    static let didCatchRequest = Notification.Name("didCatchRequest")
}
