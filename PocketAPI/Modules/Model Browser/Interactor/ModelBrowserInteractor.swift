//
//  ModelBrowserInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

class ModelBrowserInteractor: ModelBrowserInteractorInput {
    
    weak var presenter: ModelBrowserInteractorOutput!
    var entityStorage: EntityStorage!
    var dependencyCheckService: DependencyCheckServiceProtocol!
    
    func subscribeToTypeCreationNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNewTypeCreationNotification(_:)), name: .didCreateNewType, object: .none)
    }
    
    func subscribeToServerStateNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveServerStateChangeNotification(_:)), name: .didChangeServerState, object: .none)
    }
    
    func loadInitialTypes() {
        presenter.didLoadInitialTypes(TypeManagerWrapper.shared.availableTypes)
    }
    
    func deleteType(by name: String) {
        guard let type = TypeManagerWrapper.shared.type(named: name) else { return }
        if dependencyCheckService.isPossibleToDelete(type: type) {
            TypeManagerWrapper.shared.deleteType(named: name)
            entityStorage.deleteAllInstances(of: type)
            presenter.didDeleteItemSuccessfully()
        }
        else {
            presenter.didFinishTaskWith(error: EntityError.dependencyCheckFailed)
        }
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
