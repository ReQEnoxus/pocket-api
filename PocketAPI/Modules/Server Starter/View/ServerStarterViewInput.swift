//
//  ServerStarterViewInput.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ServerStarterViewInput: AnyObject {
    
    /// tells view to set prompt text with given message
    /// - Parameter message: message to set to prompt
    func updatePrompt(with message: String)
    
    /// tells view to update the title of the button
    /// - Parameter title: title to set to the button
    func updateButton(with title: String)
    
    /// tells view to set loading indicator to button or remove it
    /// - Parameter loading: boolean value that indicates whether loading indicator should be shown or not
    func setLoading(_ loading: Bool)
    
    /// tells view to set documentation string below the button
    /// - Parameter docs: text of the docs to set
    func setDocumentation(_ docs: String)
}
