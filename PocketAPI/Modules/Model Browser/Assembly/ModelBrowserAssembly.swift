//
//  ModelBrowserAssembly.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ModelBrowserAssembly {
    
    class func configureModule() -> UIViewController {
        
        let view = ModelBrowserViewController()
        let dataSource = ModelBrowserDataSourceImpl()
        let presenter = ModelBrowserPresenter()
        let router = ModelBrowserRouter()
        let interactor = ModelBrowserInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.dataSource = dataSource
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.view = view
        
        dataSource.delegate = presenter
        
        return UINavigationController(rootViewController: view)
    }
}
