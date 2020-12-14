//
//  ModelCreatorRouter.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ModelCreatorRouter: CommonRouter, ModelCreatorRouterInput {
    
    weak var view: UIViewController?
    
    func dismiss() {
        view?.dismiss(animated: true)
    }
    
    func presentFieldCreator(_ usedFieldNames: [String]) {
        
        view?.present(FieldCreatorAssembly.configureModule(usedNames: usedFieldNames), animated: true)
    }
}
