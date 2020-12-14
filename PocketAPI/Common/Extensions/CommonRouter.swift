//
//  CommonRouter.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

protocol CommonRouter {
    
    var view: UIViewController? { get }
    
    /// tells router to present error alert with given message
    /// - Parameter message: message to display
    func showErrorAlert(message: String)
}

extension CommonRouter {
    func showErrorAlert(message: String) {
        view?.present(UIAlertController.messageAlert(title: "Error", message: message, tintColor: .systemGreen), animated: true)
    }
}
