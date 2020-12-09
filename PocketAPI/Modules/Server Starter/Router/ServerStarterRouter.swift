//
//  ServerStarterRouter.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ServerStarterRouter: ServerStarterRouterInput {
    
    weak var view: UIViewController!
    
    func dismiss() {
        view.dismiss(animated: true)
    }
    
    func showErrorAlert(message: String) {
        view.present(UIAlertController.messageAlert(title: "Error", message: message, tintColor: .systemGreen), animated: true)
    }
}
