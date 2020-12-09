//
//  ModelBrowserViewOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ModelBrowserViewOutput: AnyObject {
    
    /// tells presenter that view is loaded and ready for external initial setup
    func initialSetup()
    
    /// tells presenter that user has pulled the table
    func didPullTable()
    
    /// tells presenter that user has pressed start server button
    func didPressedStartServer()
}
