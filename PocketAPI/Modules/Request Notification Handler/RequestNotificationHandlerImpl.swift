//
//  RequestNotificationHandlerImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 29.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import NotificationBannerSwift

class RequestNotificationHandlerImpl: RequestNotificationHandler {
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .didCatchRequest, object: .none)
    }
    
    func removeSubscription() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        
        guard let requestNotification = notification.userInfo?[UserInfoKeys.requestInfo] as? RequestNotification else { return }
        
        let title = "@\(requestNotification.method.uppercased()) \(requestNotification.path)"
        
        let banner = StatusBarNotificationBanner(title: title, style: .success, colors: .none)
        
        NotificationBannerQueue.default.removeAll()
        
        banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: .none)
    }
}
