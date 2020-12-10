//
//  ServerStarterPresenter.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

class ServerStarterPresenter: ServerStarterViewOutput, ServerStarterInteractorOutput {
    
    weak var view: ServerStarterViewInput!
    var interactor: ServerStarterInteractorInput!
    var router: ServerStarterRouterInput!
    
    var types: [Type]!
    
    //MARK: - View Output
    func serverToggle() {
        interactor.serverToggle(types: types)
    }
    
    func initialSetup() {
        interactor.subscribeToServerNotifications()
    }
    
    func closeButtonTapped() {
        router.dismiss()
    }
    
    //MARK: - Interactor Output
    func didReceiveServerStateChangeNotification(_ state: ServerState) {
        
        switch state {

        case .up(let ip, let port):
            
            view.setLoading(false)
            view.updateButton(with: "Stop Server")
            view.updatePrompt(with: "REST server has successfully started on: \(ip):\(port)")
        case .startingUp:
            
            view.setLoading(true)
            view.updatePrompt(with: "Server is starting up. Please wait a few seconds...")
            view.setDocumentation(String())
        case .down:
            
            view.setLoading(false)
            view.updateButton(with: "Start Server")
            view.updatePrompt(with: "Tap the button above to start the server")
            view.setDocumentation(String())
        case .error(let description):
            
            view.setLoading(false)
            view.updateButton(with: "Start Server")
            view.updatePrompt(with: "An error occured while starting the server, reason: \(description)")
            view.setDocumentation(String())
        }
    }
    
    func didFinishStartingServerWith(docs: Documentation) {
        
        var documentation = "Available Endpoints:"
        var index = Int.zero
        let indent = SupportedRequests.allCases.count
        
        for entry in docs.entries {
            
            if index % indent == .zero {
                documentation.append("\n")
            }
            
            documentation.append("\(entry.endpoint) - \(entry.description)\n")
            
            index += 1
        }
        
        view.setDocumentation(documentation)
    }
    
    func didFinishStartingServerWithError(message: String) {
        router.showErrorAlert(message: message)
    }
}
