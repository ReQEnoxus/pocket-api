//
//  TypeConstructorAssembly.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import Entity

final class TypeConstructorAssembly {
    
    class func configureModule(type: BasicType? = nil) -> UIViewController {
        let view = TypeConstructorViewController()
        let presenter = TypeConstructorPresenter()
        let router = TypeConstructorRouter()
        let interactor = TypeConstructorInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.view = view
        
        interactor.presenter = presenter
        interactor.typeManager = TypeManagerWrapper.shared
        interactor.setCurrentType(with: type)
        
        return UINavigationController(rootViewController: view)
    }
}
