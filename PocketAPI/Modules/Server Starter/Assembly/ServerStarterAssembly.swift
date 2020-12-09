//
//  ServerStarterAssembly.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ServerStarterAssembly {
    
    class func configureModule(types: [Type]) -> UIViewController {
        
        let view = ServerStarterViewController()
        let presenter = ServerStarterPresenter()
        let interactor = ServerStarterInteractor()
        let router = ServerStarterRouter()
        
        let server = ServerServiceImpl.shared
        let documentationService = DocsGeneratorImpl(types: types)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.types = types
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.server = server
        interactor.presenter = presenter
        interactor.documentationService = documentationService
        
        router.view = view
        
        return UINavigationController(rootViewController: view)
    }
}
