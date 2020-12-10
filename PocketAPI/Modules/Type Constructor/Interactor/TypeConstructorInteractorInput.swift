//
//  TypeConstructorInteractorInput.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

protocol TypeConstructorInteractorInput: AnyObject {
    func loadCustomTypes()
    func registerTypeAndNotify()
    func setCurrentType(with type: BasicType?)
    func encloseCurrentTypeInArray()
}
