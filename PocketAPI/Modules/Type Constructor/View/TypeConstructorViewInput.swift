//
//  TypeConstructorViewInput.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol TypeConstructorViewInput: AnyObject {
    
    func display(type: String)
    func display(viewModel: AvailableTypesViewModel)
    func reset()
}
