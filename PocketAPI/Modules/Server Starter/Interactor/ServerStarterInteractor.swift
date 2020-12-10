//
//  ServerStarterInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

class ServerStarterInteractor: ServerStarterInteractorInput {
    
    weak var presenter: ServerStarterInteractorOutput!
    var server: ServerService!
    var documentationService: DocsGenerator!
    
    func subscribeToServerNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(_:)), name: .didChangeServerState, object: .none)
        
        if case .up(let ip, let port) = server.state {
            presenter.didFinishStartingServerWith(docs: documentationService.generateDocs(ip: ip, port: port))
        }
        
        // to let presenter know about current state of server
        presenter.didReceiveServerStateChangeNotification(server.state)
    }
    
    func serverToggle(types: [Type]) {
        
        if types.isEmpty {
            
            presenter.didFinishStartingServerWithError(message: "You should create at least one model in order to start a server")
            return
        }
        
        switch server.state {
            
        case .down, .error:
            server.startServer(for: types)
        default:
            server.stopServer()
        }
    }
    
    //MARK: - Observer
    @objc func didReceiveNotification(_ notification: Notification) {
        
        guard let state = notification.userInfo?[UserInfoKeys.serverState] as? ServerState else { return }
        
        if case .up(let ip, let port) = state {
            presenter.didFinishStartingServerWith(docs: documentationService.generateDocs(ip: ip, port: port))
        }
        
        presenter.didReceiveServerStateChangeNotification(state)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
