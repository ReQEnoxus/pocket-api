//
//  ModelCreatorInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

class ModelCreatorInteractor: ModelCreatorInteractorInput {
    
    weak var presenter: ModelCreatorInteractorOutput!
    var typeManager: TypeManager!
    
    func subscribeToNameTypePairCreation() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(_:)), name: .didCreateNewNameTypePair, object: .none)
    }
    
    func createTypeAndNotify(name: String, fields: [NameTypePair]) {
        var typeFields: Dictionary<String, BasicType> = [:]
        fields.forEach {
            typeFields[$0.name] = $0.type
        }
        let type = Type(name: name, attributes: typeFields)
        
        typeManager.register(type: type)
        
        NotificationCenter.default.post(name: .didCreateNewType, object: .none, userInfo: [UserInfoKeys.newType: type])
    }
    
    //MARK: - Observer
    @objc func didReceiveNotification(_ notification: Notification) {
        
        guard let nameTypePair = notification.userInfo?[UserInfoKeys.newField] as? NameTypePair else { return }
        presenter.didReceiveNotification(for: nameTypePair)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
