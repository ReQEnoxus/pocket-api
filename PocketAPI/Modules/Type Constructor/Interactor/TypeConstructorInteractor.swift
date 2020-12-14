//
//  TypeConstructorInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

final class TypeConstructorInteractor: TypeConstructorInteractorInput {
    
    weak var presenter: TypeConstructorInteractorOutput!
    var typeManager: TypeManager!
    var currentType: BasicType?
    
    func loadCustomTypes() {
        presenter.didFinishLoadingCustomTypes(types: typeManager.availableTypes)
    }
    
    func registerTypeAndNotify() {
        guard let type = currentType else {
            return presenter.didFinishTask(with: TypeConstructorError.noCurrentType)
        }
        NotificationCenter.default.post(name: .didCreateNewBasicType, object: nil, userInfo: [UserInfoKeys.newBasicType: type])
        presenter.didFinishCreatingType()
    }
    
    func setCurrentType(with type: BasicType?) {
        currentType = type
        presenter.didSetCurrentType(currentType)
    }
    
    func encloseCurrentTypeInArray() {
        guard let currentType = currentType else {
            return presenter.didFinishTask(with: TypeConstructorError.cannotEncloseWithArray)
        }
        self.currentType = .array(of: currentType)
        presenter.didSetCurrentType(self.currentType)
    }
}
