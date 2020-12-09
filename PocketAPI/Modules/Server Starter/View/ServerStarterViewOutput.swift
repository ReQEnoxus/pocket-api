//
//  ServerStarterViewOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ServerStarterViewOutput: AnyObject {
    
    /// tells presenter that user has tapped on server toggle button
    func serverToggle()
    
    /// tells presenter that view has just finished loading and is ready for some external setup
    func initialSetup()
    
    /// tells presenter that user has tapped close button
    func closeButtonTapped()
}
