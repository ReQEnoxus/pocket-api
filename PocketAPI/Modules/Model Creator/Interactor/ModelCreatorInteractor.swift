//
//  ModelCreatorInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ModelCreatorInteractor: ModelCreatorInteractorInput {
    
    weak var presenter: ModelCreatorInteractorOutput!
    
    func subscribeToNameTypePairCreation() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(_:)), name: .didCreateNewNameTypePair, object: .none)
    }
    
    func createTypeAndNotify(name: String, fields: [NameTypePair]) {
        
        var typeFields: [String: SupportedPrimitives] = [:]
        
        fields.forEach({ field in
            
            guard let primitive = SupportedPrimitives.fromStringRepresentation(field.type) else { return }
            
            return typeFields[field.name] = primitive
        })
        
        let type = Type(name: name, types: typeFields)
        
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
