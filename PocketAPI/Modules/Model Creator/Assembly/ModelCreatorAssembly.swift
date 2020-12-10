//
//  ModelCreatorAssembly.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import Entity

class ModelCreatorAssembly {
    
    class func configureModule(usedNames: [String]) -> UIViewController {
        
        let view = ModelCreatorViewController()
        let dataSource = ModelCreatorDataSourceImpl()
        let presenter = ModelCreatorPresenter()
        let interactor = ModelCreatorInteractor()
        let router = ModelCreatorRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.dataSource = dataSource
        presenter.interactor = interactor
        presenter.router = router
        presenter.alreadyUsedNames = usedNames
        
        router.view = view
        
        interactor.presenter = presenter
        interactor.typeManager = BasicTypeManager.shared
        
        return UINavigationController(rootViewController: view)
    }
}
