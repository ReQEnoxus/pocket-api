//
//  FieldCreatorRouter.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import Entity

class FieldCreatorRouter: FieldCreatorRouterInput {
    
    weak var view: UIViewController!
    
    func dismiss() {
        view.dismiss(animated: true)
    }
    
    func showErrorAlert(message: String) {
        
        view.present(UIAlertController.messageAlert(title: "Error", message: message, tintColor: .systemGreen), animated: true)
    }
    
    func showTypeConstructor(with type: BasicType? = nil) {
        view.present(TypeConstructorAssembly.configureModule(type: type), animated: true)
    }
}
