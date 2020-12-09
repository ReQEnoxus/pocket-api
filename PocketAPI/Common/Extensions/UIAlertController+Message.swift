//
//  UIAlertController+Message.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /// returns an instance of alert with given title, message and tint color
    /// - Parameters:
    ///   - title: desired title of alert
    ///   - message: desired message of alert
    ///   - tintColor: tint color for button
    /// - Returns: instance of UIAlertController
    static func messageAlert(title: String, message: String, tintColor: UIColor) -> UIAlertController {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: .none)
        alert.view.tintColor = tintColor
        
        alert.addAction(action)
        
        return alert
    }
}
