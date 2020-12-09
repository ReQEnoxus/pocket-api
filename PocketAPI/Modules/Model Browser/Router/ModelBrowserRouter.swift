//
//  ModelBrowserRouter.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ModelBrowserRouter: ModelBrowserRouterInput {
    
    weak var view: UIViewController!
    
    func presentModelCreator(usedNames: [String]) {
        view.present(ModelCreatorAssembly.configureModule(usedNames: usedNames), animated: true)
    }
    
    func presentServerStarter(types: [Type]) {
        view.present(ServerStarterAssembly.configureModule(types: types), animated: true)
    }
    
    func showErrorAlert(message: String) {
        
        view.present(UIAlertController.messageAlert(title: "Error", message: message, tintColor: .systemGreen), animated: true)
    }
}
