//
//  ModelBrowserInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ModelBrowserInteractor: ModelBrowserInteractorInput {
    
    weak var presenter: ModelBrowserInteractorOutput!
    
    func subscribeToTypeCreationNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNewTypeCreationNotification(_:)), name: .didCreateNewType, object: .none)
    }
    
    func subscribeToServerStateNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveServerStateChangeNotification(_:)), name: .didChangeServerState, object: .none)
    }
    
    //MARK: - Observer
    @objc func didReceiveNewTypeCreationNotification(_ notification: Notification) {
        
        guard let type = notification.userInfo?[UserInfoKeys.newType] as? Type else { return }
        presenter.didReceiveNotification(with: type)
    }
    
    @objc func didReceiveServerStateChangeNotification(_ notification: Notification) {
        
        guard let state = notification.userInfo?[UserInfoKeys.serverState] as? ServerState else { return }
        
        switch state {
            
        case .up, .startingUp:
            presenter.didReceiveServerStateChangeNotification(shouldTurnImmutable: true)
        default:
            presenter.didReceiveServerStateChangeNotification(shouldTurnImmutable: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
