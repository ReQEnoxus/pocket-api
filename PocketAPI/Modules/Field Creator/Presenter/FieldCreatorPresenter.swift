//
//  FieldCreatorPresenter.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class FieldCreatorPresenter: FieldCreatorViewOutput {
    
    var router: FieldCreatorRouterInput!
    var interactor: FieldCreatorInteractorInput!
    
    var usedNames: [String]!
    
    func didPressedCancel() {
        router.dismiss()
    }
    
    func didPressedCreate(name: String?, selectedIndex: Int?) {
        
        guard let name = name, !name.isEmpty, let index = selectedIndex else {
            
            router.showErrorAlert(message: "Please, specify a name for the field")
            return
        }
        if usedNames.contains(name) {
            router.showErrorAlert(message: "Please, use unique name for the field")
        }
        else {
            
            let field = NameTypePair(name: name
                                            .replacingOccurrences(of: " ", with: String())
                                            .replacingOccurrences(of: ".", with: String()),
                                     type: SupportedPrimitives.availableCases()[index])
            interactor.createFieldAndNotify(field)
            router.dismiss()
        }
    }
}
