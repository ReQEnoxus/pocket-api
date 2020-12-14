//
//  FieldCreatorInteractorOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Entity

protocol FieldCreatorInteractorOutput: AnyObject {
    func didCreateNewType(type: BasicType)
}
