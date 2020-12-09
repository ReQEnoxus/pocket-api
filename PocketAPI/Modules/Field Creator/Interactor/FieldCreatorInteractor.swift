//
//  FieldCreatorInteractor.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class FieldCreatorInteractor: FieldCreatorInteractorInput {
    
    func createFieldAndNotify(_ field: NameTypePair) {
        NotificationCenter.default.post(name: .didCreateNewNameTypePair, object: .none, userInfo: [UserInfoKeys.newField: field])
    }
}
