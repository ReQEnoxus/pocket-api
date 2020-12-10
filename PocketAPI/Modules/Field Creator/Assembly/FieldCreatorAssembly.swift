//
//  FieldCreatorAssembly.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class FieldCreatorAssembly {
    
    class func configureModule(usedNames: [String]) -> UIViewController {
        
        let view = FieldCreatorViewController()
        let presenter = FieldCreatorPresenter()
        let router = FieldCreatorRouter()
        let interactor = FieldCreatorInteractor()
        
        view.presenter = presenter
        view.modalPresentationStyle = .overCurrentContext
        view.modalTransitionStyle = .crossDissolve
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        presenter.usedNames = usedNames
        
        router.view = view
        
        interactor.presenter = presenter
        
        return view
    }
}
