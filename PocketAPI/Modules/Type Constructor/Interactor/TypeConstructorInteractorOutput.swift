//
//  TypeConstructorInteractorOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

protocol TypeConstructorInteractorOutput: AnyObject {
    func didFinishLoadingCustomTypes(types: [Type])
    func didFinishCreatingType()
    func didFinishTask(with error: Error)
    func didSetCurrentType(_ type: BasicType?)
}
