//
//  FieldCreatorInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

class FieldCreatorInteractor: FieldCreatorInteractorInput {
    
    weak var presenter: FieldCreatorInteractorOutput!
    
    func createFieldAndNotify(_ field: NameTypePair) {
        NotificationCenter.default.post(name: .didCreateNewNameTypePair, object: .none, userInfo: [UserInfoKeys.newField: field])
    }
    
    func startObservingNewBasicTypeNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(_:)), name: .didCreateNewBasicType, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func didReceiveNotification(_ notification: Notification) {
        guard let type = notification.userInfo?[UserInfoKeys.newBasicType] as? BasicType else { return }
        presenter.didCreateNewType(type: type)
    }
}
