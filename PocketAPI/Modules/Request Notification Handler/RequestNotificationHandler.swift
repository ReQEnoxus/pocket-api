//
//  RequestNotificationHandler.swift
//  PocketAPI
//
//  Created by Enoxus on 29.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol RequestNotificationHandler: AnyObject {
    
    /// tells notification handler to subscribe to notifications
    func subscribeToNotifications()
    
    /// tells handler to remove subscription
    func removeSubscription()
}
